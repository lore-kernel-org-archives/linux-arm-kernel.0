From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:12 +0200
Subject: [PATCH 16/18] clk: samsung: exynos5420: Move sleep init function and
 PLL rates data to init section
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-16-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos5420_clk_sleep_init() function and arrays with initialization
data of PLLs can be moved to init section because they are referenced
only from other init-level symbols.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index adb0ae4efb7a..79fb8557bcf3 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -306,7 +306,7 @@ static struct syscore_ops exynos5420_clk_syscore_ops = {
 	.resume = exynos5420_clk_resume,
 };
 
-static void exynos5420_clk_sleep_init(void)
+static void __init exynos5420_clk_sleep_init(void)
 {
 	exynos5x_save = samsung_clk_alloc_reg_dump(exynos5x_clk_regs,
 					ARRAY_SIZE(exynos5x_clk_regs));
@@ -333,7 +333,7 @@ err_soc:
 	return;
 }
 #else
-static void exynos5420_clk_sleep_init(void) {}
+static void __init exynos5420_clk_sleep_init(void) {}
 #endif
 
 /* list of all parent clocks */
@@ -1219,7 +1219,7 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
 	GATE(CLK_G3D, "g3d", "mout_user_aclk_g3d", GATE_IP_G3D, 9, 0, 0),
 };
 
-static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] = {
+static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
 	PLL_35XX_RATE(2000000000, 250, 3, 0),
 	PLL_35XX_RATE(1900000000, 475, 6, 0),
 	PLL_35XX_RATE(1800000000, 225, 3, 0),
-- 
1.9.1
