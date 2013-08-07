From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed,  7 Aug 2013 10:18:39 +0530
Subject: [PATCH 3/4] clk: exynos5420: Fix incorrect placement of __initdata
In-Reply-To: <1375850921-23122-1-git-send-email-sachin.kamat@linaro.org>
References: <1375850921-23122-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1375850921-23122-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos5420.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 872e13d..e035fd0 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -147,7 +147,7 @@ enum exynos5420_clks {
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
  */
-static __initdata unsigned long exynos5420_clk_regs[] = {
+static unsigned long exynos5420_clk_regs[] __initdata = {
 	SRC_CPU,
 	DIV_CPU0,
 	DIV_CPU1,
@@ -727,7 +727,7 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
 	GATE(smmu_mscl2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0, 0),
 };
 
-static struct __initdata samsung_pll_clock exynos5420_plls[nr_plls] = {
+static struct samsung_pll_clock exynos5420_plls[nr_plls] __initdata = {
 	[apll] = PLL(pll_2550, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
 	[cpll] = PLL(pll_2550, fout_mpll, "fout_mpll", "fin_pll", MPLL_LOCK,
@@ -752,7 +752,7 @@ static struct __initdata samsung_pll_clock exynos5420_plls[nr_plls] = {
 		KPLL_CON0, NULL),
 };
 
-static __initdata struct of_device_id ext_clk_match[] = {
+static struct of_device_id ext_clk_match[] __initdata = {
 	{ .compatible = "samsung,exynos5420-oscclk", .data = (void *)0, },
 	{ },
 };
-- 
1.7.9.5
