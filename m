From: greenfoo@gluegarage.com (Fernando Ramos)
Date: Thu, 15 Nov 2018 23:16:27 +0100
Subject: [PATCH 7/9] drm: remove deprecated "drm_framebuffer_[un]reference"
 functions
In-Reply-To: <20181115221634.22715-1-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
Message-ID: <20181115221634.22715-8-greenfoo@gluegarage.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no more places where this (deprecated) function is being used
from, thus it can now be removed.

Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
---
 include/drm/drm_framebuffer.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index c50502c656e5..c94acedfb08e 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -240,30 +240,6 @@ static inline void drm_framebuffer_put(struct drm_framebuffer *fb)
 	drm_mode_object_put(&fb->base);
 }
 
-/**
- * drm_framebuffer_reference - acquire a framebuffer reference
- * @fb: DRM framebuffer
- *
- * This is a compatibility alias for drm_framebuffer_get() and should not be
- * used by new code.
- */
-static inline void drm_framebuffer_reference(struct drm_framebuffer *fb)
-{
-	drm_framebuffer_get(fb);
-}
-
-/**
- * drm_framebuffer_unreference - release a framebuffer reference
- * @fb: DRM framebuffer
- *
- * This is a compatibility alias for drm_framebuffer_put() and should not be
- * used by new code.
- */
-static inline void drm_framebuffer_unreference(struct drm_framebuffer *fb)
-{
-	drm_framebuffer_put(fb);
-}
-
 /**
  * drm_framebuffer_read_refcount - read the framebuffer reference count.
  * @fb: framebuffer
-- 
2.19.1
