From: linux.amoon@gmail.com (Anand Moon)
Date: Fri, 23 Nov 2018 09:44:11 +0000
Subject: [PATCH 1/3] clk: samsung: exynos5420: add VPLL rate table for g3d
 clock
Message-ID: <20181123094413.1108-1-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marian Mihailescu <mihailescu2m@gmail.com>

A specific clock rate table is added for VPLL so it is possible
to set frequency of the VPLL output clock that used by the g3d clock.

Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 34cce3c5898f..34156bdfd0d2 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1303,6 +1303,18 @@ static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ,  32768001U, 131, 3, 5, 4719),
 };
 
+static const struct samsung_pll_rate_table exynos5420_vpll_24mhz_tbl[] __initconst = {
+	PLL_35XX_RATE(24 * MHZ, 600000000U, 200, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 543000000U, 181, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 533000000U, 533, 6, 2),
+	PLL_35XX_RATE(24 * MHZ, 480000000U, 320, 4, 2),
+	PLL_35XX_RATE(24 * MHZ, 420000000U, 140, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 350000000U, 175, 3, 2),
+	PLL_35XX_RATE(24 * MHZ, 266000000U, 266, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 177000000U, 118, 2, 3),
+	PLL_35XX_RATE(24 * MHZ, 100000000U, 200, 3, 4),
+};
+
 static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata = {
 	[apll] = PLL(pll_2550, CLK_FOUT_APLL, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, NULL),
@@ -1428,6 +1440,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[vpll].rate_table = exynos5420_vpll_24mhz_tbl;
 	}
 
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
-- 
2.17.1
