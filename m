From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 May 2016 14:02:11 +0200
Subject: [PATCH 15/18] clk: samsung: exynos5433: Move PLL rates data to init
 section
In-Reply-To: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
References: <1462968134-6085-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1462968134-6085-15-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arrays with initialization data of PLLs can be moved to initconst
section because they are referenced only from other initconst-level
symbols.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos5433.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index f202a51ff99b..5993bd5ac6ba 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -693,7 +693,7 @@ static const struct samsung_gate_clock top_gate_clks[] __initconst = {
  * ATLAS_PLL & APOLLO_PLL & MEM0_PLL & MEM1_PLL & BUS_PLL & MFC_PLL
  * & MPHY_PLL & G3D_PLL & DISP_PLL & ISP_PLL
  */
-static const struct samsung_pll_rate_table exynos5443_pll_rates[] = {
+static const struct samsung_pll_rate_table exynos5443_pll_rates[] __initconst = {
 	PLL_35XX_RATE(2500000000U, 625, 6,  0),
 	PLL_35XX_RATE(2400000000U, 500, 5,  0),
 	PLL_35XX_RATE(2300000000U, 575, 6,  0),
@@ -744,7 +744,7 @@ static const struct samsung_pll_rate_table exynos5443_pll_rates[] = {
 };
 
 /* AUD_PLL */
-static const struct samsung_pll_rate_table exynos5443_aud_pll_rates[] = {
+static const struct samsung_pll_rate_table exynos5443_aud_pll_rates[] __initconst = {
 	PLL_36XX_RATE(400000000U, 200, 3, 2,      0),
 	PLL_36XX_RATE(393216000U, 197, 3, 2, -25690),
 	PLL_36XX_RATE(384000000U, 128, 2, 2,      0),
-- 
1.9.1
