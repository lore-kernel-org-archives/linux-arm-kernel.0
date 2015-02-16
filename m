From: mikko.rapeli@iki.fi (Mikko Rapeli)
Date: Tue, 17 Feb 2015 00:05:10 +0100
Subject: [PATCH 07/45] exynos_drm.h: include stdint.h in userspace
In-Reply-To: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
References: <1424127948-22484-1-git-send-email-mikko.rapeli@iki.fi>
Message-ID: <1424127948-22484-8-git-send-email-mikko.rapeli@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes compilation errors like:

drm/exynos_drm.h:30:2: error: unknown type name ?uint64_t?

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/drm/exynos_drm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index 5575ed1..03d094d 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -15,6 +15,11 @@
 #ifndef _UAPI_EXYNOS_DRM_H_
 #define _UAPI_EXYNOS_DRM_H_
 
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
 #include <drm/drm.h>
 
 /**
-- 
2.1.4
