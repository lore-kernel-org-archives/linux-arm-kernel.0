From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:52 -0600
Subject: [PATCH 11/11] coresight: removing gratuitous boot time log messages
In-Reply-To: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
References: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1459878832-15219-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing boot time log for drivers that don't report useful information
other than they came up properly.  The same information can be found in
sysFS once the system has booted and as such doesn't provide any value
in the boot log.

Reported-by: Mark Brown <broonie@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c      | 1 -
 drivers/hwtracing/coresight/coresight-funnel.c     | 1 -
 drivers/hwtracing/coresight/coresight-replicator.c | 1 -
 drivers/hwtracing/coresight/coresight-tmc.c        | 1 -
 drivers/hwtracing/coresight/coresight-tpiu.c       | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 8bf4429e1fb3..2461d5c8c157 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -724,7 +724,6 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		goto err_misc_register;
 
-	dev_info(dev, "ETB initialized\n");
 	return 0;
 
 err_misc_register:
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 0600ca30649d..05df789056cc 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -221,7 +221,6 @@ static int funnel_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
-	dev_info(dev, "FUNNEL initialized\n");
 	return 0;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 4299c0569340..c6982e312e15 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -114,7 +114,6 @@ static int replicator_probe(struct platform_device *pdev)
 
 	pm_runtime_put(&pdev->dev);
 
-	dev_info(dev, "REPLICATOR initialized\n");
 	return 0;
 
 out_disable_pm:
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 1be191f5d39c..0a4db1ac52ae 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -754,7 +754,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	if (ret)
 		goto err_misc_register;
 
-	dev_info(dev, "TMC initialized\n");
 	return 0;
 
 err_misc_register:
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 8fb09d9237ab..4e471e2e9d89 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -167,7 +167,6 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
 
-	dev_info(dev, "TPIU initialized\n");
 	return 0;
 }
 
-- 
2.1.4
