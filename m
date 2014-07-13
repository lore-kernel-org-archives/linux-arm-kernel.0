From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 13 Jul 2014 12:19:03 +0100
Subject: [PATCH] drm: shmobile: fix warnings
Message-ID: <E1X6Ho7-0006ru-U9@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/gpu/drm/shmobile/shmob_drm_drv.c:300:5: warning: "CONFIG_PM_SLEEP" is not defined [-Wundef]

Always use #ifdef with CONFIG symbols, never just bare #if

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/shmobile/shmob_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
index 82c84c7fd4f6..ff4ba483b602 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
@@ -297,7 +297,7 @@ static struct drm_driver shmob_drm_driver = {
  * Power management
  */
 
-#if CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 static int shmob_drm_pm_suspend(struct device *dev)
 {
 	struct shmob_drm_device *sdev = dev_get_drvdata(dev);
-- 
1.8.3.1
