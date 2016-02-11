From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 10:10:00 +0100
Subject: [PATCH] drm/msm: remove unused variable
Message-ID: <1455181810-3910161-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the drm_device_is_unplugged() was removed, the 'dev' variable is now
unused, and we get a warning for that:

drivers/gpu/drm/msm/msm_fbdev.c: In function 'msm_fbdev_mmap':
drivers/gpu/drm/msm/msm_fbdev.c:65:21: error: unused variable 'dev' [-Werror=unused-variable]

This removes the variable as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e9f8250f2f92 ("drm/msm: remove the drm_device_is_unplugged check")
---
 drivers/gpu/drm/msm/msm_fbdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index e119c2979509..d9759bf3482e 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -62,7 +62,6 @@ static int msm_fbdev_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	struct drm_fb_helper *helper = (struct drm_fb_helper *)info->par;
 	struct msm_fbdev *fbdev = to_msm_fbdev(helper);
 	struct drm_gem_object *drm_obj = fbdev->bo;
-	struct drm_device *dev = helper->dev;
 	int ret = 0;
 
 	ret = drm_gem_mmap_obj(drm_obj, drm_obj->size, vma);
-- 
2.7.0
