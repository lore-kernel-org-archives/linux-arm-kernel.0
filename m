From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 12 Aug 2013 14:44:06 +0530
Subject: [PATCH 8/9] clk: sunxi: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1376298847-21828-8-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/clk/sunxi/clk-sunxi.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 02e440b..ec2ace6 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -196,12 +196,12 @@ static struct clk_factors_config apb1_config = {
 	.pwidth = 2,
 };
 
-static const __initconst struct factors_data pll1_data = {
+static const struct factors_data pll1_data __initconst = {
 	.table = &pll1_config,
 	.getter = sunxi_get_pll1_factors,
 };
 
-static const __initconst struct factors_data apb1_data = {
+static const struct factors_data apb1_data __initconst = {
 	.table = &apb1_config,
 	.getter = sunxi_get_apb1_factors,
 };
@@ -239,11 +239,11 @@ struct mux_data {
 	u8 shift;
 };
 
-static const __initconst struct mux_data cpu_mux_data = {
+static const struct mux_data cpu_mux_data __initconst = {
 	.shift = 16,
 };
 
-static const __initconst struct mux_data apb1_mux_data = {
+static const struct mux_data apb1_mux_data __initconst = {
 	.shift = 24,
 };
 
@@ -284,17 +284,17 @@ struct div_data {
 	u8 pow;
 };
 
-static const __initconst struct div_data axi_data = {
+static const struct div_data axi_data __initconst = {
 	.shift = 0,
 	.pow = 0,
 };
 
-static const __initconst struct div_data ahb_data = {
+static const struct div_data ahb_data __initconst = {
 	.shift = 4,
 	.pow = 1,
 };
 
-static const __initconst struct div_data apb0_data = {
+static const struct div_data apb0_data __initconst = {
 	.shift = 8,
 	.pow = 1,
 };
@@ -333,31 +333,31 @@ struct gates_data {
 	DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
 };
 
-static const __initconst struct gates_data sun4i_axi_gates_data = {
+static const struct gates_data sun4i_axi_gates_data __initconst = {
 	.mask = {1},
 };
 
-static const __initconst struct gates_data sun4i_ahb_gates_data = {
+static const struct gates_data sun4i_ahb_gates_data __initconst = {
 	.mask = {0x7F77FFF, 0x14FB3F},
 };
 
-static const __initconst struct gates_data sun5i_a13_ahb_gates_data = {
+static const struct gates_data sun5i_a13_ahb_gates_data __initconst = {
 	.mask = {0x107067e7, 0x185111},
 };
 
-static const __initconst struct gates_data sun4i_apb0_gates_data = {
+static const struct gates_data sun4i_apb0_gates_data __initconst = {
 	.mask = {0x4EF},
 };
 
-static const __initconst struct gates_data sun5i_a13_apb0_gates_data = {
+static const struct gates_data sun5i_a13_apb0_gates_data __initconst = {
 	.mask = {0x61},
 };
 
-static const __initconst struct gates_data sun4i_apb1_gates_data = {
+static const struct gates_data sun4i_apb1_gates_data __initconst = {
 	.mask = {0xFF00F7},
 };
 
-static const __initconst struct gates_data sun5i_a13_apb1_gates_data = {
+static const struct gates_data sun5i_a13_apb1_gates_data __initconst = {
 	.mask = {0xa0007},
 };
 
@@ -411,20 +411,20 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 }
 
 /* Matches for of_clk_init */
-static const __initconst struct of_device_id clk_match[] = {
+static const struct of_device_id clk_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-osc-clk", .data = sunxi_osc_clk_setup,},
 	{}
 };
 
 /* Matches for factors clocks */
-static const __initconst struct of_device_id clk_factors_match[] = {
+static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-pll1-clk", .data = &pll1_data,},
 	{.compatible = "allwinner,sun4i-apb1-clk", .data = &apb1_data,},
 	{}
 };
 
 /* Matches for divider clocks */
-static const __initconst struct of_device_id clk_div_match[] = {
+static const struct of_device_id clk_div_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-axi-clk", .data = &axi_data,},
 	{.compatible = "allwinner,sun4i-ahb-clk", .data = &ahb_data,},
 	{.compatible = "allwinner,sun4i-apb0-clk", .data = &apb0_data,},
@@ -432,14 +432,14 @@ static const __initconst struct of_device_id clk_div_match[] = {
 };
 
 /* Matches for mux clocks */
-static const __initconst struct of_device_id clk_mux_match[] = {
+static const struct of_device_id clk_mux_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-cpu-clk", .data = &cpu_mux_data,},
 	{.compatible = "allwinner,sun4i-apb1-mux-clk", .data = &apb1_mux_data,},
 	{}
 };
 
 /* Matches for gate clocks */
-static const __initconst struct of_device_id clk_gates_match[] = {
+static const struct of_device_id clk_gates_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-axi-gates-clk", .data = &sun4i_axi_gates_data,},
 	{.compatible = "allwinner,sun4i-ahb-gates-clk", .data = &sun4i_ahb_gates_data,},
 	{.compatible = "allwinner,sun5i-a13-ahb-gates-clk", .data = &sun5i_a13_ahb_gates_data,},
-- 
1.7.9.5
