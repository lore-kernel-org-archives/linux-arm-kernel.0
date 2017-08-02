From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed,  2 Aug 2017 16:32:23 +0800
Subject: [PATCH v2 04/23] clk: rockchip: support more rates for cpuclk
In-Reply-To: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1501662743-11920-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

fix up the cpuclk rates table for support more freqs.
fix up the mux_core_mask describe error.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- split the new added clks and rename.

 drivers/clk/rockchip/clk-rv1108.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index 7c05ab3..3c670db 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -93,9 +93,24 @@ static struct rockchip_pll_rate_table rv1108_pll_rates[] = {
 	}
 
 static struct rockchip_cpuclk_rate_table rv1108_cpuclk_rates[] __initdata = {
-	RV1108_CPUCLK_RATE(816000000, 4),
-	RV1108_CPUCLK_RATE(600000000, 4),
-	RV1108_CPUCLK_RATE(312000000, 4),
+	RV1108_CPUCLK_RATE(1608000000, 7),
+	RV1108_CPUCLK_RATE(1512000000, 7),
+	RV1108_CPUCLK_RATE(1488000000, 5),
+	RV1108_CPUCLK_RATE(1416000000, 5),
+	RV1108_CPUCLK_RATE(1392000000, 5),
+	RV1108_CPUCLK_RATE(1296000000, 5),
+	RV1108_CPUCLK_RATE(1200000000, 5),
+	RV1108_CPUCLK_RATE(1104000000, 5),
+	RV1108_CPUCLK_RATE(1008000000, 5),
+	RV1108_CPUCLK_RATE(912000000, 5),
+	RV1108_CPUCLK_RATE(816000000, 3),
+	RV1108_CPUCLK_RATE(696000000, 3),
+	RV1108_CPUCLK_RATE(600000000, 3),
+	RV1108_CPUCLK_RATE(500000000, 3),
+	RV1108_CPUCLK_RATE(408000000, 1),
+	RV1108_CPUCLK_RATE(312000000, 1),
+	RV1108_CPUCLK_RATE(216000000, 1),
+	RV1108_CPUCLK_RATE(96000000, 1),
 };
 
 static const struct rockchip_cpuclk_reg_data rv1108_cpuclk_data = {
@@ -105,7 +120,7 @@ static const struct rockchip_cpuclk_reg_data rv1108_cpuclk_data = {
 	.mux_core_alt = 1,
 	.mux_core_main = 0,
 	.mux_core_shift = 8,
-	.mux_core_mask = 0x1,
+	.mux_core_mask = 0x3,
 };
 
 PNAME(mux_pll_p)		= { "xin24m", "xin24m"};
-- 
2.7.4
