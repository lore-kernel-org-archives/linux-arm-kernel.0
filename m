From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri,  8 Jan 2016 19:31:37 +0800
Subject: [RESEND RFC PATCH 1/2] clk: rockchip: rk3036: Add to 100MHz integer
 multiples of cpu freq table
In-Reply-To: <1452252698-16765-1-git-send-email-zhengxing@rock-chips.com>
References: <1452252698-16765-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1452252698-16765-2-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need the cpu changing freqs capability, and considering that emac ref
which is need 50MHz might is under the APLL, meanwhile, we don't need
too many freqs because it may spend more time to find the correct freq.
Therefore, we should add 100MHz integer multiples cpu freqs for emac.

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3036.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index bf9dd9b..f60273c 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -32,18 +32,22 @@ enum rk3036_plls {
 static struct rockchip_pll_rate_table rk3036_pll_rates[] = {
 	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
 	RK3036_PLL_RATE(1608000000, 1, 67, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1600000000, 6, 400, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1584000000, 1, 66, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1560000000, 1, 65, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1536000000, 1, 64, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1512000000, 1, 63, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1500000000, 6, 375, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1488000000, 1, 62, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1464000000, 1, 61, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1440000000, 1, 60, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1416000000, 1, 59, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1400000000, 6, 350, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1392000000, 1, 58, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1368000000, 1, 57, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1344000000, 1, 56, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1320000000, 1, 55, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1300000000, 6, 325, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1296000000, 1, 54, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1272000000, 1, 53, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1248000000, 1, 52, 1, 1, 1, 0),
@@ -70,8 +74,12 @@ static struct rockchip_pll_rate_table rk3036_pll_rates[] = {
 	RK3036_PLL_RATE( 504000000, 1, 63, 3, 1, 1, 0),
 	RK3036_PLL_RATE( 500000000, 6, 250, 2, 1, 1, 0),
 	RK3036_PLL_RATE( 408000000, 1, 68, 2, 2, 1, 0),
+	RK3036_PLL_RATE( 400000000, 1, 100, 3, 2, 1, 0),
 	RK3036_PLL_RATE( 312000000, 1, 52, 2, 2, 1, 0),
+	RK3036_PLL_RATE( 300000000, 1, 50, 2, 2, 1, 0),
 	RK3036_PLL_RATE( 216000000, 1, 72, 4, 2, 1, 0),
+	RK3036_PLL_RATE( 200000000, 1, 50, 3, 2, 1, 0),
+	RK3036_PLL_RATE( 100000000, 6, 400, 4, 4, 1, 0),
 	RK3036_PLL_RATE(  96000000, 1, 64, 4, 4, 1, 0),
 	{ /* sentinel */ },
 };
@@ -104,9 +112,22 @@ static struct rockchip_pll_rate_table rk3036_pll_rates[] = {
 	}
 
 static struct rockchip_cpuclk_rate_table rk3036_cpuclk_rates[] __initdata = {
-	RK3036_CPUCLK_RATE(816000000, 4),
-	RK3036_CPUCLK_RATE(600000000, 4),
-	RK3036_CPUCLK_RATE(312000000, 4),
+	RK3036_CPUCLK_RATE(1600000000, 8),
+	RK3036_CPUCLK_RATE(1500000000, 7),
+	RK3036_CPUCLK_RATE(1400000000, 7),
+	RK3036_CPUCLK_RATE(1300000000, 6),
+	RK3036_CPUCLK_RATE(1200000000, 6),
+	RK3036_CPUCLK_RATE(1100000000, 5),
+	RK3036_CPUCLK_RATE(1000000000, 5),
+	RK3036_CPUCLK_RATE( 900000000, 4),
+	RK3036_CPUCLK_RATE( 800000000, 4),
+	RK3036_CPUCLK_RATE( 700000000, 3),
+	RK3036_CPUCLK_RATE( 600000000, 3),
+	RK3036_CPUCLK_RATE( 500000000, 3),
+	RK3036_CPUCLK_RATE( 400000000, 3),
+	RK3036_CPUCLK_RATE( 300000000, 2),
+	RK3036_CPUCLK_RATE( 200000000, 1),
+	RK3036_CPUCLK_RATE( 100000000, 1),
 };
 
 static const struct rockchip_cpuclk_reg_data rk3036_cpuclk_data = {
-- 
1.7.9.5
