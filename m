From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed,  7 Aug 2013 10:18:38 +0530
Subject: [PATCH 2/4] clk: exynos5250: Fix incorrect placement of __initdata
In-Reply-To: <1375850921-23122-1-git-send-email-sachin.kamat@linaro.org>
References: <1375850921-23122-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1375850921-23122-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos5250.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 5865cef..a9916a4 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -132,7 +132,7 @@ enum exynos5250_clks {
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
  */
-static __initdata unsigned long exynos5250_clk_regs[] = {
+static unsigned long exynos5250_clk_regs[] __initdata = {
 	SRC_CPU,
 	DIV_CPU0,
 	SRC_CORE1,
@@ -494,7 +494,7 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(g2d, "g2d", "aclk200", GATE_IP_ACP, 3, 0, 0),
 };
 
-static __initdata struct samsung_pll_rate_table vpll_24mhz_tbl[] = {
+static struct samsung_pll_rate_table vpll_24mhz_tbl[] __initdata = {
 	/* sorted in descending order */
 	/* PLL_36XX_RATE(rate, m, p, s, k) */
 	PLL_36XX_RATE(266000000, 266, 3, 3, 0),
@@ -503,7 +503,7 @@ static __initdata struct samsung_pll_rate_table vpll_24mhz_tbl[] = {
 	{ },
 };
 
-static __initdata struct samsung_pll_rate_table epll_24mhz_tbl[] = {
+static struct samsung_pll_rate_table epll_24mhz_tbl[] __initdata = {
 	/* sorted in descending order */
 	/* PLL_36XX_RATE(rate, m, p, s, k) */
 	PLL_36XX_RATE(192000000, 64, 2, 2, 0),
@@ -517,7 +517,7 @@ static __initdata struct samsung_pll_rate_table epll_24mhz_tbl[] = {
 	{ },
 };
 
-static struct __initdata samsung_pll_clock exynos5250_plls[nr_plls] = {
+static struct samsung_pll_clock exynos5250_plls[nr_plls] __initdata = {
 	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, "fout_apll", NULL),
 	[mpll] = PLL_A(pll_35xx, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
@@ -534,7 +534,7 @@ static struct __initdata samsung_pll_clock exynos5250_plls[nr_plls] = {
 		VPLL_LOCK, VPLL_CON0, NULL),
 };
 
-static __initdata struct of_device_id ext_clk_match[] = {
+static struct of_device_id ext_clk_match[] __initdata = {
 	{ .compatible = "samsung,clock-xxti", .data = (void *)0, },
 	{ },
 };
-- 
1.7.9.5
