From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 18 Jul 2013 15:31:20 +0530
Subject: [PATCH 4/6] clk: exynos5420: Staticize local symbols
In-Reply-To: <1374141682-29432-1-git-send-email-sachin.kamat@linaro.org>
References: <1374141682-29432-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1374141682-29432-5-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Symbols referenced only in this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 68a96cb..125728a 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -262,12 +262,12 @@ PNAME(maudio0_p)	= { "fin_pll", "maudio_clk", "sclk_dpll", "sclk_mpll",
 			  "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
 
 /* fixed rate clocks generated outside the soc */
-struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[] __initdata = {
+static struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[] __initdata = {
 	FRATE(fin_pll, "fin_pll", NULL, CLK_IS_ROOT, 0),
 };
 
 /* fixed rate clocks generated inside the soc */
-struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata = {
+static struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata = {
 	FRATE(none, "sclk_hdmiphy", NULL, CLK_IS_ROOT, 24000000),
 	FRATE(none, "sclk_pwi", NULL, CLK_IS_ROOT, 24000000),
 	FRATE(none, "sclk_usbh20", NULL, CLK_IS_ROOT, 48000000),
@@ -275,11 +275,11 @@ struct samsung_fixed_rate_clock exynos5420_fixed_rate_clks[] __initdata = {
 	FRATE(none, "sclk_usbh20_scan_clk", NULL, CLK_IS_ROOT, 480000000),
 };
 
-struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
+static struct samsung_fixed_factor_clock exynos5420_fixed_factor_clks[] __initdata = {
 	FFACTOR(none, "sclk_hsic_12m", "fin_pll", 1, 2, 0),
 };
 
-struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
+static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(none, "mout_mspll_kfc", mspll_cpu_p, SRC_TOP7, 8, 2),
 	MUX(none, "mout_mspll_cpu", mspll_cpu_p, SRC_TOP7, 12, 2),
 	MUX(none, "mout_apll", apll_p, SRC_CPU, 0, 1),
@@ -399,7 +399,7 @@ struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(none, "mout_spi2", group2_p, SRC_PERIC1, 28, 3),
 };
 
-struct samsung_div_clock exynos5420_div_clks[] __initdata = {
+static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(none, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
 	DIV(none, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
 	DIV(none, "armclk2", "div_arm", DIV_CPU0, 28, 3),
@@ -479,7 +479,7 @@ struct samsung_div_clock exynos5420_div_clks[] __initdata = {
 	DIV(none, "dout_pre_spi2", "dout_spi2", DIV_PERIC4, 24, 8),
 };
 
-struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
+static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	/* TODO: Re-verify the CG bits for all the gate clocks */
 	GATE_A(mct, "pclk_st", "aclk66_psgen", GATE_BUS_PERIS1, 2, 0, 0, "mct"),
 
@@ -704,7 +704,7 @@ static __initdata struct of_device_id ext_clk_match[] = {
 };
 
 /* register exynos5420 clocks */
-void __init exynos5420_clk_init(struct device_node *np)
+static void __init exynos5420_clk_init(struct device_node *np)
 {
 	void __iomem *reg_base;
 	struct clk *apll, *bpll, *cpll, *dpll, *epll, *ipll, *kpll, *mpll;
-- 
1.7.9.5
