From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 26 Aug 2013 19:02:33 +0300
Subject: [patch] clk: vt8500: several forever loops
Message-ID: <20130826154908.GD12428@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This does a bunch of looping like this:

	for (div2 = 7; div2 >= 0; div2--)

But unsigned values are always greater than or equal to zero so it just
loops and loops.  Really "mul", "div1" and "div2" should all be declared
as int for cleanliness sake.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker stuff.

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index 82306f5..8d5b57c 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -363,7 +363,7 @@ static void vt8500_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 static void wm8650_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				u32 *multiplier, u32 *divisor1, u32 *divisor2)
 {
-	u32 mul, div1, div2;
+	int mul, div1, div2;
 	u32 best_mul, best_div1, best_div2;
 	unsigned long tclk, rate_err, best_err;
 
@@ -431,7 +431,7 @@ static u32 wm8750_get_filter(u32 parent_rate, u32 divisor1)
 static void wm8750_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				u32 *filter, u32 *multiplier, u32 *divisor1, u32 *divisor2)
 {
-	u32 mul, div1, div2;
+	int mul, div1, div2;
 	u32 best_mul, best_div1, best_div2;
 	unsigned long tclk, rate_err, best_err;
 
@@ -475,7 +475,7 @@ static void wm8750_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 static void wm8850_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				u32 *multiplier, u32 *divisor1, u32 *divisor2)
 {
-	u32 mul, div1, div2;
+	int mul, div1, div2;
 	u32 best_mul, best_div1, best_div2;
 	unsigned long tclk, rate_err, best_err;
 
