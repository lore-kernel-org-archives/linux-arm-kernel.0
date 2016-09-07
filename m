From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Wed,  7 Sep 2016 19:01:28 +0800
Subject: [PATCH] drm/rockchip: mark symbols static where possible
Message-ID: <1473246088-780-1-git-send-email-baoyou.xie@linaro.org>
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
index a822d49..3723683 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -306,7 +306,7 @@ static struct drm_driver rockchip_drm_driver = {
 };
 
 #ifdef CONFIG_PM_SLEEP
-void rockchip_drm_fb_suspend(struct drm_device *drm)
+static void rockchip_drm_fb_suspend(struct drm_device *drm)
 {
 	struct rockchip_drm_private *priv = drm->dev_private;
 
@@ -315,7 +315,7 @@ void rockchip_drm_fb_suspend(struct drm_device *drm)
 	console_unlock();
 }
 
-void rockchip_drm_fb_resume(struct drm_device *drm)
+static void rockchip_drm_fb_resume(struct drm_device *drm)
 {
 	struct rockchip_drm_private *priv = drm->dev_private;
 
-- 
2.7.4
