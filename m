From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:12:16 +0200
Subject: [PATCH] clk: samsung: exynos3250: Move PLL rates data to init section
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968736-7568-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arrays with initialization data of PLLs can be moved to initconst
section because they are referenced only from other initconst-level
symbols.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos3250.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 057c3f0d0e35..b2513959252d 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -669,7 +669,7 @@ static const struct samsung_gate_clock gate_clks[] __initconst = {
 };
 
 /* APLL & MPLL & BPLL & UPLL */
-static const struct samsung_pll_rate_table exynos3250_pll_rates[] = {
+static const struct samsung_pll_rate_table exynos3250_pll_rates[] __initconst = {
 	PLL_35XX_RATE(1200000000, 400, 4, 1),
 	PLL_35XX_RATE(1100000000, 275, 3, 1),
 	PLL_35XX_RATE(1066000000, 533, 6, 1),
@@ -691,7 +691,7 @@ static const struct samsung_pll_rate_table exynos3250_pll_rates[] = {
 };
 
 /* EPLL */
-static const struct samsung_pll_rate_table exynos3250_epll_rates[] = {
+static const struct samsung_pll_rate_table exynos3250_epll_rates[] __initconst = {
 	PLL_36XX_RATE(800000000, 200, 3, 1,     0),
 	PLL_36XX_RATE(288000000,  96, 2, 2,     0),
 	PLL_36XX_RATE(192000000, 128, 2, 3,     0),
-- 
1.9.1
