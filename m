From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:01 +0200
Subject: [PATCH 05/18] clk: samsung: exynos4: Constify all clock initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index b599ca30d6d0..a6116f572278 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -169,7 +169,7 @@ static struct samsung_clk_reg_dump *exynos4_save_pll;
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
  */
-static unsigned long exynos4210_clk_save[] __initdata = {
+static const unsigned long exynos4210_clk_save[] __initconst = {
 	E4210_SRC_IMAGE,
 	E4210_SRC_LCD1,
 	E4210_SRC_MASK_LCD1,
@@ -181,7 +181,7 @@ static unsigned long exynos4210_clk_save[] __initdata = {
 	PWR_CTRL1,
 };
 
-static unsigned long exynos4x12_clk_save[] __initdata = {
+static const unsigned long exynos4x12_clk_save[] __initconst = {
 	E4X12_GATE_IP_IMAGE,
 	E4X12_GATE_IP_PERIR,
 	E4X12_SRC_CAM1,
@@ -192,7 +192,7 @@ static unsigned long exynos4x12_clk_save[] __initdata = {
 	E4X12_PWR_CTRL2,
 };
 
-static unsigned long exynos4_clk_pll_regs[] __initdata = {
+static const unsigned long exynos4_clk_pll_regs[] __initconst = {
 	EPLL_LOCK,
 	VPLL_LOCK,
 	EPLL_CON0,
@@ -203,7 +203,7 @@ static unsigned long exynos4_clk_pll_regs[] __initdata = {
 	VPLL_CON2,
 };
 
-static unsigned long exynos4_clk_regs[] __initdata = {
+static const unsigned long exynos4_clk_regs[] __initconst = {
 	SRC_LEFTBUS,
 	DIV_LEFTBUS,
 	GATE_IP_LEFTBUS,
@@ -505,28 +505,28 @@ static struct samsung_fixed_rate_clock exynos4_fixed_rate_ext_clks[] __initdata
 };
 
 /* fixed rate clocks generated inside the soc */
-static struct samsung_fixed_rate_clock exynos4_fixed_rate_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock exynos4_fixed_rate_clks[] __initconst = {
 	FRATE(0, "sclk_hdmi24m", NULL, 0, 24000000),
 	FRATE(CLK_SCLK_HDMIPHY, "sclk_hdmiphy", "hdmi", 0, 27000000),
 	FRATE(0, "sclk_usbphy0", NULL, 0, 48000000),
 };
 
-static struct samsung_fixed_rate_clock exynos4210_fixed_rate_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock exynos4210_fixed_rate_clks[] __initconst = {
 	FRATE(0, "sclk_usbphy1", NULL, 0, 48000000),
 };
 
-static struct samsung_fixed_factor_clock exynos4_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock exynos4_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "sclk_apll_div_2", "sclk_apll", 1, 2, 0),
 	FFACTOR(0, "fout_mpll_div_2", "fout_mpll", 1, 2, 0),
 	FFACTOR(0, "fout_apll_div_2", "fout_apll", 1, 2, 0),
 	FFACTOR(0, "arm_clk_div_2", "div_core2", 1, 2, 0),
 };
 
-static struct samsung_fixed_factor_clock exynos4210_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock exynos4210_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "sclk_mpll_div_2", "sclk_mpll", 1, 2, 0),
 };
 
-static struct samsung_fixed_factor_clock exynos4x12_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock exynos4x12_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "sclk_mpll_user_l_div_2", "mout_mpll_user_l", 1, 2, 0),
 	FFACTOR(0, "sclk_mpll_user_r_div_2", "mout_mpll_user_r", 1, 2, 0),
 	FFACTOR(0, "sclk_mpll_user_t_div_2", "mout_mpll_user_t", 1, 2, 0),
@@ -534,7 +534,7 @@ static struct samsung_fixed_factor_clock exynos4x12_fixed_factor_clks[] __initda
 };
 
 /* list of mux clocks supported in all exynos4 soc's */
-static struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos4_mux_clks[] __initconst = {
 	MUX_FA(CLK_MOUT_APLL, "mout_apll", mout_apll_p, SRC_CPU, 0, 1,
 			CLK_SET_RATE_PARENT | CLK_RECALC_NEW_RATES, 0,
 			"mout_apll"),
@@ -555,11 +555,11 @@ static struct samsung_mux_clock exynos4_mux_clks[] __initdata = {
 };
 
 /* list of mux clocks supported in exynos4210 soc */
-static struct samsung_mux_clock exynos4210_mux_early[] __initdata = {
+static const struct samsung_mux_clock exynos4210_mux_early[] __initconst = {
 	MUX(0, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP1, 0, 1),
 };
 
-static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos4210_mux_clks[] __initconst = {
 	MUX(0, "mout_gdl", sclk_ampll_p4210, SRC_LEFTBUS, 0, 1),
 	MUX(0, "mout_clkout_leftbus", clkout_left_p4210,
 			CLKOUT_CMU_LEFTBUS, 0, 5),
@@ -622,7 +622,7 @@ static struct samsung_mux_clock exynos4210_mux_clks[] __initdata = {
 };
 
 /* list of mux clocks supported in exynos4x12 soc */
-static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos4x12_mux_clks[] __initconst = {
 	MUX(0, "mout_mpll_user_l", mout_mpll_p, SRC_LEFTBUS, 4, 1),
 	MUX(0, "mout_gdl", mout_gdl_p4x12, SRC_LEFTBUS, 0, 1),
 	MUX(0, "mout_clkout_leftbus", clkout_left_p4x12,
@@ -705,7 +705,7 @@ static struct samsung_mux_clock exynos4x12_mux_clks[] __initdata = {
 };
 
 /* list of divider clocks supported in all exynos4 soc's */
-static struct samsung_div_clock exynos4_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos4_div_clks[] __initconst = {
 	DIV(CLK_DIV_GDL, "div_gdl", "mout_gdl", DIV_LEFTBUS, 0, 3),
 	DIV(0, "div_gpl", "div_gdl", DIV_LEFTBUS, 4, 3),
 	DIV(0, "div_clkout_leftbus", "mout_clkout_leftbus",
@@ -795,7 +795,7 @@ static struct samsung_div_clock exynos4_div_clks[] __initdata = {
 };
 
 /* list of divider clocks supported in exynos4210 soc */
-static struct samsung_div_clock exynos4210_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos4210_div_clks[] __initconst = {
 	DIV(CLK_ACLK200, "aclk200", "mout_aclk200", DIV_TOP, 0, 3),
 	DIV(CLK_SCLK_FIMG2D, "sclk_fimg2d", "mout_g2d", DIV_IMAGE, 0, 4),
 	DIV(0, "div_fimd1", "mout_fimd1", E4210_DIV_LCD1, 0, 4),
@@ -806,7 +806,7 @@ static struct samsung_div_clock exynos4210_div_clks[] __initdata = {
 };
 
 /* list of divider clocks supported in exynos4x12 soc */
-static struct samsung_div_clock exynos4x12_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos4x12_div_clks[] __initconst = {
 	DIV(0, "div_mdnie0", "mout_mdnie0", DIV_LCD0, 4, 4),
 	DIV(0, "div_mdnie_pwm0", "mout_mdnie_pwm0", DIV_LCD0, 8, 4),
 	DIV(0, "div_mdnie_pwm_pre0", "div_mdnie_pwm0", DIV_LCD0, 12, 4),
@@ -837,7 +837,7 @@ static struct samsung_div_clock exynos4x12_div_clks[] __initdata = {
 };
 
 /* list of gate clocks supported in all exynos4 soc's */
-static struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
+static const struct samsung_gate_clock exynos4_gate_clks[] __initconst = {
 	/*
 	 * After all Exynos4 based platforms are migrated to use device tree,
 	 * the device name and clock alias names specified below for some
@@ -1043,7 +1043,7 @@ static struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 };
 
 /* list of gate clocks supported in exynos4210 soc */
-static struct samsung_gate_clock exynos4210_gate_clks[] __initdata = {
+static const struct samsung_gate_clock exynos4210_gate_clks[] __initconst = {
 	GATE(CLK_TVENC, "tvenc", "aclk160", GATE_IP_TV, 2, 0, 0),
 	GATE(CLK_G2D, "g2d", "aclk200", E4210_GATE_IP_IMAGE, 0, 0, 0),
 	GATE(CLK_ROTATOR, "rotator", "aclk200", E4210_GATE_IP_IMAGE, 1, 0, 0),
@@ -1090,7 +1090,7 @@ static struct samsung_gate_clock exynos4210_gate_clks[] __initdata = {
 };
 
 /* list of gate clocks supported in exynos4x12 soc */
-static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
+static const struct samsung_gate_clock exynos4x12_gate_clks[] __initconst = {
 	GATE(CLK_AUDSS, "audss", "sclk_epll", E4X12_GATE_IP_MAUDIO, 0, 0, 0),
 	GATE(CLK_MDNIE0, "mdnie0", "aclk160", GATE_IP_LCD0, 2, 0, 0),
 	GATE(CLK_ROTATOR, "rotator", "aclk200", E4X12_GATE_IP_IMAGE, 1, 0, 0),
@@ -1190,17 +1190,17 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 		0),
 };
 
-static struct samsung_clock_alias exynos4_aliases[] __initdata = {
+static const struct samsung_clock_alias exynos4_aliases[] __initconst = {
 	ALIAS(CLK_MOUT_CORE, NULL, "moutcore"),
 	ALIAS(CLK_ARM_CLK, NULL, "armclk"),
 	ALIAS(CLK_SCLK_APLL, NULL, "mout_apll"),
 };
 
-static struct samsung_clock_alias exynos4210_aliases[] __initdata = {
+static const struct samsung_clock_alias exynos4210_aliases[] __initconst = {
 	ALIAS(CLK_SCLK_MPLL, NULL, "mout_mpll"),
 };
 
-static struct samsung_clock_alias exynos4x12_aliases[] __initdata = {
+static const struct samsung_clock_alias exynos4x12_aliases[] __initconst = {
 	ALIAS(CLK_MOUT_MPLL_USER_C, NULL, "mout_mpll"),
 };
 
@@ -1264,7 +1264,7 @@ static const struct of_device_id ext_clk_match[] __initconst = {
 };
 
 /* PLLs PMS values */
-static struct samsung_pll_rate_table exynos4210_apll_rates[] __initdata = {
+static const struct samsung_pll_rate_table exynos4210_apll_rates[] __initconst = {
 	PLL_45XX_RATE(1200000000, 150,  3, 1, 28),
 	PLL_45XX_RATE(1000000000, 250,  6, 1, 28),
 	PLL_45XX_RATE( 800000000, 200,  6, 1, 28),
@@ -1277,7 +1277,7 @@ static struct samsung_pll_rate_table exynos4210_apll_rates[] __initdata = {
 	{ /* sentinel */ }
 };
 
-static struct samsung_pll_rate_table exynos4210_epll_rates[] __initdata = {
+static const struct samsung_pll_rate_table exynos4210_epll_rates[] __initconst = {
 	PLL_4600_RATE(192000000, 48, 3, 1,     0, 0),
 	PLL_4600_RATE(180633605, 45, 3, 1, 10381, 0),
 	PLL_4600_RATE(180000000, 45, 3, 1,     0, 0),
@@ -1288,7 +1288,7 @@ static struct samsung_pll_rate_table exynos4210_epll_rates[] __initdata = {
 	{ /* sentinel */ }
 };
 
-static struct samsung_pll_rate_table exynos4210_vpll_rates[] __initdata = {
+static const struct samsung_pll_rate_table exynos4210_vpll_rates[] __initconst = {
 	PLL_4650_RATE(360000000, 44, 3, 0, 1024, 0, 14, 0),
 	PLL_4650_RATE(324000000, 53, 2, 1, 1024, 1,  1, 1),
 	PLL_4650_RATE(259617187, 63, 3, 1, 1950, 0, 20, 1),
@@ -1297,7 +1297,7 @@ static struct samsung_pll_rate_table exynos4210_vpll_rates[] __initdata = {
 	{ /* sentinel */ }
 };
 
-static struct samsung_pll_rate_table exynos4x12_apll_rates[] __initdata = {
+static const struct samsung_pll_rate_table exynos4x12_apll_rates[] __initconst = {
 	PLL_35XX_RATE(1500000000, 250, 4, 0),
 	PLL_35XX_RATE(1400000000, 175, 3, 0),
 	PLL_35XX_RATE(1300000000, 325, 6, 0),
@@ -1315,7 +1315,7 @@ static struct samsung_pll_rate_table exynos4x12_apll_rates[] __initdata = {
 	{ /* sentinel */ }
 };
 
-static struct samsung_pll_rate_table exynos4x12_epll_rates[] __initdata = {
+static const struct samsung_pll_rate_table exynos4x12_epll_rates[] __initconst = {
 	PLL_36XX_RATE(192000000, 48, 3, 1,     0),
 	PLL_36XX_RATE(180633605, 45, 3, 1, 10381),
 	PLL_36XX_RATE(180000000, 45, 3, 1,     0),
@@ -1326,7 +1326,7 @@ static struct samsung_pll_rate_table exynos4x12_epll_rates[] __initdata = {
 	{ /* sentinel */ }
 };
 
-static struct samsung_pll_rate_table exynos4x12_vpll_rates[] __initdata = {
+static const struct samsung_pll_rate_table exynos4x12_vpll_rates[] __initconst = {
 	PLL_36XX_RATE(533000000, 133, 3, 1, 16384),
 	PLL_36XX_RATE(440000000, 110, 3, 1,     0),
 	PLL_36XX_RATE(350000000, 175, 3, 2,     0),
-- 
1.9.1
