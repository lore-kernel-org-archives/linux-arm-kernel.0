From: nm@ti.com (Nishanth Menon)
Date: Wed, 29 Jan 2014 12:19:16 -0600
Subject: [PATCH 1/2] clk: ti: am335x: remove unecessary cpu0 clk node
In-Reply-To: <1391019557-22313-1-git-send-email-nm@ti.com>
References: <1391019557-22313-1-git-send-email-nm@ti.com>
Message-ID: <1391019557-22313-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu0 clock node has no functionality, since cpufreq-cpu0 is already
capable of picking up the clock from dts.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/clk/ti/clk-33xx.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 776ee45..028b337 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -34,7 +34,6 @@ static struct ti_dt_clk am33xx_clks[] = {
 	DT_CLK(NULL, "dpll_core_m5_ck", "dpll_core_m5_ck"),
 	DT_CLK(NULL, "dpll_core_m6_ck", "dpll_core_m6_ck"),
 	DT_CLK(NULL, "dpll_mpu_ck", "dpll_mpu_ck"),
-	DT_CLK("cpu0", NULL, "dpll_mpu_ck"),
 	DT_CLK(NULL, "dpll_mpu_m2_ck", "dpll_mpu_m2_ck"),
 	DT_CLK(NULL, "dpll_ddr_ck", "dpll_ddr_ck"),
 	DT_CLK(NULL, "dpll_ddr_m2_ck", "dpll_ddr_m2_ck"),
-- 
1.7.9.5
