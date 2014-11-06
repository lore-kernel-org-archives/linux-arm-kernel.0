From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Nov 2014 11:40:32 +0800
Subject: [PATCH resend 4/4] clk: sunxi: Removed unused/incorrect
 sun6i-a31-apb2-clk driver
In-Reply-To: <1415245232-20585-1-git-send-email-wens@csie.org>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
Message-ID: <1415245232-20585-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver does not match the hardware, which is actually compatible
to sun4i-a10-apb1-clk. Since we've switch to the correct one, drop
this driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt | 1 -
 drivers/clk/sunxi/clk-sunxi.c                     | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 6ddcf6e..d199f91 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -52,7 +52,6 @@ Required properties:
 	"allwinner,sun7i-a20-apb1-gates-clk" - for the APB1 gates on A20
 	"allwinner,sun8i-a23-apb1-gates-clk" - for the APB1 gates on A23
 	"allwinner,sun9i-a80-apb1-gates-clk" - for the APB1 gates on A80
-	"allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
 	"allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 4133e27..46d98e3 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -632,12 +632,6 @@ static const struct div_data sun4i_apb0_data __initconst = {
 	.table	= sun4i_apb0_table,
 };
 
-static const struct div_data sun6i_a31_apb2_div_data __initconst = {
-	.shift	= 0,
-	.pow	= 0,
-	.width	= 4,
-};
-
 static void __init sunxi_divider_clk_setup(struct device_node *node,
 					   struct div_data *data)
 {
@@ -1093,7 +1087,6 @@ static const struct of_device_id clk_div_match[] __initconst = {
 	{.compatible = "allwinner,sun8i-a23-axi-clk", .data = &sun8i_a23_axi_data,},
 	{.compatible = "allwinner,sun4i-a10-ahb-clk", .data = &sun4i_ahb_data,},
 	{.compatible = "allwinner,sun4i-a10-apb0-clk", .data = &sun4i_apb0_data,},
-	{.compatible = "allwinner,sun6i-a31-apb2-div-clk", .data = &sun6i_a31_apb2_div_data,},
 	{}
 };
 
-- 
2.1.1
