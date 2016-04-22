From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 Apr 2016 11:14:01 -0600
Subject: [PATCH V3 04/18] coresight: tmc: clearly define number of transfers
 per burst
In-Reply-To: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
References: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1461345255-11758-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes the name of the define reflect the amount of
data tranfers per burst, in this case 16.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index d211aeec49f8..8751d53fa078 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -67,7 +67,7 @@
 #define TMC_AXICTL_PROT_CTL_B0	BIT(0)
 #define TMC_AXICTL_PROT_CTL_B1	BIT(1)
 #define TMC_AXICTL_SCT_GAT_MODE	BIT(7)
-#define TMC_AXICTL_WR_BURST_LEN 0xF00
+#define TMC_AXICTL_WR_BURST_16	0xF00
 /* TMC_FFCR - 0x304 */
 #define TMC_FFCR_EN_FMT		BIT(0)
 #define TMC_FFCR_EN_TI		BIT(1)
@@ -211,7 +211,7 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
 
 	axictl = readl_relaxed(drvdata->base + TMC_AXICTL);
-	axictl |= TMC_AXICTL_WR_BURST_LEN;
+	axictl |= TMC_AXICTL_WR_BURST_16;
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
 	axictl &= ~TMC_AXICTL_SCT_GAT_MODE;
 	writel_relaxed(axictl, drvdata->base + TMC_AXICTL);
-- 
2.5.0
