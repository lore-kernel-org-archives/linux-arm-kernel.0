From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 27 Aug 2013 18:44:12 -0700
Subject: [PATCH 8/9] clk: sunxi: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-8-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
 <1376298847-21828-8-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20130828014412.8231.96003@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2013-08-12 02:14:06)
> __initconst should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Emilio L?pez <emilio@elopez.com.ar>

Thanks much for this cleanup! I've applied all of the patches in this
series. This patch required reflow due to recent changes to the sunxi
clock driver. Below is what I merged. Let me know if there are any
issues.

Regards,
Mike



>From 52be7cc862942ea0a53031b3b1ca84dc95422b5b Mon Sep 17 00:00:00 2001
From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 12 Aug 2013 14:44:06 +0530
Subject: [PATCH] clk: sunxi: Fix incorrect placement of __initconst
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
[mturquette at linaro.org: refreshed patch based on sunxi changes]
---
 drivers/clk/sunxi/clk-sunxi.c | 60 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index d39f213..34ee69f 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -288,17 +288,17 @@ static struct clk_factors_config sun4i_apb1_config = {
 	.pwidth = 2,
 };
 
-static const __initconst struct factors_data sun4i_pll1_data = {
+static const struct factors_data sun4i_pll1_data __initconst = {
 	.table = &sun4i_pll1_config,
 	.getter = sun4i_get_pll1_factors,
 };
 
-static const __initconst struct factors_data sun6i_a31_pll1_data = {
+static const struct factors_data sun6i_a31_pll1_data __initconst = {
 	.table = &sun6i_a31_pll1_config,
 	.getter = sun6i_a31_get_pll1_factors,
 };
 
-static const __initconst struct factors_data sun4i_apb1_data = {
+static const struct factors_data sun4i_apb1_data __initconst = {
 	.table = &sun4i_apb1_config,
 	.getter = sun4i_get_apb1_factors,
 };
@@ -336,15 +336,15 @@ struct mux_data {
 	u8 shift;
 };
 
-static const __initconst struct mux_data sun4i_cpu_mux_data = {
+static const struct mux_data sun4i_cpu_mux_data __initconst = {
 	.shift = 16,
 };
 
-static const __initconst struct mux_data sun6i_a31_ahb1_mux_data = {
+static const struct mux_data sun6i_a31_ahb1_mux_data __initconst = {
 	.shift = 12,
 };
 
-static const __initconst struct mux_data sun4i_apb1_mux_data = {
+static const struct mux_data sun4i_apb1_mux_data __initconst = {
 	.shift = 24,
 };
 
@@ -385,25 +385,25 @@ struct div_data {
 	u8	width;
 };
 
-static const __initconst struct div_data sun4i_axi_data = {
+static const struct div_data sun4i_axi_data __initconst = {
 	.shift	= 0,
 	.pow	= 0,
 	.width	= 2,
 };
 
-static const __initconst struct div_data sun4i_ahb_data = {
+static const struct div_data sun4i_ahb_data __initconst = {
 	.shift	= 4,
 	.pow	= 1,
 	.width	= 2,
 };
 
-static const __initconst struct div_data sun4i_apb0_data = {
+static const struct div_data sun4i_apb0_data __initconst = {
 	.shift	= 8,
 	.pow	= 1,
 	.width	= 2,
 };
 
-static const __initconst struct div_data sun6i_a31_apb2_div_data = {
+static const struct div_data sun6i_a31_apb2_div_data __initconst = {
 	.shift	= 0,
 	.pow	= 0,
 	.width	= 4,
@@ -443,67 +443,67 @@ struct gates_data {
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
 
-static const __initconst struct gates_data sun5i_a10s_ahb_gates_data = {
+static const struct gates_data sun5i_a10s_ahb_gates_data __initconst = {
 	.mask = {0x147667e7, 0x185915},
 };
 
-static const __initconst struct gates_data sun5i_a13_ahb_gates_data = {
+static const struct gates_data sun5i_a13_ahb_gates_data __initconst = {
 	.mask = {0x107067e7, 0x185111},
 };
 
-static const __initconst struct gates_data sun6i_a31_ahb1_gates_data = {
+static const struct gates_data sun6i_a31_ahb1_gates_data __initconst = {
 	.mask = {0xEDFE7F62, 0x794F931},
 };
 
-static const __initconst struct gates_data sun7i_a20_ahb_gates_data = {
+static const struct gates_data sun7i_a20_ahb_gates_data __initconst = {
 	.mask = { 0x12f77fff, 0x16ff3f },
 };
 
-static const __initconst struct gates_data sun4i_apb0_gates_data = {
+static const struct gates_data sun4i_apb0_gates_data __initconst = {
 	.mask = {0x4EF},
 };
 
-static const __initconst struct gates_data sun5i_a10s_apb0_gates_data = {
+static const struct gates_data sun5i_a10s_apb0_gates_data __initconst = {
 	.mask = {0x469},
 };
 
-static const __initconst struct gates_data sun5i_a13_apb0_gates_data = {
+static const struct gates_data sun5i_a13_apb0_gates_data __initconst = {
 	.mask = {0x61},
 };
 
-static const __initconst struct gates_data sun7i_a20_apb0_gates_data = {
+static const struct gates_data sun7i_a20_apb0_gates_data __initconst = {
 	.mask = { 0x4ff },
 };
 
-static const __initconst struct gates_data sun4i_apb1_gates_data = {
+static const struct gates_data sun4i_apb1_gates_data __initconst = {
 	.mask = {0xFF00F7},
 };
 
-static const __initconst struct gates_data sun5i_a10s_apb1_gates_data = {
+static const struct gates_data sun5i_a10s_apb1_gates_data __initconst = {
 	.mask = {0xf0007},
 };
 
-static const __initconst struct gates_data sun5i_a13_apb1_gates_data = {
+static const struct gates_data sun5i_a13_apb1_gates_data __initconst = {
 	.mask = {0xa0007},
 };
 
-static const __initconst struct gates_data sun6i_a31_apb1_gates_data = {
+static const struct gates_data sun6i_a31_apb1_gates_data __initconst = {
 	.mask = {0x3031},
 };
 
-static const __initconst struct gates_data sun6i_a31_apb2_gates_data = {
+static const struct gates_data sun6i_a31_apb2_gates_data __initconst = {
 	.mask = {0x3F000F},
 };
 
-static const __initconst struct gates_data sun7i_a20_apb1_gates_data = {
+static const struct gates_data sun7i_a20_apb1_gates_data __initconst = {
 	.mask = { 0xff80ff },
 };
 
@@ -557,7 +557,7 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
 }
 
 /* Matches for factors clocks */
-static const __initconst struct of_device_id clk_factors_match[] = {
+static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-pll1-clk", .data = &sun4i_pll1_data,},
 	{.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
 	{.compatible = "allwinner,sun4i-apb1-clk", .data = &sun4i_apb1_data,},
@@ -565,7 +565,7 @@ static const __initconst struct of_device_id clk_factors_match[] = {
 };
 
 /* Matches for divider clocks */
-static const __initconst struct of_device_id clk_div_match[] = {
+static const struct of_device_id clk_div_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-axi-clk", .data = &sun4i_axi_data,},
 	{.compatible = "allwinner,sun4i-ahb-clk", .data = &sun4i_ahb_data,},
 	{.compatible = "allwinner,sun4i-apb0-clk", .data = &sun4i_apb0_data,},
@@ -574,7 +574,7 @@ static const __initconst struct of_device_id clk_div_match[] = {
 };
 
 /* Matches for mux clocks */
-static const __initconst struct of_device_id clk_mux_match[] = {
+static const struct of_device_id clk_mux_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-cpu-clk", .data = &sun4i_cpu_mux_data,},
 	{.compatible = "allwinner,sun4i-apb1-mux-clk", .data = &sun4i_apb1_mux_data,},
 	{.compatible = "allwinner,sun6i-a31-ahb1-mux-clk", .data = &sun6i_a31_ahb1_mux_data,},
@@ -582,7 +582,7 @@ static const __initconst struct of_device_id clk_mux_match[] = {
 };
 
 /* Matches for gate clocks */
-static const __initconst struct of_device_id clk_gates_match[] = {
+static const struct of_device_id clk_gates_match[] __initconst = {
 	{.compatible = "allwinner,sun4i-axi-gates-clk", .data = &sun4i_axi_gates_data,},
 	{.compatible = "allwinner,sun4i-ahb-gates-clk", .data = &sun4i_ahb_gates_data,},
 	{.compatible = "allwinner,sun5i-a10s-ahb-gates-clk", .data = &sun5i_a10s_ahb_gates_data,},
-- 
1.8.1.2
