show databases
use swiggy
show tables
select * from swiggyoneusers_signup
select * from users
select * from sales
select * from product

1. What is the total amount each customer is spending on swiggy?
select s.userid, SUM(p.price) totalAmount 
FROM sales s INNER JOIN product p
ON s.product_id = p.product_id
GROUP BY s.userid

2. What is the most purchased item on the menubar?
SELECT product_id, count(product_id) CNT 
FROM sales
GROUP BY product_id
ORDER BY CNT DESC
LIMIT 1


SELECT product_id
FROM sales
GROUP BY product_id
ORDER BY count(product_id) DESC
LIMIT 1

3. What was the first product purchased by each of the customers?
SELECT * FROM(
SELECT *, rank() over (partition by userid order by created_date) rnk from sales) res where rnk = 1

4. Which item was the most popular item for each customer?
SELECT * FROM (SELECT *,rank() OVER(PARTITION BY userid ORDER BY CNT DESC) rnk FROM(SELECT userid, product_id, count(product_id) CNT FROM sales GROUP BY userid, product_id)a)b WHERE rnk=1