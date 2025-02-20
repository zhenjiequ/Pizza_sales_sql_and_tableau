SELECT *
FROM pizza_sales

--A.KPI's

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales

SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales

--B.Hourly Trend for Total Pizzas Sold

SELECT DATEPART(HOUR, order_time) AS order_hours, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--C.Weekly Trend for Orders
SELECT DATEPART(ISO_WEEK, order_date) AS WeekNumber,
       YEAR(order_date) AS Order_Year,
       COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY WeekNumber

--D.% of Sales by Pizza Category
SELECT pizza_category,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
	   CAST((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100 AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT DESC;

--% of Sales by Pizza Category by month

SELECT pizza_category,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
	   CAST((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1)) * 100 AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
ORDER BY PCT DESC;

--E.% of Sales by Pizza Size
SELECT pizza_size,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
	   CAST((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100 AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

--% of Sales by Pizza Size by quarter

SELECT pizza_size,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
	   CAST((SUM(total_price) / (SELECT SUM(total_price) FROM pizza_sales)) * 100 AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

--F. Total Pizzas Sold by Pizza Category
SELECT pizza_category,
       SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

--G. Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;

--H. Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC;

--I. Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name,
       SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity DESC;

--J. Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name,
       SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity ASC;

--K. Top 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC;

--L. Bottom 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC;