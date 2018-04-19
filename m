From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 19 Apr 2018 11:39:45 -0600
Subject: [PATCH 2/3] coresight tmc etr: Fix uninitialised variable
In-Reply-To: <1524159586-4841-1-git-send-email-mathieu.poirier@linaro.org>
References: <1524159586-4841-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1524159586-4841-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Variable 'paddr' can't be used if uninitialised but is nonetheless
confusing to some static checker.  As such simply initialise it to zero.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 8ee8c66f4002..f57199580c11 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -113,7 +113,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	bool used = false;
 	unsigned long flags;
 	void __iomem *vaddr = NULL;
-	dma_addr_t paddr;
+	dma_addr_t paddr = 0;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 
-- 
2.7.4
