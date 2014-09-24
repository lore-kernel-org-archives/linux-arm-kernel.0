From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 24 Sep 2014 23:41:54 +0200
Subject: [PATCH] clk: rockchip: add missing rk3288 npll rate table
Message-ID: <1631893.xHvKLXVMyM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The npll on rk3288 is exactly the same pll type as the other 4. Yet it
was missing the link to the rate table, making rate changes impossible.
Change that by setting the table.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 8ea885b..938d30b 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -143,7 +143,7 @@ static struct rockchip_pll_clock rk3288_pll_clks[] __initdata = {
 	[gpll] = PLL(pll_rk3066, PLL_GPLL, "gpll", mux_pll_p, 0, RK3288_PLL_CON(12),
 		     RK3288_MODE_CON, 12, 8, rk3288_pll_rates),
 	[npll] = PLL(pll_rk3066, PLL_NPLL, "npll",  mux_pll_p, 0, RK3288_PLL_CON(16),
-		     RK3288_MODE_CON, 14, 9, NULL),
+		     RK3288_MODE_CON, 14, 9, rk3288_pll_rates),
 };
 
 static struct clk_div_table div_hclk_cpu_t[] = {
-- 
2.1.0
