From: greenfoo@gluegarage.com (Fernando Ramos)
Date: Thu, 15 Nov 2018 23:16:22 +0100
Subject: [PATCH 2/9] drm: remove deprecated
 "[__]drm_gem_object_[un]reference[_locked]" functions
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
Message-ID: <20181115221634.22715-3-greenfoo@gluegarage.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no more places where these (deprecated) functions are being
used from, thus they can now be removed.

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 include/drm/drm_gem.h | 50 -------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 3583b98a1718..daa34328b5be 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -222,56 +222,6 @@ __drm_gem_object_put(struct drm_gem_object *obj)
 void drm_gem_object_put_unlocked(struct drm_gem_object *obj);
 void drm_gem_object_put(struct drm_gem_object *obj);
 
-/**
- * drm_gem_object_reference - acquire a GEM buffer object reference
- * @obj: GEM buffer object
- *
- * This is a compatibility alias for drm_gem_object_get() and should not be
- * used by new code.
- */
-static inline void drm_gem_object_reference(struct drm_gem_object *obj)
-{
-	drm_gem_object_get(obj);
-}
-
-/**
- * __drm_gem_object_unreference - raw function to release a GEM buffer object
- *                                reference
- * @obj: GEM buffer object
- *
- * This is a compatibility alias for __drm_gem_object_put() and should not be
- * used by new code.
- */
-static inline void __drm_gem_object_unreference(struct drm_gem_object *obj)
-{
-	__drm_gem_object_put(obj);
-}
-
-/**
- * drm_gem_object_unreference_unlocked - release a GEM buffer object reference
- * @obj: GEM buffer object
- *
- * This is a compatibility alias for drm_gem_object_put_unlocked() and should
- * not be used by new code.
- */
-static inline void
-drm_gem_object_unreference_unlocked(struct drm_gem_object *obj)
-{
-	drm_gem_object_put_unlocked(obj);
-}
-
-/**
- * drm_gem_object_unreference - release a GEM buffer object reference
- * @obj: GEM buffer object
- *
- * This is a compatibility alias for drm_gem_object_put() and should not be
- * used by new code.
- */
-static inline void drm_gem_object_unreference(struct drm_gem_object *obj)
-{
-	drm_gem_object_put(obj);
-}
-
 int drm_gem_handle_create(struct drm_file *file_priv,
 			  struct drm_gem_object *obj,
 			  u32 *handlep);
-- 
2.19.1
