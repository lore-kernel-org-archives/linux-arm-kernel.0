From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 30 Jun 2016 10:22:15 -0600
Subject: [PATCH 09/13] coresight: Cleanup TMC status check
In-Reply-To: <1467303739-12543-1-git-send-email-mathieu.poirier@linaro.org>
References: <1467303739-12543-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1467303739-12543-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Use the defined symbol rather than hardcoding the value to
check whether the TMC buffer is full.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 03f36cb8b0c8..6d7de0309e94 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -68,7 +68,7 @@ static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 	 * Adjust the buffer to point to the beginning of the trace data
 	 * and update the available trace data.
 	 */
-	if (val & BIT(0)) {
+	if (val & TMC_STS_FULL) {
 		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
 		drvdata->len = drvdata->size;
 	} else {
-- 
2.7.4
