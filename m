From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:07 +0200
Subject: [PATCH 11/18] clk: samsung: exynos5420: Constify all clock
 initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-11-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 92382cef9f90..adb0ae4efb7a 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -160,7 +160,7 @@ static struct samsung_clk_reg_dump *exynos5800_save;
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
  */
-static unsigned long exynos5x_clk_regs[] __initdata = {
+static const unsigned long exynos5x_clk_regs[] __initconst = {
 	SRC_CPU,
 	DIV_CPU0,
 	DIV_CPU1,
@@ -248,7 +248,7 @@ static unsigned long exynos5x_clk_regs[] __initdata = {
 	DIV_KFC0,
 };
 
-static unsigned long exynos5800_clk_regs[] __initdata = {
+static const unsigned long exynos5800_clk_regs[] __initconst = {
 	SRC_TOP8,
 	SRC_TOP9,
 	SRC_CAM,
@@ -484,7 +484,7 @@ static struct samsung_fixed_rate_clock
 };
 
 /* fixed rate clocks generated inside the soc */
-static struct samsung_fixed_rate_clock exynos5x_fixed_rate_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock exynos5x_fixed_rate_clks[] __initconst = {
 	FRATE(CLK_SCLK_HDMIPHY, "sclk_hdmiphy", NULL, 0, 24000000),
 	FRATE(0, "sclk_pwi", NULL, 0, 24000000),
 	FRATE(0, "sclk_usbh20", NULL, 0, 48000000),
@@ -492,19 +492,19 @@ static struct samsung_fixed_rate_clock exynos5x_fixed_rate_clks[] __initdata = {
 	FRATE(0, "sclk_usbh20_scan_clk", NULL, 0, 480000000),
 };
 
-static struct samsung_fixed_factor_clock
-		exynos5x_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock
+		exynos5x_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ff_hsic_12m", "fin_pll", 1, 2, 0),
 	FFACTOR(0, "ff_sw_aclk66", "mout_sw_aclk66", 1, 2, 0),
 };
 
-static struct samsung_fixed_factor_clock
-		exynos5800_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock
+		exynos5800_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "ff_dout_epll2", "mout_sclk_epll", 1, 2, 0),
 	FFACTOR(0, "ff_dout_spll2", "mout_sclk_spll", 1, 2, 0),
 };
 
-static struct samsung_mux_clock exynos5800_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos5800_mux_clks[] __initconst = {
 	MUX(0, "mout_aclk400_isp", mout_group3_5800_p, SRC_TOP0, 0, 3),
 	MUX(0, "mout_aclk400_mscl", mout_group3_5800_p, SRC_TOP0, 4, 3),
 	MUX(0, "mout_aclk400_wcore", mout_group2_5800_p, SRC_TOP0, 16, 3),
@@ -553,7 +553,7 @@ static struct samsung_mux_clock exynos5800_mux_clks[] __initdata = {
 	MUX(0, "mout_fimd1", mout_group2_p, SRC_DISP10, 4, 3),
 };
 
-static struct samsung_div_clock exynos5800_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos5800_div_clks[] __initconst = {
 	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
 			"mout_aclk400_wcore", DIV_TOP0, 16, 3),
 	DIV(0, "dout_aclk550_cam", "mout_aclk550_cam",
@@ -569,14 +569,14 @@ static struct samsung_div_clock exynos5800_div_clks[] __initdata = {
 	DIV(0, "dout_sclk_sw", "sclk_spll", DIV_TOP9, 24, 6),
 };
 
-static struct samsung_gate_clock exynos5800_gate_clks[] __initdata = {
+static const struct samsung_gate_clock exynos5800_gate_clks[] __initconst = {
 	GATE(CLK_ACLK550_CAM, "aclk550_cam", "mout_user_aclk550_cam",
 				GATE_BUS_TOP, 24, 0, 0),
 	GATE(CLK_ACLK432_SCALER, "aclk432_scaler", "mout_user_aclk432_scaler",
 				GATE_BUS_TOP, 27, 0, 0),
 };
 
-static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
 	MUX(0, "sclk_bpll", mout_bpll_p, TOP_SPARE2, 0, 1),
 	MUX(0, "mout_aclk400_wcore_bpll", mout_aclk400_wcore_bpll_p,
 				TOP_SPARE2, 4, 1),
@@ -606,12 +606,12 @@ static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
 	MUX(0, "mout_fimd1", mout_group3_p, SRC_DISP10, 4, 1),
 };
 
-static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
 	DIV(CLK_DOUT_ACLK400_WCORE, "dout_aclk400_wcore",
 			"mout_aclk400_wcore_bpll", DIV_TOP0, 16, 3),
 };
 
-static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
 	MUX(0, "mout_user_pclk66_gpio", mout_user_pclk66_gpio_p,
 			SRC_TOP7, 4, 1),
 	MUX(0, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
@@ -778,7 +778,7 @@ static struct samsung_mux_clock exynos5x_mux_clks[] __initdata = {
 	MUX(0, "mout_isp_sensor", mout_group2_p, SRC_ISP, 28, 3),
 };
 
-static struct samsung_div_clock exynos5x_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos5x_div_clks[] __initconst = {
 	DIV(0, "div_arm", "mout_cpu", DIV_CPU0, 0, 3),
 	DIV(0, "sclk_apll", "mout_apll", DIV_CPU0, 24, 3),
 	DIV(0, "armclk2", "div_arm", DIV_CPU0, 28, 3),
@@ -911,7 +911,7 @@ static struct samsung_div_clock exynos5x_div_clks[] __initdata = {
 			CLK_SET_RATE_PARENT, 0),
 };
 
-static struct samsung_gate_clock exynos5x_gate_clks[] __initdata = {
+static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 	/* G2D */
 	GATE(CLK_MDMA0, "mdma0", "aclk266_g2d", GATE_IP_G2D, 1, 0, 0),
 	GATE(CLK_SSS, "sss", "aclk266_g2d", GATE_IP_G2D, 2, 0, 0),
-- 
1.9.1
