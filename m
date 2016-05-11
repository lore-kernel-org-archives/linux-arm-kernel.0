From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:01:59 +0200
Subject: [PATCH 03/18] clk: samsung: exynos3250: Constify all clock
 initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index e26b04fea33b..057c3f0d0e35 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -103,7 +103,7 @@
 #define PWR_CTRL1_USE_CORE1_WFI			(1 << 1)
 #define PWR_CTRL1_USE_CORE0_WFI			(1 << 0)
 
-static unsigned long exynos3250_cmu_clk_regs[] __initdata = {
+static const unsigned long exynos3250_cmu_clk_regs[] __initconst = {
 	SRC_LEFTBUS,
 	DIV_LEFTBUS,
 	GATE_IP_LEFTBUS,
@@ -226,7 +226,7 @@ PNAME(group_sclk_fimd0_p)	= { "xxti", "xusbxti",
 PNAME(mout_mfc_p)		= { "mout_mfc_0", "mout_mfc_1" };
 PNAME(mout_g3d_p)		= { "mout_g3d_0", "mout_g3d_1" };
 
-static struct samsung_fixed_factor_clock fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "sclk_mpll_1600", "mout_mpll", 1, 1, 0),
 	FFACTOR(0, "sclk_mpll_mif", "mout_mpll", 1, 2, 0),
 	FFACTOR(0, "sclk_bpll", "fout_bpll", 1, 2, 0),
@@ -237,7 +237,7 @@ static struct samsung_fixed_factor_clock fixed_factor_clks[] __initdata = {
 	FFACTOR(CLK_FIN_PLL, "fin_pll", "xusbxti", 1, 1, 0),
 };
 
-static struct samsung_mux_clock mux_clks[] __initdata = {
+static const struct samsung_mux_clock mux_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -326,7 +326,7 @@ static struct samsung_mux_clock mux_clks[] __initdata = {
 			CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_div_clock div_clks[] __initdata = {
+static const struct samsung_div_clock div_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -429,7 +429,7 @@ static struct samsung_div_clock div_clks[] __initdata = {
 	DIV(CLK_DIV_COPY, "div_copy", "mout_hpm", DIV_CPU1, 0, 3),
 };
 
-static struct samsung_gate_clock gate_clks[] __initdata = {
+static const struct samsung_gate_clock gate_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -669,7 +669,7 @@ static struct samsung_gate_clock gate_clks[] __initdata = {
 };
 
 /* APLL & MPLL & BPLL & UPLL */
-static struct samsung_pll_rate_table exynos3250_pll_rates[] = {
+static const struct samsung_pll_rate_table exynos3250_pll_rates[] = {
 	PLL_35XX_RATE(1200000000, 400, 4, 1),
 	PLL_35XX_RATE(1100000000, 275, 3, 1),
 	PLL_35XX_RATE(1066000000, 533, 6, 1),
@@ -691,7 +691,7 @@ static struct samsung_pll_rate_table exynos3250_pll_rates[] = {
 };
 
 /* EPLL */
-static struct samsung_pll_rate_table exynos3250_epll_rates[] = {
+static const struct samsung_pll_rate_table exynos3250_epll_rates[] = {
 	PLL_36XX_RATE(800000000, 200, 3, 1,     0),
 	PLL_36XX_RATE(288000000,  96, 2, 2,     0),
 	PLL_36XX_RATE(192000000, 128, 2, 3,     0),
@@ -710,7 +710,7 @@ static struct samsung_pll_rate_table exynos3250_epll_rates[] = {
 };
 
 /* VPLL */
-static struct samsung_pll_rate_table exynos3250_vpll_rates[] = {
+static const struct samsung_pll_rate_table exynos3250_vpll_rates[] __initconst = {
 	PLL_36XX_RATE(600000000, 100, 2, 1,     0),
 	PLL_36XX_RATE(533000000, 266, 3, 2, 32768),
 	PLL_36XX_RATE(519230987, 173, 2, 2,  5046),
@@ -740,7 +740,7 @@ static struct samsung_pll_rate_table exynos3250_vpll_rates[] = {
 	{ /* sentinel */ }
 };
 
-static struct samsung_pll_clock exynos3250_plls[] __initdata = {
+static const struct samsung_pll_clock exynos3250_plls[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_APLL, "fout_apll", "fin_pll",
 		APLL_LOCK, APLL_CON0, exynos3250_pll_rates),
 	PLL(pll_35xx, CLK_FOUT_MPLL, "fout_mpll", "fin_pll",
@@ -772,7 +772,7 @@ static void __init exynos3_core_down_clock(void __iomem *reg_base)
 	__raw_writel(0x0, reg_base + PWR_CTRL2);
 }
 
-static struct samsung_cmu_info cmu_info __initdata = {
+static const struct samsung_cmu_info cmu_info __initconst = {
 	.pll_clks		= exynos3250_plls,
 	.nr_pll_clks		= ARRAY_SIZE(exynos3250_plls),
 	.mux_clks		= mux_clks,
@@ -848,7 +848,7 @@ CLK_OF_DECLARE(exynos3250_cmu, "samsung,exynos3250-cmu", exynos3250_cmu_init);
 #define EPLL_CON2		0x111c
 #define SRC_EPLL		0x1120
 
-static unsigned long exynos3250_cmu_dmc_clk_regs[] __initdata = {
+static const unsigned long exynos3250_cmu_dmc_clk_regs[] __initconst = {
 	BPLL_LOCK,
 	BPLL_CON0,
 	BPLL_CON1,
@@ -874,7 +874,7 @@ PNAME(mout_bpll_p)	= { "fin_pll", "fout_bpll", };
 PNAME(mout_mpll_mif_p)	= { "fin_pll", "sclk_mpll_mif", };
 PNAME(mout_dphy_p)	= { "mout_mpll_mif", "mout_bpll", };
 
-static struct samsung_mux_clock dmc_mux_clks[] __initdata = {
+static const struct samsung_mux_clock dmc_mux_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -893,7 +893,7 @@ static struct samsung_mux_clock dmc_mux_clks[] __initdata = {
 	MUX(CLK_MOUT_EPLL, "mout_epll", mout_epll_p, SRC_EPLL, 4, 1),
 };
 
-static struct samsung_div_clock dmc_div_clks[] __initdata = {
+static const struct samsung_div_clock dmc_div_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -910,14 +910,14 @@ static struct samsung_div_clock dmc_div_clks[] __initdata = {
 	DIV(CLK_DIV_DMCD, "div_dmcd", "div_dmc", DIV_DMC1, 11, 3),
 };
 
-static struct samsung_pll_clock exynos3250_dmc_plls[] __initdata = {
+static const struct samsung_pll_clock exynos3250_dmc_plls[] __initconst = {
 	PLL(pll_35xx, CLK_FOUT_BPLL, "fout_bpll", "fin_pll",
 		BPLL_LOCK, BPLL_CON0, exynos3250_pll_rates),
 	PLL(pll_36xx, CLK_FOUT_EPLL, "fout_epll", "fin_pll",
 		EPLL_LOCK, EPLL_CON0, exynos3250_epll_rates),
 };
 
-static struct samsung_cmu_info dmc_cmu_info __initdata = {
+static const struct samsung_cmu_info dmc_cmu_info __initconst = {
 	.pll_clks		= exynos3250_dmc_plls,
 	.nr_pll_clks		= ARRAY_SIZE(exynos3250_dmc_plls),
 	.mux_clks		= dmc_mux_clks,
@@ -947,7 +947,7 @@ CLK_OF_DECLARE(exynos3250_cmu_dmc, "samsung,exynos3250-cmu-dmc",
 #define GATE_IP_ISP1		0x804
 #define GATE_SCLK_ISP		0x900
 
-static struct samsung_div_clock isp_div_clks[] __initdata = {
+static const struct samsung_div_clock isp_div_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -967,7 +967,7 @@ static struct samsung_div_clock isp_div_clks[] __initdata = {
 	DIV(CLK_DIV_MPWM, "div_mpwm", "div_isp1", DIV_ISP1, 0, 3),
 };
 
-static struct samsung_gate_clock isp_gate_clks[] __initdata = {
+static const struct samsung_gate_clock isp_gate_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by register address in ascending
 	 * order and then bitfield shift in descending order, as it is done
@@ -1063,7 +1063,7 @@ static struct samsung_gate_clock isp_gate_clks[] __initdata = {
 		GATE_SCLK_ISP, 0, CLK_IGNORE_UNUSED, 0),
 };
 
-static struct samsung_cmu_info isp_cmu_info __initdata = {
+static const struct samsung_cmu_info isp_cmu_info __initconst = {
 	.div_clks	= isp_div_clks,
 	.nr_div_clks	= ARRAY_SIZE(isp_div_clks),
 	.gate_clks	= isp_gate_clks,
-- 
1.9.1
