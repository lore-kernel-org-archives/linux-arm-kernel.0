From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:08 +0200
Subject: [PATCH 12/18] clk: samsung: exynos5440: Constify all clock
 initializers
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-12-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of initialization data can be made const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5440.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index c57cff1e1798..f4fbe00b2a5b 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -35,7 +35,7 @@ static struct samsung_fixed_rate_clock exynos5440_fixed_rate_ext_clks[] __initda
 };
 
 /* fixed rate clocks */
-static struct samsung_fixed_rate_clock exynos5440_fixed_rate_clks[] __initdata = {
+static const struct samsung_fixed_rate_clock exynos5440_fixed_rate_clks[] __initconst = {
 	FRATE(0, "ppll", NULL, 0, 1000000000),
 	FRATE(0, "usb_phy0", NULL, 0, 60000000),
 	FRATE(0, "usb_phy1", NULL, 0, 60000000),
@@ -44,26 +44,26 @@ static struct samsung_fixed_rate_clock exynos5440_fixed_rate_clks[] __initdata =
 };
 
 /* fixed factor clocks */
-static struct samsung_fixed_factor_clock exynos5440_fixed_factor_clks[] __initdata = {
+static const struct samsung_fixed_factor_clock exynos5440_fixed_factor_clks[] __initconst = {
 	FFACTOR(0, "div250", "ppll", 1, 4, 0),
 	FFACTOR(0, "div200", "ppll", 1, 5, 0),
 	FFACTOR(0, "div125", "div250", 1, 2, 0),
 };
 
 /* mux clocks */
-static struct samsung_mux_clock exynos5440_mux_clks[] __initdata = {
+static const struct samsung_mux_clock exynos5440_mux_clks[] __initconst = {
 	MUX(0, "mout_spi", mout_spi_p, MISC_DOUT1, 5, 1),
 	MUX_A(CLK_ARM_CLK, "arm_clk", mout_armclk_p,
 			CPU_CLK_STATUS, 0, 1, "armclk"),
 };
 
 /* divider clocks */
-static struct samsung_div_clock exynos5440_div_clks[] __initdata = {
+static const struct samsung_div_clock exynos5440_div_clks[] __initconst = {
 	DIV(CLK_SPI_BAUD, "div_spi", "mout_spi", MISC_DOUT1, 3, 2),
 };
 
 /* gate clocks */
-static struct samsung_gate_clock exynos5440_gate_clks[] __initdata = {
+static const struct samsung_gate_clock exynos5440_gate_clks[] __initconst = {
 	GATE(CLK_PB0_250, "pb0_250", "div250", CLKEN_OV_VAL, 3, 0, 0),
 	GATE(CLK_PR0_250, "pr0_250", "div250", CLKEN_OV_VAL, 4, 0, 0),
 	GATE(CLK_PR1_250, "pr1_250", "div250", CLKEN_OV_VAL, 5, 0, 0),
-- 
1.9.1
