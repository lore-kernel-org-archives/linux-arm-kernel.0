From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:09 +0200
Subject: [PATCH 13/18] clk: samsung: exynos7: Constify all clock initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-13-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos7.c | 114 +++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index ad68d463b12c..45b348c0cfc6 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -36,7 +36,7 @@
 #define ENABLE_ACLK_TOPC1	0x0804
 #define ENABLE_SCLK_TOPC1	0x0A04
 
-static struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock topc_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ffac_topc_bus0_pll_div2", "mout_topc_bus0_pll", 1, 2, 0),
 	FFACTOR(0, "ffac_topc_bus0_pll_div4",
 		"ffac_topc_bus0_pll_div2", 1, 2, 0),
@@ -69,7 +69,7 @@ PNAME(mout_topc_mfc_pll_half_p) = { "mout_topc_mfc_pll",
 PNAME(mout_topc_bus0_pll_out_p) = {"mout_topc_bus0_pll",
 	"ffac_topc_bus0_pll_div2"};
 
-static unsigned long topc_clk_regs[] __initdata = {
+static const unsigned long topc_clk_regs[] __initconst = {
 	CC_PLL_LOCK,
 	BUS0_PLL_LOCK,
 	BUS1_DPLL_LOCK,
@@ -89,7 +89,7 @@ static unsigned long topc_clk_regs[] __initdata = {
 	DIV_TOPC3,
 };
 
-static struct samsung_mux_clock topc_mux_clks[] __initdata = {
+static const struct samsung_mux_clock topc_mux_clks[] __initconst = {
 	MUX(0, "mout_topc_bus0_pll", mout_topc_bus0_pll_ctrl_p,
 		MUX_SEL_TOPC0, 0, 1),
 	MUX(0, "mout_topc_bus1_pll", mout_topc_bus1_pll_ctrl_p,
@@ -118,7 +118,7 @@ static struct samsung_mux_clock topc_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk_peris_66", mout_topc_group2, MUX_SEL_TOPC3, 24, 2),
 };
 
-static struct samsung_div_clock topc_div_clks[] __initdata = {
+static const struct samsung_div_clock topc_div_clks[] __initconst = {
 	DIV(DOUT_ACLK_CCORE_133, "dout_aclk_ccore_133", "mout_aclk_ccore_133",
 		DIV_TOPC0, 4, 4),
 
@@ -139,12 +139,12 @@ static struct samsung_div_clock topc_div_clks[] __initdata = {
 		DIV_TOPC3, 28, 4),
 };
 
-static struct samsung_pll_rate_table pll1460x_24mhz_tbl[] __initdata = {
+static const struct samsung_pll_rate_table pll1460x_24mhz_tbl[] __initconst = {
 	PLL_36XX_RATE(491520000, 20, 1, 0, 31457),
 	{},
 };
 
-static struct samsung_gate_clock topc_gate_clks[] __initdata = {
+static const struct samsung_gate_clock topc_gate_clks[] __initconst = {
 	GATE(ACLK_CCORE_133, "aclk_ccore_133", "dout_aclk_ccore_133",
 		ENABLE_ACLK_TOPC0, 4, 0, 0),
 
@@ -174,7 +174,7 @@ static struct samsung_gate_clock topc_gate_clks[] __initdata = {
 		ENABLE_SCLK_TOPC1, 0, 0, 0),
 };
 
-static struct samsung_pll_clock topc_pll_clks[] __initdata = {
+static const struct samsung_pll_clock topc_pll_clks[] __initconst = {
 	PLL(pll_1451x, 0, "fout_bus0_pll", "fin_pll", BUS0_PLL_LOCK,
 		BUS0_PLL_CON0, NULL),
 	PLL(pll_1452x, 0, "fout_cc_pll", "fin_pll", CC_PLL_LOCK,
@@ -187,7 +187,7 @@ static struct samsung_pll_clock topc_pll_clks[] __initdata = {
 		AUD_PLL_CON0, pll1460x_24mhz_tbl),
 };
 
-static struct samsung_cmu_info topc_cmu_info __initdata = {
+static const struct samsung_cmu_info topc_cmu_info __initconst = {
 	.pll_clks		= topc_pll_clks,
 	.nr_pll_clks		= ARRAY_SIZE(topc_pll_clks),
 	.mux_clks		= topc_mux_clks,
@@ -256,7 +256,7 @@ PNAME(mout_top0_group3) = {"ioclk_audiocdclk0",
 PNAME(mout_top0_group4) = {"ioclk_audiocdclk1", "mout_top0_aud_pll_user",
 	"mout_top0_bus0_pll_half", "mout_top0_bus1_pll_half"};
 
-static unsigned long top0_clk_regs[] __initdata = {
+static const unsigned long top0_clk_regs[] __initconst = {
 	MUX_SEL_TOP00,
 	MUX_SEL_TOP01,
 	MUX_SEL_TOP03,
@@ -275,7 +275,7 @@ static unsigned long top0_clk_regs[] __initdata = {
 	ENABLE_SCLK_TOP0_PERIC3,
 };
 
-static struct samsung_mux_clock top0_mux_clks[] __initdata = {
+static const struct samsung_mux_clock top0_mux_clks[] __initconst = {
 	MUX(0, "mout_top0_aud_pll_user", mout_top0_aud_pll_user_p,
 		MUX_SEL_TOP00, 0, 1),
 	MUX(0, "mout_top0_mfc_pll_user", mout_top0_mfc_pll_user_p,
@@ -315,7 +315,7 @@ static struct samsung_mux_clock top0_mux_clks[] __initdata = {
 	MUX(0, "mout_sclk_spi4", mout_top0_group1, MUX_SEL_TOP0_PERIC3, 20, 2),
 };
 
-static struct samsung_div_clock top0_div_clks[] __initdata = {
+static const struct samsung_div_clock top0_div_clks[] __initconst = {
 	DIV(DOUT_ACLK_PERIC1, "dout_aclk_peric1_66", "mout_aclk_peric1_66",
 		DIV_TOP03, 12, 6),
 	DIV(DOUT_ACLK_PERIC0, "dout_aclk_peric0_66", "mout_aclk_peric0_66",
@@ -338,7 +338,7 @@ static struct samsung_div_clock top0_div_clks[] __initdata = {
 	DIV(0, "dout_sclk_spi4", "mout_sclk_spi4", DIV_TOP0_PERIC3, 20, 12),
 };
 
-static struct samsung_gate_clock top0_gate_clks[] __initdata = {
+static const struct samsung_gate_clock top0_gate_clks[] __initconst = {
 	GATE(CLK_ACLK_PERIC0_66, "aclk_peric0_66", "dout_aclk_peric0_66",
 		ENABLE_ACLK_TOP03, 20, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_ACLK_PERIC1_66, "aclk_peric1_66", "dout_aclk_peric1_66",
@@ -372,7 +372,7 @@ static struct samsung_gate_clock top0_gate_clks[] __initdata = {
 		ENABLE_SCLK_TOP0_PERIC3, 20, CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_fixed_factor_clock top0_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock top0_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ffac_top0_bus0_pll_div2", "mout_top0_bus0_pll_user",
 		1, 2, 0),
 	FFACTOR(0, "ffac_top0_bus1_pll_div2", "mout_top0_bus1_pll_user",
@@ -381,7 +381,7 @@ static struct samsung_fixed_factor_clock top0_fixed_factor_clks[] __initdata = {
 	FFACTOR(0, "ffac_top0_mfc_pll_div2", "mout_top0_mfc_pll_user", 1, 2, 0),
 };
 
-static struct samsung_cmu_info top0_cmu_info __initdata = {
+static const struct samsung_cmu_info top0_cmu_info __initconst = {
 	.mux_clks		= top0_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(top0_mux_clks),
 	.div_clks		= top0_div_clks,
@@ -438,7 +438,7 @@ PNAME(mout_top1_group1) = {"mout_top1_bus0_pll_half",
 	"mout_top1_bus1_pll_half", "mout_top1_cc_pll_half",
 	"mout_top1_mfc_pll_half"};
 
-static unsigned long top1_clk_regs[] __initdata = {
+static const unsigned long top1_clk_regs[] __initconst = {
 	MUX_SEL_TOP10,
 	MUX_SEL_TOP11,
 	MUX_SEL_TOP13,
@@ -455,7 +455,7 @@ static unsigned long top1_clk_regs[] __initdata = {
 	ENABLE_SCLK_TOP1_FSYS11,
 };
 
-static struct samsung_mux_clock top1_mux_clks[] __initdata = {
+static const struct samsung_mux_clock top1_mux_clks[] __initconst = {
 	MUX(0, "mout_top1_mfc_pll_user", mout_top1_mfc_pll_user_p,
 		MUX_SEL_TOP10, 4, 1),
 	MUX(0, "mout_top1_cc_pll_user", mout_top1_cc_pll_user_p,
@@ -494,7 +494,7 @@ static struct samsung_mux_clock top1_mux_clks[] __initdata = {
 		MUX_SEL_TOP1_FSYS11, 24, 2),
 };
 
-static struct samsung_div_clock top1_div_clks[] __initdata = {
+static const struct samsung_div_clock top1_div_clks[] __initconst = {
 	DIV(DOUT_ACLK_FSYS1_200, "dout_aclk_fsys1_200", "mout_aclk_fsys1_200",
 		DIV_TOP13, 24, 4),
 	DIV(DOUT_ACLK_FSYS0_200, "dout_aclk_fsys0_200", "mout_aclk_fsys0_200",
@@ -521,7 +521,7 @@ static struct samsung_div_clock top1_div_clks[] __initdata = {
 		"mout_sclk_phy_fsys1_26m", DIV_TOP1_FSYS11, 24, 6),
 };
 
-static struct samsung_gate_clock top1_gate_clks[] __initdata = {
+static const struct samsung_gate_clock top1_gate_clks[] __initconst = {
 	GATE(CLK_SCLK_MMC2, "sclk_mmc2", "dout_sclk_mmc2",
 		ENABLE_SCLK_TOP1_FSYS0, 16, CLK_SET_RATE_PARENT, 0),
 	GATE(0, "sclk_usbdrd300", "dout_sclk_usbdrd300",
@@ -548,7 +548,7 @@ static struct samsung_gate_clock top1_gate_clks[] __initdata = {
 		24, CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_fixed_factor_clock top1_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock top1_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ffac_top1_bus0_pll_div2", "mout_top1_bus0_pll_user",
 		1, 2, 0),
 	FFACTOR(0, "ffac_top1_bus1_pll_div2", "mout_top1_bus1_pll_user",
@@ -557,7 +557,7 @@ static struct samsung_fixed_factor_clock top1_fixed_factor_clks[] __initdata = {
 	FFACTOR(0, "ffac_top1_mfc_pll_div2", "mout_top1_mfc_pll_user", 1, 2, 0),
 };
 
-static struct samsung_cmu_info top1_cmu_info __initdata = {
+static const struct samsung_cmu_info top1_cmu_info __initconst = {
 	.mux_clks		= top1_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(top1_mux_clks),
 	.div_clks		= top1_div_clks,
@@ -591,22 +591,22 @@ CLK_OF_DECLARE(exynos7_clk_top1, "samsung,exynos7-clock-top1",
  */
 PNAME(mout_aclk_ccore_133_user_p)	= { "fin_pll", "aclk_ccore_133" };
 
-static unsigned long ccore_clk_regs[] __initdata = {
+static const unsigned long ccore_clk_regs[] __initconst = {
 	MUX_SEL_CCORE,
 	ENABLE_PCLK_CCORE,
 };
 
-static struct samsung_mux_clock ccore_mux_clks[] __initdata = {
+static const struct samsung_mux_clock ccore_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk_ccore_133_user", mout_aclk_ccore_133_user_p,
 		MUX_SEL_CCORE, 1, 1),
 };
 
-static struct samsung_gate_clock ccore_gate_clks[] __initdata = {
+static const struct samsung_gate_clock ccore_gate_clks[] __initconst = {
 	GATE(PCLK_RTC, "pclk_rtc", "mout_aclk_ccore_133_user",
 		ENABLE_PCLK_CCORE, 8, 0, 0),
 };
 
-static struct samsung_cmu_info ccore_cmu_info __initdata = {
+static const struct samsung_cmu_info ccore_cmu_info __initconst = {
 	.mux_clks		= ccore_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(ccore_mux_clks),
 	.gate_clks		= ccore_gate_clks,
@@ -633,20 +633,20 @@ CLK_OF_DECLARE(exynos7_clk_ccore, "samsung,exynos7-clock-ccore",
 PNAME(mout_aclk_peric0_66_user_p)	= { "fin_pll", "aclk_peric0_66" };
 PNAME(mout_sclk_uart0_user_p)	= { "fin_pll", "sclk_uart0" };
 
-static unsigned long peric0_clk_regs[] __initdata = {
+static const unsigned long peric0_clk_regs[] __initconst = {
 	MUX_SEL_PERIC0,
 	ENABLE_PCLK_PERIC0,
 	ENABLE_SCLK_PERIC0,
 };
 
-static struct samsung_mux_clock peric0_mux_clks[] __initdata = {
+static const struct samsung_mux_clock peric0_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk_peric0_66_user", mout_aclk_peric0_66_user_p,
 		MUX_SEL_PERIC0, 0, 1),
 	MUX(0, "mout_sclk_uart0_user", mout_sclk_uart0_user_p,
 		MUX_SEL_PERIC0, 16, 1),
 };
 
-static struct samsung_gate_clock peric0_gate_clks[] __initdata = {
+static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	GATE(PCLK_HSI2C0, "pclk_hsi2c0", "mout_aclk_peric0_66_user",
 		ENABLE_PCLK_PERIC0, 8, 0, 0),
 	GATE(PCLK_HSI2C1, "pclk_hsi2c1", "mout_aclk_peric0_66_user",
@@ -673,7 +673,7 @@ static struct samsung_gate_clock peric0_gate_clks[] __initdata = {
 	GATE(SCLK_PWM, "sclk_pwm", "fin_pll", ENABLE_SCLK_PERIC0, 21, 0, 0),
 };
 
-static struct samsung_cmu_info peric0_cmu_info __initdata = {
+static const struct samsung_cmu_info peric0_cmu_info __initconst = {
 	.mux_clks		= peric0_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(peric0_mux_clks),
 	.gate_clks		= peric0_gate_clks,
@@ -709,7 +709,7 @@ PNAME(mout_sclk_spi2_user_p)		= { "fin_pll", "sclk_spi2" };
 PNAME(mout_sclk_spi3_user_p)		= { "fin_pll", "sclk_spi3" };
 PNAME(mout_sclk_spi4_user_p)		= { "fin_pll", "sclk_spi4" };
 
-static unsigned long peric1_clk_regs[] __initdata = {
+static const unsigned long peric1_clk_regs[] __initconst = {
 	MUX_SEL_PERIC10,
 	MUX_SEL_PERIC11,
 	MUX_SEL_PERIC12,
@@ -717,7 +717,7 @@ static unsigned long peric1_clk_regs[] __initdata = {
 	ENABLE_SCLK_PERIC10,
 };
 
-static struct samsung_mux_clock peric1_mux_clks[] __initdata = {
+static const struct samsung_mux_clock peric1_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk_peric1_66_user", mout_aclk_peric1_66_user_p,
 		MUX_SEL_PERIC10, 0, 1),
 
@@ -739,7 +739,7 @@ static struct samsung_mux_clock peric1_mux_clks[] __initdata = {
 		MUX_SEL_PERIC11, 28, 1),
 };
 
-static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
+static const struct samsung_gate_clock peric1_gate_clks[] __initconst = {
 	GATE(PCLK_HSI2C2, "pclk_hsi2c2", "mout_aclk_peric1_66_user",
 		ENABLE_PCLK_PERIC1, 4, 0, 0),
 	GATE(PCLK_HSI2C3, "pclk_hsi2c3", "mout_aclk_peric1_66_user",
@@ -797,7 +797,7 @@ static struct samsung_gate_clock peric1_gate_clks[] __initdata = {
 		ENABLE_SCLK_PERIC10, 19, CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_cmu_info peric1_cmu_info __initdata = {
+static const struct samsung_cmu_info peric1_cmu_info __initconst = {
 	.mux_clks		= peric1_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(peric1_mux_clks),
 	.gate_clks		= peric1_gate_clks,
@@ -825,7 +825,7 @@ CLK_OF_DECLARE(exynos7_clk_peric1, "samsung,exynos7-clock-peric1",
 /* List of parent clocks for Muxes in CMU_PERIS */
 PNAME(mout_aclk_peris_66_user_p) = { "fin_pll", "aclk_peris_66" };
 
-static unsigned long peris_clk_regs[] __initdata = {
+static const unsigned long peris_clk_regs[] __initconst = {
 	MUX_SEL_PERIS,
 	ENABLE_PCLK_PERIS,
 	ENABLE_PCLK_PERIS_SECURE_CHIPID,
@@ -833,12 +833,12 @@ static unsigned long peris_clk_regs[] __initdata = {
 	ENABLE_SCLK_PERIS_SECURE_CHIPID,
 };
 
-static struct samsung_mux_clock peris_mux_clks[] __initdata = {
+static const struct samsung_mux_clock peris_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk_peris_66_user",
 		mout_aclk_peris_66_user_p, MUX_SEL_PERIS, 0, 1),
 };
 
-static struct samsung_gate_clock peris_gate_clks[] __initdata = {
+static const struct samsung_gate_clock peris_gate_clks[] __initconst = {
 	GATE(PCLK_WDT, "pclk_wdt", "mout_aclk_peris_66_user",
 		ENABLE_PCLK_PERIS, 6, 0, 0),
 	GATE(PCLK_TMU, "pclk_tmu_apbif", "mout_aclk_peris_66_user",
@@ -852,7 +852,7 @@ static struct samsung_gate_clock peris_gate_clks[] __initdata = {
 	GATE(SCLK_TMU, "sclk_tmu", "fin_pll", ENABLE_SCLK_PERIS, 10, 0, 0),
 };
 
-static struct samsung_cmu_info peris_cmu_info __initdata = {
+static const struct samsung_cmu_info peris_cmu_info __initconst = {
 	.mux_clks		= peris_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(peris_mux_clks),
 	.gate_clks		= peris_gate_clks,
@@ -893,12 +893,12 @@ PNAME(mout_phyclk_usbdrd300_udrd30_pipe_pclk_user_p)	= { "fin_pll",
 				"phyclk_usbdrd300_udrd30_pipe_pclk" };
 
 /* fixed rate clocks used in the FSYS0 block */
-static struct samsung_fixed_rate_clock fixed_rate_clks_fsys0[] __initdata = {
+static const struct samsung_fixed_rate_clock fixed_rate_clks_fsys0[] __initconst = {
 	FRATE(0, "phyclk_usbdrd300_udrd30_phyclock", NULL, 0, 60000000),
 	FRATE(0, "phyclk_usbdrd300_udrd30_pipe_pclk", NULL, 0, 125000000),
 };
 
-static unsigned long fsys0_clk_regs[] __initdata = {
+static const unsigned long fsys0_clk_regs[] __initconst = {
 	MUX_SEL_FSYS00,
 	MUX_SEL_FSYS01,
 	MUX_SEL_FSYS02,
@@ -909,7 +909,7 @@ static unsigned long fsys0_clk_regs[] __initdata = {
 	ENABLE_SCLK_FSYS04,
 };
 
-static struct samsung_mux_clock fsys0_mux_clks[] __initdata = {
+static const struct samsung_mux_clock fsys0_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk_fsys0_200_user", mout_aclk_fsys0_200_user_p,
 		MUX_SEL_FSYS00, 24, 1),
 
@@ -926,7 +926,7 @@ static struct samsung_mux_clock fsys0_mux_clks[] __initdata = {
 		MUX_SEL_FSYS02, 28, 1),
 };
 
-static struct samsung_gate_clock fsys0_gate_clks[] __initdata = {
+static const struct samsung_gate_clock fsys0_gate_clks[] __initconst = {
 	GATE(ACLK_PDMA1, "aclk_pdma1", "mout_aclk_fsys0_200_user",
 			ENABLE_ACLK_FSYS00, 3, 0, 0),
 	GATE(ACLK_PDMA0, "aclk_pdma0", "mout_aclk_fsys0_200_user",
@@ -960,7 +960,7 @@ static struct samsung_gate_clock fsys0_gate_clks[] __initdata = {
 		ENABLE_SCLK_FSYS04, 28, 0, 0),
 };
 
-static struct samsung_cmu_info fsys0_cmu_info __initdata = {
+static const struct samsung_cmu_info fsys0_cmu_info __initconst = {
 	.fixed_clks		= fixed_rate_clks_fsys0,
 	.nr_fixed_clks		= ARRAY_SIZE(fixed_rate_clks_fsys0),
 	.mux_clks		= fsys0_mux_clks,
@@ -1005,7 +1005,7 @@ PNAME(mout_phyclk_ufs20_rx0_user_p) = { "fin_pll", "phyclk_ufs20_rx0_symbol" };
 PNAME(mout_phyclk_ufs20_rx1_user_p) = { "fin_pll", "phyclk_ufs20_rx1_symbol" };
 
 /* fixed rate clocks used in the FSYS1 block */
-static struct samsung_fixed_rate_clock fixed_rate_clks_fsys1[] __initdata = {
+static const struct samsung_fixed_rate_clock fixed_rate_clks_fsys1[] __initconst = {
 	FRATE(PHYCLK_UFS20_TX0_SYMBOL, "phyclk_ufs20_tx0_symbol", NULL,
 			0, 300000000),
 	FRATE(PHYCLK_UFS20_RX0_SYMBOL, "phyclk_ufs20_rx0_symbol", NULL,
@@ -1014,7 +1014,7 @@ static struct samsung_fixed_rate_clock fixed_rate_clks_fsys1[] __initdata = {
 			0, 300000000),
 };
 
-static unsigned long fsys1_clk_regs[] __initdata = {
+static const unsigned long fsys1_clk_regs[] __initconst = {
 	MUX_SEL_FSYS10,
 	MUX_SEL_FSYS11,
 	MUX_SEL_FSYS12,
@@ -1026,7 +1026,7 @@ static unsigned long fsys1_clk_regs[] __initdata = {
 	ENABLE_SCLK_FSYS13,
 };
 
-static struct samsung_mux_clock fsys1_mux_clks[] __initdata = {
+static const struct samsung_mux_clock fsys1_mux_clks[] __initconst = {
 	MUX(MOUT_FSYS1_PHYCLK_SEL1, "mout_fsys1_phyclk_sel1",
 		mout_fsys1_group_p, MUX_SEL_FSYS10, 16, 2),
 	MUX(0, "mout_fsys1_phyclk_sel0", mout_fsys1_group_p,
@@ -1049,12 +1049,12 @@ static struct samsung_mux_clock fsys1_mux_clks[] __initdata = {
 		mout_phyclk_ufs20_tx0_user_p, MUX_SEL_FSYS12, 28, 1),
 };
 
-static struct samsung_div_clock fsys1_div_clks[] __initdata = {
+static const struct samsung_div_clock fsys1_div_clks[] __initconst = {
 	DIV(DOUT_PCLK_FSYS1, "dout_pclk_fsys1", "mout_aclk_fsys1_200_user",
 		DIV_FSYS1, 0, 2),
 };
 
-static struct samsung_gate_clock fsys1_gate_clks[] __initdata = {
+static const struct samsung_gate_clock fsys1_gate_clks[] __initconst = {
 	GATE(SCLK_UFSUNIPRO20_USER, "sclk_ufsunipro20_user",
 		"mout_sclk_ufsunipro20_user",
 		ENABLE_SCLK_FSYS11, 20, 0, 0),
@@ -1089,7 +1089,7 @@ static struct samsung_gate_clock fsys1_gate_clks[] __initdata = {
 		ENABLE_SCLK_FSYS13, 24, CLK_IGNORE_UNUSED, 0),
 };
 
-static struct samsung_cmu_info fsys1_cmu_info __initdata = {
+static const struct samsung_cmu_info fsys1_cmu_info __initconst = {
 	.fixed_clks		= fixed_rate_clks_fsys1,
 	.nr_fixed_clks		= ARRAY_SIZE(fixed_rate_clks_fsys1),
 	.mux_clks		= fsys1_mux_clks,
@@ -1119,22 +1119,22 @@ CLK_OF_DECLARE(exynos7_clk_fsys1, "samsung,exynos7-clock-fsys1",
 /* List of parent clocks for Muxes in CMU_MSCL */
 PNAME(mout_aclk_mscl_532_user_p)	= { "fin_pll", "aclk_mscl_532" };
 
-static unsigned long mscl_clk_regs[] __initdata = {
+static const unsigned long mscl_clk_regs[] __initconst = {
 	MUX_SEL_MSCL,
 	DIV_MSCL,
 	ENABLE_ACLK_MSCL,
 	ENABLE_PCLK_MSCL,
 };
 
-static struct samsung_mux_clock mscl_mux_clks[] __initdata = {
+static const struct samsung_mux_clock mscl_mux_clks[] __initconst = {
 	MUX(USERMUX_ACLK_MSCL_532, "usermux_aclk_mscl_532",
 		mout_aclk_mscl_532_user_p, MUX_SEL_MSCL, 0, 1),
 };
-static struct samsung_div_clock mscl_div_clks[] __initdata = {
+static const struct samsung_div_clock mscl_div_clks[] __initconst = {
 	DIV(DOUT_PCLK_MSCL, "dout_pclk_mscl", "usermux_aclk_mscl_532",
 			DIV_MSCL, 0, 3),
 };
-static struct samsung_gate_clock mscl_gate_clks[] __initdata = {
+static const struct samsung_gate_clock mscl_gate_clks[] __initconst = {
 
 	GATE(ACLK_MSCL_0, "aclk_mscl_0", "usermux_aclk_mscl_532",
 			ENABLE_ACLK_MSCL, 31, 0, 0),
@@ -1204,7 +1204,7 @@ static struct samsung_gate_clock mscl_gate_clks[] __initdata = {
 			ENABLE_PCLK_MSCL, 20, 0, 0),
 };
 
-static struct samsung_cmu_info mscl_cmu_info __initdata = {
+static const struct samsung_cmu_info mscl_cmu_info __initconst = {
 	.mux_clks		= mscl_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(mscl_mux_clks),
 	.div_clks		= mscl_div_clks,
@@ -1238,7 +1238,7 @@ CLK_OF_DECLARE(exynos7_clk_mscl, "samsung,exynos7-clock-mscl",
 PNAME(mout_aud_pll_user_p) = { "fin_pll", "fout_aud_pll" };
 PNAME(mout_aud_group_p) = { "dout_aud_cdclk", "ioclk_audiocdclk0" };
 
-static unsigned long aud_clk_regs[] __initdata = {
+static const unsigned long aud_clk_regs[] __initconst = {
 	MUX_SEL_AUD,
 	DIV_AUD0,
 	DIV_AUD1,
@@ -1247,13 +1247,13 @@ static unsigned long aud_clk_regs[] __initdata = {
 	ENABLE_SCLK_AUD,
 };
 
-static struct samsung_mux_clock aud_mux_clks[] __initdata = {
+static const struct samsung_mux_clock aud_mux_clks[] __initconst = {
 	MUX(0, "mout_sclk_i2s", mout_aud_group_p, MUX_SEL_AUD, 12, 1),
 	MUX(0, "mout_sclk_pcm", mout_aud_group_p, MUX_SEL_AUD, 16, 1),
 	MUX(0, "mout_aud_pll_user", mout_aud_pll_user_p, MUX_SEL_AUD, 20, 1),
 };
 
-static struct samsung_div_clock aud_div_clks[] __initdata = {
+static const struct samsung_div_clock aud_div_clks[] __initconst = {
 	DIV(0, "dout_aud_ca5", "mout_aud_pll_user", DIV_AUD0, 0, 4),
 	DIV(0, "dout_aclk_aud", "dout_aud_ca5", DIV_AUD0, 4, 4),
 	DIV(0, "dout_aud_pclk_dbg", "dout_aud_ca5", DIV_AUD0, 8, 4),
@@ -1265,7 +1265,7 @@ static struct samsung_div_clock aud_div_clks[] __initdata = {
 	DIV(0, "dout_aud_cdclk", "mout_aud_pll_user", DIV_AUD1, 24, 4),
 };
 
-static struct samsung_gate_clock aud_gate_clks[] __initdata = {
+static const struct samsung_gate_clock aud_gate_clks[] __initconst = {
 	GATE(SCLK_PCM, "sclk_pcm", "dout_sclk_pcm",
 			ENABLE_SCLK_AUD, 27, CLK_SET_RATE_PARENT, 0),
 	GATE(SCLK_I2S, "sclk_i2s", "dout_sclk_i2s",
@@ -1293,7 +1293,7 @@ static struct samsung_gate_clock aud_gate_clks[] __initdata = {
 	GATE(ACLK_ADMA, "aclk_dmac", "dout_aclk_aud", ENABLE_ACLK_AUD, 31, 0, 0),
 };
 
-static struct samsung_cmu_info aud_cmu_info __initdata = {
+static const struct samsung_cmu_info aud_cmu_info __initconst = {
 	.mux_clks		= aud_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(aud_mux_clks),
 	.div_clks		= aud_div_clks,
-- 
1.9.1
