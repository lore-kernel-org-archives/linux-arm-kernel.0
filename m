From: jiada_wang@mentor.com (Jiada Wang)
Date: Fri, 7 Jun 2013 18:36:46 +0900
Subject: [PATCH] staging: imx-drm: Add MODULE_DEVICE_TABLE to parallel display
Message-ID: <1370597806-15718-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MODULE_DEVICE_TABLE annotation so that parallel display module
can be autoloaded based on the device-tree information.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/staging/imx-drm/parallel-display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index e7fba62..3c4e2c6 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -265,6 +265,7 @@ static const struct of_device_id imx_pd_dt_ids[] = {
 	{ .compatible = "fsl,imx-parallel-display", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, imx_pd_dt_ids);
 
 static struct platform_driver imx_pd_driver = {
 	.probe		= imx_pd_probe,
-- 
1.8.1.1
