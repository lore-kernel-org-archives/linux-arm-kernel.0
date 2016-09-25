From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Sun, 25 Sep 2016 15:43:08 +0800
Subject: [PATCH 2/2] drm/rockchip: mark symbols static where possible
Message-ID: <1474789388-3284-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 2 warnings when building kernel with W=1:
drivers/gpu/drm/rockchip/rockchip_drm_drv.c:309:6: warning: no previous prototype for 'rockchip_drm_fb_suspend' [-Wmissing-prototypes]
drivers/gpu/drm/rockchip/rockchip_drm_drv.c:318:6: warning: no previous prototype for 'rockchip_drm_fb_resume' [-Wmissing-prototypes]

In fact, these functions are only used in the file in which they are
declared and don't need a declaration, but can be made static.
So this patch marks these functions with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 76eaf1d..38c3be5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -309,7 +309,7 @@ static struct drm_driver rockchip_drm_driver = {
 };
 
 #ifdef CONFIG_PM_SLEEP
-void rockchip_drm_fb_suspend(struct drm_device *drm)
+static void rockchip_drm_fb_suspend(struct drm_device *drm)
 {
 	struct rockchip_drm_private *priv = drm->dev_private;
 
@@ -318,7 +318,7 @@ void rockchip_drm_fb_suspend(struct drm_device *drm)
 	console_unlock();
 }
 
-void rockchip_drm_fb_resume(struct drm_device *drm)
+static void rockchip_drm_fb_resume(struct drm_device *drm)
 {
 	struct rockchip_drm_private *priv = drm->dev_private;
 
-- 
2.7.4
