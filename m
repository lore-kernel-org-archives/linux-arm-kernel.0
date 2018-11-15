From: greenfoo@gluegarage.com (Fernando Ramos)
Date: Thu, 15 Nov 2018 23:16:21 +0100
Subject: [PATCH 1/9] drm: replace "drm_gem_object_unreference_unlocked"
 function with "*put_unlocked"
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
Message-ID: <20181115221634.22715-2-greenfoo@gluegarage.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch unifies the naming of DRM functions for reference counting as
requested on Documentation/gpu/todo.rst

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 drivers/gpu/drm/bochs/bochs_mm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index a61c1ecb2bdc..e6ccf7fa92d4 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -414,7 +414,7 @@ int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
 		return ret;
 
 	ret = drm_gem_handle_create(file, gobj, &handle);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	if (ret)
 		return ret;
 
@@ -454,6 +454,6 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 	bo = gem_to_bochs_bo(obj);
 	*offset = bochs_bo_mmap_offset(bo);
 
-	drm_gem_object_unreference_unlocked(obj);
+	drm_gem_object_put_unlocked(obj);
 	return 0;
 }
-- 
2.19.1
