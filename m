From: urjaman@gmail.com (Urja Rannikko)
Date: Tue, 28 Aug 2018 18:55:07 +0000
Subject: [PATCH 1/7] clk: rockchip: improve rk3288 pll rates for better hdmi
 output
In-Reply-To: <20180828185513.13216-1-urjaman@gmail.com>
References: <20180828185513.13216-1-urjaman@gmail.com>
Message-ID: <20180828185513.13216-2-urjaman@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add and correct PLL rates for better hdmi output.

This includes minimizing jitter on 213 MHz for better 71 MHz,
250.5 MHz for better 83.5 MHz, 428 MHz for better 25.175 Mhz,
low jitter 273 MHz for better 68.25 mhz, 356 MHz for better 118.68 Mhz
and 300MHz.

Increase the used Fvco for 308, 324 MHz, 292.5 MHz, 273.6 MHz,
238 MHz and 216 MHz.

And add some additional rates allowing to reach better hdmi-related
rates in general.

These match the rates used by ChromeOS, so have been quite widely tested.

Signed-off-by: Urja Rannikko <urjaman@gmail.com>
---
 drivers/clk/rockchip/clk-rk3288.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 450de24a1b42..5a67b7869960 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -83,22 +83,43 @@ static struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	RK3066_PLL_RATE( 768000000, 1, 64, 2),
 	RK3066_PLL_RATE( 742500000, 8, 495, 2),
 	RK3066_PLL_RATE( 696000000, 1, 58, 2),
+	RK3066_PLL_RATE_NB(621000000, 1, 207, 8, 1),
 	RK3066_PLL_RATE( 600000000, 1, 50, 2),
 	RK3066_PLL_RATE_NB(594000000, 1, 198, 8, 1),
 	RK3066_PLL_RATE( 552000000, 1, 46, 2),
 	RK3066_PLL_RATE( 504000000, 1, 84, 4),
 	RK3066_PLL_RATE( 500000000, 3, 125, 2),
 	RK3066_PLL_RATE( 456000000, 1, 76, 4),
+	RK3066_PLL_RATE( 428000000, 1, 107, 6),
 	RK3066_PLL_RATE( 408000000, 1, 68, 4),
 	RK3066_PLL_RATE( 400000000, 3, 100, 2),
+	RK3066_PLL_RATE_NB( 394000000, 1, 197, 12, 1),
 	RK3066_PLL_RATE( 384000000, 2, 128, 4),
 	RK3066_PLL_RATE( 360000000, 1, 60, 4),
+	RK3066_PLL_RATE_NB( 356000000, 1, 178, 12, 1),
+	RK3066_PLL_RATE_NB( 324000000, 1, 189, 14, 1),
 	RK3066_PLL_RATE( 312000000, 1, 52, 4),
-	RK3066_PLL_RATE( 300000000, 1, 50, 4),
-	RK3066_PLL_RATE( 297000000, 2, 198, 8),
+	RK3066_PLL_RATE_NB( 308000000, 1, 154, 12, 1),
+	RK3066_PLL_RATE_NB( 303000000, 1, 202, 16, 1),
+	RK3066_PLL_RATE( 300000000, 1, 75, 6),
+	RK3066_PLL_RATE_NB( 297750000, 2, 397, 16, 1),
+	RK3066_PLL_RATE_NB( 293250000, 2, 391, 16, 1),
+	RK3066_PLL_RATE_NB( 292500000, 1, 195, 16, 1),
+	RK3066_PLL_RATE( 273600000, 1, 114, 10),
+	RK3066_PLL_RATE_NB( 273000000, 1, 182, 16, 1),
+	RK3066_PLL_RATE_NB( 270000000, 1, 180, 16, 1),
+	RK3066_PLL_RATE_NB( 266250000, 2, 355, 16, 1),
+	RK3066_PLL_RATE_NB( 256500000, 1, 171, 16, 1),
 	RK3066_PLL_RATE( 252000000, 1, 84, 8),
-	RK3066_PLL_RATE( 216000000, 1, 72, 8),
-	RK3066_PLL_RATE( 148500000, 2, 99, 8),
+	RK3066_PLL_RATE_NB( 250500000, 1, 167, 16, 1),
+	RK3066_PLL_RATE_NB( 243428571, 1, 142, 14, 1),
+	RK3066_PLL_RATE( 238000000, 1, 119, 12),
+	RK3066_PLL_RATE_NB( 219750000, 2, 293, 16, 1),
+	RK3066_PLL_RATE_NB( 216000000, 1, 144, 16, 1),
+	RK3066_PLL_RATE_NB( 213000000, 1, 142, 16, 1),
+	RK3066_PLL_RATE( 195428571, 1, 114, 14),
+	RK3066_PLL_RATE( 160000000, 1, 80, 12),
+	RK3066_PLL_RATE( 157500000, 1, 105, 16),
 	RK3066_PLL_RATE( 126000000, 1, 84, 16),
 	RK3066_PLL_RATE(  48000000, 1, 64, 32),
 	{ /* sentinel */ },
-- 
2.18.0
