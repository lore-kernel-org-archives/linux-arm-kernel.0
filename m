From: mikko.rapeli@iki.fi (Mikko Rapeli)
Date: Sat, 30 May 2015 17:37:57 +0200
Subject: [PATCH 05/98] exynos_drm.h: use __u64 from linux/types.h
In-Reply-To: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
Message-ID: <1433000370-19509-6-git-send-email-mikko.rapeli@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes userspace compilation error:

drm/exynos_drm.h:30:2: error: unknown type name ?uint64_t?

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/drm/exynos_drm.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index 5575ed1..c4468f9 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -15,6 +15,7 @@
 #ifndef _UAPI_EXYNOS_DRM_H_
 #define _UAPI_EXYNOS_DRM_H_
 
+#include <linux/types.h>
 #include <drm/drm.h>
 
 /**
@@ -27,7 +28,7 @@
  *	- this handle will be set by gem module of kernel side.
  */
 struct drm_exynos_gem_create {
-	uint64_t size;
+	__u64 size;
 	unsigned int flags;
 	unsigned int handle;
 };
@@ -44,7 +45,7 @@ struct drm_exynos_gem_create {
 struct drm_exynos_gem_info {
 	unsigned int handle;
 	unsigned int flags;
-	uint64_t size;
+	__u64 size;
 };
 
 /**
@@ -58,7 +59,7 @@ struct drm_exynos_gem_info {
 struct drm_exynos_vidi_connection {
 	unsigned int connection;
 	unsigned int extensions;
-	uint64_t edid;
+	__u64 edid;
 };
 
 /* memory type definitions. */
-- 
2.1.4
