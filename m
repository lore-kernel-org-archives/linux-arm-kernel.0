From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 31 Aug 2012 14:21:31 +0200
Subject: [PATCH 4/4] clk: ux500: Define smp_twd clock for u8500
In-Reply-To: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
References: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1346415691-13371-5-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The smp_twd clock is based upon a prcmu_rate clock type
for the PRCMU_ARMSS clock.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/u8500_clk.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
index 5c1fca1..ca4a25e 100644
--- a/drivers/clk/ux500/u8500_clk.c
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -205,12 +205,16 @@ void u8500_clk_init(void)
 	clk_register_clkdev(clk, "dsilp2", "dsilink.2");
 	clk_register_clkdev(clk, "dsilp2", "mcde");
 
+	clk = clk_reg_prcmu_rate("smp_twd", NULL, PRCMU_ARMSS,
+				CLK_IS_ROOT|CLK_GET_RATE_NOCACHE|
+				CLK_IGNORE_UNUSED);
+	clk_register_clkdev(clk, NULL, "smp_twd");
+
 	/*
 	 * FIXME: Add special handled PRCMU clocks here:
-	 * 1. smp_twd, use PRCMU_ARMSS.
-	 * 2. clk_arm, use PRCMU_ARMCLK.
-	 * 3. clkout0yuv, use PRCMU as parent + need regulator + pinctrl.
-	 * 4. ab9540_clkout1yuv, see clkout0yuv
+	 * 1. clk_arm, use PRCMU_ARMCLK.
+	 * 2. clkout0yuv, use PRCMU as parent + need regulator + pinctrl.
+	 * 3. ab9540_clkout1yuv, see clkout0yuv
 	 */
 
 	/* PRCC P-clocks */
-- 
1.7.10
