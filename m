From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 11 Jul 2013 14:32:09 +0530
Subject: [PATCH 1/6] clk: exynos4: Staticize local symbols
In-Reply-To: <1373533334-5169-1-git-send-email-sachin.kamat@linaro.org>
References: <1373533334-5169-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1373533334-5169-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Symbols referenced only in this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos4.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 1bdb882..18eadc4 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -338,24 +338,24 @@ PNAME(mout_user_aclk200_p4x12) = {"fin_pll", "div_aclk200", };
 PNAME(mout_user_aclk266_gps_p4x12) = {"fin_pll", "div_aclk266_gps", };
 
 /* fixed rate clocks generated outside the soc */
-struct samsung_fixed_rate_clock exynos4_fixed_rate_ext_clks[] __initdata = {
+static struct samsung_fixed_rate_clock exynos4_fixed_rate_ext_clks[] __initdata = {
 	FRATE(xxti, "xxti", NULL, CLK_IS_ROOT, 0),
 	FRATE(xusbxti, "xusbxti", NULL, CLK_IS_ROOT, 0),
 };
 
 /* fixed rate clocks generated inside the soc */
-struct samsung_fixed_rate_clock exynos4_fixed_rate_clks[] __initdata = {
+static struct samsung_fixed_rate_clock exynos4_fixed_rate_clks[] __initdata = {
 	FRATE(none, "sclk_hdmi24m", NULL, CLK_IS_ROOT, 24000000),
 	FRATE(none, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 27000000),
 	FRATE(none, "sclk_usbphy0", NULL, CLK_IS_ROOT, 48000000),
 };
 
-struct samsung_fixed_rate_clock exynos4210_fixed_rate_clks[] __initdata = {
+static struct samsung_fixed_rate_clock exynos4210_fixed_rate_clks[] __initdata = {
 	FRATE(none, "sclk_usbphy1", NULL, CLK_IS_ROOT, 48000000),
 };
 
 /* list of mux clocks supported in all exynos4 soc's */
-struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
+static struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
 	MUX_FA(mout_apll, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
 			CLK_SET_RATE_PARENT, 0, "mout_apll"),
 	MUX(none, "mout_hdmi", mout_hdmi_p, SRC_TV, 0, 1),
@@ -372,7 +372,7 @@ struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
 };
 
 /* list of mux clocks supported in exynos4210 soc */
-struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
+static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 	MUX(none, "mout_aclk200", sclk_ampll_p4210, SRC_TOP0, 12, 1),
 	MUX(none, "mout_aclk100", sclk_ampll_p4210, SRC_TOP0, 16, 1),
 	MUX(none, "mout_aclk160", sclk_ampll_p4210, SRC_TOP0, 20, 1),
@@ -423,7 +423,7 @@ struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 };
 
 /* list of mux clocks supported in exynos4x12 soc */
-struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
+static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 	MUX_A(mout_mpll_user_c, "mout_mpll_user_c", mout_mpll_user_p4x12,
 			SRC_CPU, 24, 1, "mout_mpll"),
 	MUX(none, "mout_aclk266_gps", aclk_p4412, SRC_TOP1, 4, 1),
@@ -491,7 +491,7 @@ struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 };
 
 /* list of divider clocks supported in all exynos4 soc's */
-struct samsung_div_clock exynos4_div_clks[] __initdata = {
+static struct samsung_div_clock exynos4_div_clks[] __initdata = {
 	DIV(none, "div_core", "mout_core", DIV_CPU0, 0, 3),
 	DIV(none, "div_core2", "div_core", DIV_CPU0, 28, 3),
 	DIV(none, "div_fimc0", "mout_fimc0", DIV_CAM, 0, 4),
@@ -554,7 +554,7 @@ struct samsung_div_clock exynos4_div_clks[] __initdata = {
 };
 
 /* list of divider clocks supported in exynos4210 soc */
-struct samsung_div_clock exynos4210_div_clks[] __initdata = {
+static struct samsung_div_clock exynos4210_div_clks[] __initdata = {
 	DIV(aclk200, "aclk200", "mout_aclk200", DIV_TOP, 0, 3),
 	DIV(sclk_fimg2d, "sclk_fimg2d", "mout_g2d", DIV_IMAGE, 0, 4),
 	DIV(none, "div_fimd1", "mout_fimd1", E4210_DIV_LCD1, 0, 4),
@@ -565,7 +565,7 @@ struct samsung_div_clock exynos4210_div_clks[] __initdata = {
 };
 
 /* list of divider clocks supported in exynos4x12 soc */
-struct samsung_div_clock exynos4x12_div_clks[] __initdata = {
+static struct samsung_div_clock exynos4x12_div_clks[] __initdata = {
 	DIV(none, "div_mdnie0", "mout_mdnie0", DIV_LCD0, 4, 4),
 	DIV(none, "div_mdnie_pwm0", "mout_mdnie_pwm0", DIV_LCD0, 8, 4),
 	DIV(none, "div_mdnie_pwm_pre0", "div_mdnie_pwm0", DIV_LCD0, 12, 4),
@@ -590,7 +590,7 @@ struct samsung_div_clock exynos4x12_div_clks[] __initdata = {
 };
 
 /* list of gate clocks supported in all exynos4 soc's */
-struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
+static struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 	/*
 	 * After all Exynos4 based platforms are migrated to use device tree,
 	 * the device name and clock alias names specified below for some
@@ -782,7 +782,7 @@ struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 };
 
 /* list of gate clocks supported in exynos4210 soc */
-struct samsung_gate_clock exynos4210_gate_clks[] __initdata = {
+static struct samsung_gate_clock exynos4210_gate_clks[] __initdata = {
 	GATE(tvenc, "tvenc", "aclk160", GATE_IP_TV, 2, 0, 0),
 	GATE(g2d, "g2d", "aclk200", E4210_GATE_IP_IMAGE, 0, 0, 0),
 	GATE(rotator, "rotator", "aclk200", E4210_GATE_IP_IMAGE, 1, 0, 0),
@@ -817,7 +817,7 @@ struct samsung_gate_clock exynos4210_gate_clks[] __initdata = {
 };
 
 /* list of gate clocks supported in exynos4x12 soc */
-struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
+static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 	GATE(audss, "audss", "sclk_epll", E4X12_GATE_IP_MAUDIO, 0, 0, 0),
 	GATE(mdnie0, "mdnie0", "aclk160", GATE_IP_LCD0, 2, 0, 0),
 	GATE(rotator, "rotator", "aclk200", E4X12_GATE_IP_IMAGE, 1, 0, 0),
@@ -975,7 +975,7 @@ static void __init exynos4_clk_register_finpll(unsigned long xom)
  * clock speed.
  */
 void __init exynos4_clk_register_fixed_ext(unsigned long xxti_f,
-						unsigned long xusbxti_f)
+						  unsigned long xusbxti_f)
 {
 	exynos4_fixed_rate_ext_clks[0].fixed_rate = xxti_f;
 	exynos4_fixed_rate_ext_clks[1].fixed_rate = xusbxti_f;
@@ -990,7 +990,9 @@ static __initdata struct of_device_id ext_clk_match[] = {
 };
 
 /* register exynos4 clocks */
-void __init exynos4_clk_init(struct device_node *np, enum exynos4_soc exynos4_soc, void __iomem *reg_base, unsigned long xom)
+static void __init exynos4_clk_init(struct device_node *np,
+				    enum exynos4_soc exynos4_soc,
+				    void __iomem *reg_base, unsigned long xom)
 {
 	struct clk *apll, *mpll, *epll, *vpll;
 
-- 
1.7.9.5
