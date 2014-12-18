From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 18 Dec 2014 20:22:34 +0100
Subject: [PATCH] clk: rockchip: fix rk3288 cpuclk core dividers
Message-ID: <1590307.oZ7E5cNY8h@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0e5bdb3f9fa5 (clk: rockchip: switch to using the new cpuclk type
for armclk) didn't take into account that the divider used on rk3288
are of the (n+1) type.

The rk3066 and rk3188 socs use more complex divider types making it
necessary for the list-elements to be the real register-values to write.

Therefore reduce divider values in the table accordingly so that they
really are the values that should be written to the registers.

Reported-by: Sonny Rao <sonnyrao@chromium.org>
Fixes: 0e5bdb3f9fa5
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Cc: stable at vger.kernel.org
---
 drivers/clk/rockchip/clk-rk3288.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index ac6be7c..11194b8 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -145,20 +145,20 @@ struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	}
 
 static struct rockchip_cpuclk_rate_table rk3288_cpuclk_rates[] __initdata = {
-	RK3288_CPUCLK_RATE(1800000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE(1704000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE(1608000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE(1512000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE(1416000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE(1200000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE(1008000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE( 816000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE( 696000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE( 600000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE( 408000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE( 312000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE( 216000000, 2, 4, 2, 4, 4),
-	RK3288_CPUCLK_RATE( 126000000, 2, 4, 2, 4, 4),
+	RK3288_CPUCLK_RATE(1800000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE(1704000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE(1608000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE(1512000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE(1416000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE(1200000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE(1008000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE( 816000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE( 696000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE( 600000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE( 408000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE( 312000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE( 216000000, 1, 3, 1, 3, 3),
+	RK3288_CPUCLK_RATE( 126000000, 1, 3, 1, 3, 3),
 };
 
 static const struct rockchip_cpuclk_reg_data rk3288_cpuclk_data = {
-- 
2.1.1
