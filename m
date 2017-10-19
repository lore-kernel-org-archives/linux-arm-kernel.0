From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 16:45:16 +0100
Subject: [PATCH] coresight: ETM: Add support for ARM Cortex-A73
Message-ID: <20171019154516.24536-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM Cortex A-73 ETM PIDs to the known ETM ips. While at it
also add description of the CPU to which the ETM belongs, to make
it easier to identify the ETM devices.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index cf364a514c12..e84d80b008fc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1034,7 +1034,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "CPU%d: %s initialized\n",
+			drvdata->cpu, (char *)id->data);
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1053,20 +1054,25 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 }
 
 static const struct amba_id etm4_ids[] = {
-	{       /* ETM 4.0 - Cortex-A53  */
+	{
 		.id	= 0x000bb95d,
 		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
+		.data	= "Cortex-A53 ETM v4.0",
 	},
-	{       /* ETM 4.0 - Cortex-A57 */
+	{
 		.id	= 0x000bb95e,
 		.mask	= 0x000fffff,
-		.data	= "ETM 4.0",
+		.data	= "Cortex-A57 ETM v4.0",
 	},
-	{       /* ETM 4.0 - A72, Maia, HiSilicon */
-		.id = 0x000bb95a,
-		.mask = 0x000fffff,
-		.data = "ETM 4.0",
+	{
+		.id	= 0x000bb95a,
+		.mask	= 0x000fffff,
+		.data	= "Cortex-A72 ETM v4.0",
+	},
+	{
+		.id	= 0x000bb959,
+		.mask	= 0x000fffff,
+		.data	= "Cortex-A73 ETM v4.0",
 	},
 	{ 0, 0},
 };
-- 
2.13.6
