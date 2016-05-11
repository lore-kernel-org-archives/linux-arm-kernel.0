From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:04 +0200
Subject: [PATCH 08/18] clk: samsung: exynos5250: Constify all clock
 initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 837197db4ffb..f24001dcfb8a 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -117,7 +117,7 @@ static struct samsung_clk_reg_dump *exynos5250_save;
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
  */
-static unsigned long exynos5250_clk_regs[] __initdata = {
+static const unsigned long exynos5250_clk_regs[] __initconst = {
 	SRC_CPU,
 	DIV_CPU0,
 	PWR_CTRL1,
@@ -266,23 +266,23 @@ static struct samsung_fixed_rate_clock exynos5250_fixed_rate_ext_clks[] __initda
 };
 
 /* fixed rate clocks generated inside the soc */
-static struct samsung_fixed_rate_clock exynos5250_fixed_rate_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock exynos5250_fixed_rate_clks[] __initconst = {
 	FRATE(CLK_SCLK_HDMIPHY, "sclk_hdmiphy", NULL, 0, 24000000),
 	FRATE(0, "sclk_hdmi27m", NULL, 0, 27000000),
 	FRATE(0, "sclk_dptxphy", NULL, 0, 24000000),
 	FRATE(0, "sclk_uhostphy", NULL, 0, 48000000),
 };
 
-static struct samsung_fixed_factor_clock exynos5250_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock exynos5250_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "fout_mplldiv2", "fout_mpll", 1, 2, 0),
 	FFACTOR(0, "fout_bplldiv2", "fout_bpll", 1, 2, 0),
 };
 
-static struct samsung_mux_clock exynos5250_pll_pmux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos5250_pll_pmux_clks[] __initconst = {
 	MUX(0, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP2, 0, 1),
 };
 
-static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos5250_mux_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by (clock domain, register address,
 	 * bitfield shift) triplet in ascending order. When adding new entries,
@@ -378,7 +378,7 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(0, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
 };
 
-static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos5250_div_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by (clock domain, register address,
 	 * bitfield shift) triplet in ascending order. When adding new entries,
@@ -470,7 +470,7 @@ static struct samsung_div_clock exynos5250_div_clks[] __initdata = {
 	DIV(CLK_DIV_I2S2, "div_i2s2", "sclk_audio2", DIV_PERIC5, 8, 6),
 };
 
-static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
+static const struct samsung_gate_clock exynos5250_gate_clks[] __initconst = {
 	/*
 	 * NOTE: Following table is sorted by (clock domain, register address,
 	 * bitfield shift) triplet in ascending order. When adding new entries,
@@ -698,7 +698,7 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 			GATE_IP_ISP1, 7, 0, 0),
 };
 
-static struct samsung_pll_rate_table vpll_24mhz_tbl[] __initdata = {
+static const struct samsung_pll_rate_table vpll_24mhz_tbl[] __initconst = {
 	/* sorted in descending order */
 	/* PLL_36XX_RATE(rate, m, p, s, k) */
 	PLL_36XX_RATE(266000000, 266, 3, 3, 0),
@@ -707,7 +707,7 @@ static struct samsung_pll_rate_table vpll_24mhz_tbl[] __initdata = {
 	{ },
 };
 
-static struct samsung_pll_rate_table epll_24mhz_tbl[] __initdata = {
+static const struct samsung_pll_rate_table epll_24mhz_tbl[] __initconst = {
 	/* sorted in descending order */
 	/* PLL_36XX_RATE(rate, m, p, s, k) */
 	PLL_36XX_RATE(192000000, 64, 2, 2, 0),
@@ -721,7 +721,7 @@ static struct samsung_pll_rate_table epll_24mhz_tbl[] __initdata = {
 	{ },
 };
 
-static struct samsung_pll_rate_table apll_24mhz_tbl[] __initdata = {
+static const struct samsung_pll_rate_table apll_24mhz_tbl[] __initconst = {
 	/* sorted in descending order */
 	/* PLL_35XX_RATE(rate, m, p, s) */
 	PLL_35XX_RATE(1700000000, 425, 6, 0),
-- 
1.9.1
