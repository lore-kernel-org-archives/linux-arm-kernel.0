From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:02 +0200
Subject: [PATCH 06/18] clk: samsung: exynos4415: Constify all clock
 initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos4415.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4415.c b/drivers/clk/samsung/clk-exynos4415.c
index 86ee06b226bd..1a9e9d039a3f 100644
--- a/drivers/clk/samsung/clk-exynos4415.c
+++ b/drivers/clk/samsung/clk-exynos4415.c
@@ -111,7 +111,7 @@
 #define DIV_CPU0		0x14500
 #define DIV_CPU1		0x14504
 
-static unsigned long exynos4415_cmu_clk_regs[] __initdata = {
+static const unsigned long exynos4415_cmu_clk_regs[] __initconst = {
 	SRC_LEFTBUS,
 	DIV_LEFTBUS,
 	GATE_IP_LEFTBUS,
@@ -268,16 +268,16 @@ PNAME(group_aclk_isp0_300_user_p) = { "fin_pll", "mout_aclk_isp0_300" };
 PNAME(group_aclk_isp1_300_user_p) = { "fin_pll", "mout_aclk_isp1_300" };
 PNAME(group_mout_mpll_user_t_p)	= { "mout_mpll_user_t" };
 
-static struct samsung_fixed_factor_clock exynos4415_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock exynos4415_fixed_factor_clks[] __initconst = {
 	/* HACK: fin_pll hardcoded to xusbxti until detection is implemented. */
 	FFACTOR(CLK_FIN_PLL, "fin_pll", "xusbxti", 1, 1, 0),
 };
 
-static struct samsung_fixed_rate_clock exynos4415_fixed_rate_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock exynos4415_fixed_rate_clks[] __initconst = {
 	FRATE(CLK_SCLK_HDMIPHY, "sclk_hdmiphy", NULL, 0, 27000000),
 };
 
-static struct samsung_mux_clock exynos4415_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos4415_mux_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -427,7 +427,7 @@ static struct samsung_mux_clock exynos4415_mux_clks[] __initdata = {
 		group_aclk_isp1_300_user_p, SRC_TOP_ISP1, 0, 1),
 };
 
-static struct samsung_div_clock exynos4415_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos4415_div_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -566,7 +566,7 @@ static struct samsung_div_clock exynos4415_div_clks[] __initdata = {
 	DIV(CLK_DIV_COPY, "div_copy", "mout_hpm", DIV_CPU1, 0, 3),
 };
 
-static struct samsung_gate_clock exynos4415_gate_clks[] __initdata = {
+static const struct samsung_gate_clock exynos4415_gate_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -859,7 +859,7 @@ static struct samsung_gate_clock exynos4415_gate_clks[] __initdata = {
 /*
  * APLL & MPLL & BPLL & ISP_PLL & DISP_PLL & G3D_PLL
  */
-static struct samsung_pll_rate_table exynos4415_pll_rates[] = {
+static const struct samsung_pll_rate_table exynos4415_pll_rates[] = {
 	PLL_35XX_RATE(1600000000, 400, 3,  1),
 	PLL_35XX_RATE(1500000000, 250, 2,  1),
 	PLL_35XX_RATE(1400000000, 175, 3,  0),
@@ -891,7 +891,7 @@ static struct samsung_pll_rate_table exynos4415_pll_rates[] = {
 };
 
 /* EPLL */
-static struct samsung_pll_rate_table exynos4415_epll_rates[] = {
+static const struct samsung_pll_rate_table exynos4415_epll_rates[] = {
 	PLL_36XX_RATE(800000000, 200, 3, 1,     0),
 	PLL_36XX_RATE(288000000,  96, 2, 2,     0),
 	PLL_36XX_RATE(192000000, 128, 2, 3,     0),
@@ -909,7 +909,7 @@ static struct samsung_pll_rate_table exynos4415_epll_rates[] = {
 	{ /* sentinel */ }
 };
 
-static struct samsung_pll_clock exynos4415_plls[] __initdata = {
+static const struct samsung_pll_clock exynos4415_plls[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_APLL, "fout_apll", "fin_pll",
 		APLL_LOCK, APLL_CON0, exynos4415_pll_rates),
 	PLL(pll_36xx, CLK_FOUT_EPLL, "fout_epll", "fin_pll",
@@ -922,7 +922,7 @@ static struct samsung_pll_clock exynos4415_plls[] __initdata = {
 		"fin_pll", DISP_PLL_LOCK, DISP_PLL_CON0, exynos4415_pll_rates),
 };
 
-static struct samsung_cmu_info cmu_info __initdata = {
+static const struct samsung_cmu_info cmu_info __initconst = {
 	.pll_clks		= exynos4415_plls,
 	.nr_pll_clks		= ARRAY_SIZE(exynos4415_plls),
 	.mux_clks		= exynos4415_mux_clks,
@@ -961,7 +961,7 @@ CLK_OF_DECLARE(exynos4415_cmu, "samsung,exynos4415-cmu", exynos4415_cmu_init);
 #define SRC_DMC			0x300
 #define DIV_DMC1		0x504
 
-static unsigned long exynos4415_cmu_dmc_clk_regs[] __initdata = {
+static const unsigned long exynos4415_cmu_dmc_clk_regs[] __initconst = {
 	MPLL_LOCK,
 	MPLL_CON0,
 	MPLL_CON1,
@@ -978,14 +978,14 @@ PNAME(mout_mpll_p)		= { "fin_pll", "fout_mpll", };
 PNAME(mout_bpll_p)		= { "fin_pll", "fout_bpll", };
 PNAME(mbpll_p)			= { "mout_mpll", "mout_bpll", };
 
-static struct samsung_mux_clock exynos4415_dmc_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos4415_dmc_mux_clks[] __initconst = {
 	MUX(CLK_DMC_MOUT_MPLL, "mout_mpll", mout_mpll_p, SRC_DMC, 12, 1),
 	MUX(CLK_DMC_MOUT_BPLL, "mout_bpll", mout_bpll_p, SRC_DMC, 10, 1),
 	MUX(CLK_DMC_MOUT_DPHY, "mout_dphy", mbpll_p, SRC_DMC, 8, 1),
 	MUX(CLK_DMC_MOUT_DMC_BUS, "mout_dmc_bus", mbpll_p, SRC_DMC, 4, 1),
 };
 
-static struct samsung_div_clock exynos4415_dmc_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos4415_dmc_div_clks[] __initconst = {
 	DIV(CLK_DMC_DIV_DMC, "div_dmc", "div_dmc_pre", DIV_DMC1, 27, 3),
 	DIV(CLK_DMC_DIV_DPHY, "div_dphy", "mout_dphy", DIV_DMC1, 23, 3),
 	DIV(CLK_DMC_DIV_DMC_PRE, "div_dmc_pre", "mout_dmc_bus",
@@ -995,14 +995,14 @@ static struct samsung_div_clock exynos4415_dmc_div_clks[] __initdata = {
 	DIV(CLK_DMC_DIV_MPLL_PRE, "div_mpll_pre", "mout_mpll", DIV_DMC1, 8, 2),
 };
 
-static struct samsung_pll_clock exynos4415_dmc_plls[] __initdata = {
+static const struct samsung_pll_clock exynos4415_dmc_plls[] __initconst = {
 	PLL(pll_35xx, CLK_DMC_FOUT_MPLL, "fout_mpll", "fin_pll",
 		MPLL_LOCK, MPLL_CON0, exynos4415_pll_rates),
 	PLL(pll_35xx, CLK_DMC_FOUT_BPLL, "fout_bpll", "fin_pll",
 		BPLL_LOCK, BPLL_CON0, exynos4415_pll_rates),
 };
 
-static struct samsung_cmu_info cmu_dmc_info __initdata = {
+static const struct samsung_cmu_info cmu_dmc_info __initconst = {
 	.pll_clks		= exynos4415_dmc_plls,
 	.nr_pll_clks		= ARRAY_SIZE(exynos4415_dmc_plls),
 	.mux_clks		= exynos4415_dmc_mux_clks,
-- 
1.9.1
