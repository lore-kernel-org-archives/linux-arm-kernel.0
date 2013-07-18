From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 18 Jul 2013 15:31:21 +0530
Subject: [PATCH 5/6] clk: exynos5440: Staticize local symbols
In-Reply-To: <1374141682-29432-1-git-send-email-sachin.kamat@linaro.org>
References: <1374141682-29432-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1374141682-29432-6-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Symbols referenced only in this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/clk/samsung/clk-exynos5440.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5440.c b/drivers/clk/samsung/clk-exynos5440.c
index 7d54341..6d043a2 100644
--- a/drivers/clk/samsung/clk-exynos5440.c
+++ b/drivers/clk/samsung/clk-exynos5440.c
@@ -41,12 +41,12 @@ PNAME(mout_armclk_p)	= { "cplla", "cpllb" };
 PNAME(mout_spi_p)	= { "div125", "div200" };
 
 /* fixed rate clocks generated outside the soc */
-struct samsung_fixed_rate_clock exynos5440_fixed_rate_ext_clks[] __initdata = {
+static struct samsung_fixed_rate_clock exynos5440_fixed_rate_ext_clks[] __initdata = {
 	FRATE(none, "xtal", NULL, CLK_IS_ROOT, 0),
 };
 
 /* fixed rate clocks */
-struct samsung_fixed_rate_clock exynos5440_fixed_rate_clks[] __initdata = {
+static struct samsung_fixed_rate_clock exynos5440_fixed_rate_clks[] __initdata = {
 	FRATE(none, "ppll", NULL, CLK_IS_ROOT, 1000000000),
 	FRATE(none, "usb_phy0", NULL, CLK_IS_ROOT, 60000000),
 	FRATE(none, "usb_phy1", NULL, CLK_IS_ROOT, 60000000),
@@ -55,26 +55,26 @@ struct samsung_fixed_rate_clock exynos5440_fixed_rate_clks[] __initdata = {
 };
 
 /* fixed factor clocks */
-struct samsung_fixed_factor_clock exynos5440_fixed_factor_clks[] __initdata = {
+static struct samsung_fixed_factor_clock exynos5440_fixed_factor_clks[] __initdata = {
 	FFACTOR(none, "div250", "ppll", 1, 4, 0),
 	FFACTOR(none, "div200", "ppll", 1, 5, 0),
 	FFACTOR(none, "div125", "div250", 1, 2, 0),
 };
 
 /* mux clocks */
-struct samsung_mux_clock exynos5440_mux_clks[] __initdata = {
+static struct samsung_mux_clock exynos5440_mux_clks[] __initdata = {
 	MUX(none, "mout_spi", mout_spi_p, MISC_DOUT1, 5, 1),
 	MUX_A(arm_clk, "arm_clk", mout_armclk_p,
 			CPU_CLK_STATUS, 0, 1, "armclk"),
 };
 
 /* divider clocks */
-struct samsung_div_clock exynos5440_div_clks[] __initdata = {
+static struct samsung_div_clock exynos5440_div_clks[] __initdata = {
 	DIV(spi_baud, "div_spi", "mout_spi", MISC_DOUT1, 3, 2),
 };
 
 /* gate clocks */
-struct samsung_gate_clock exynos5440_gate_clks[] __initdata = {
+static struct samsung_gate_clock exynos5440_gate_clks[] __initdata = {
 	GATE(pb0_250, "pb0_250", "div250", CLKEN_OV_VAL, 3, 0, 0),
 	GATE(pr0_250, "pr0_250", "div250", CLKEN_OV_VAL, 4, 0, 0),
 	GATE(pr1_250, "pr1_250", "div250", CLKEN_OV_VAL, 5, 0, 0),
@@ -103,7 +103,7 @@ static __initdata struct of_device_id ext_clk_match[] = {
 };
 
 /* register exynos5440 clocks */
-void __init exynos5440_clk_init(struct device_node *np)
+static void __init exynos5440_clk_init(struct device_node *np)
 {
 	void __iomem *reg_base;
 
-- 
1.7.9.5
