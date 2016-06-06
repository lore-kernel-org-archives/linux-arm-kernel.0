From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Jun 2016 10:11:39 +0100
Subject: [PATCH v2 7/9] coresight: Cleanup TMC status check
In-Reply-To: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
References: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1465204301-24184-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the defined symbol rather than hardcoding the value to
check whether the TMC buffer is full.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index cdb29c9..69e104b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -68,7 +68,7 @@ static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 	 * Adjust the buffer to point to the beginning of the trace data
 	 * and the available trace data.
 	 */
-	if (val & BIT(0)) {
+	if (val & TMC_STS_FULL) {
 		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
 		drvdata->len = drvdata->size;
 	} else {
-- 
1.9.1
