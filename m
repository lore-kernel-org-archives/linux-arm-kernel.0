From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Nov 2015 15:50:53 +0100
Subject: [PATCH] drm/gem: remove unused variable in drm_gem_cma_prime_mmap
Message-ID: <5381396.mRN26lWq1C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mutex is no longer used in drm_gem_cma_prime_mmap,
the 'dev' variable is not referenced either, which gcc warns about:

drivers/gpu/drm/drm_gem_cma_helper.c:484:21: warning: unused variable 'dev'

This removes it too.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4e270f088011 ("drm/gem: Drop struct_mutex requirement from drm_gem_mmap_obj")
---
Currently in drm-next, warning found on yesterday's linux-next with ARM randconfig builds

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 4fb4c45d039f..e109b49cd25d 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -481,7 +481,6 @@ int drm_gem_cma_prime_mmap(struct drm_gem_object *obj,
 			   struct vm_area_struct *vma)
 {
 	struct drm_gem_cma_object *cma_obj;
-	struct drm_device *dev = obj->dev;
 	int ret;
 
 	ret = drm_gem_mmap_obj(obj, obj->size, vma);
