From: gabriel@lse.epita.fr (Gabriel Laskar)
Date: Mon, 30 Nov 2015 15:10:45 +0100
Subject: [PATCH 07/20] drm: fix inclusion of drm.h in exynos_sarea.h
In-Reply-To: <1448892658-14256-1-git-send-email-gabriel@lse.epita.fr>
References: <1448892658-14256-1-git-send-email-gabriel@lse.epita.fr>
Message-ID: <1448892658-14256-8-git-send-email-gabriel@lse.epita.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using `#include "drm.h"` instead of `#include <drm/drm.h>` allow drm
headers to be moved in another directory without changes, like for the
libdrm imports.

Signed-off-by: Gabriel Laskar <gabriel@lse.epita.fr>
CC: Emil Velikov <emil.l.velikov@gmail.com>
CC: Mikko Rapeli <mikko.rapeli@iki.fi>

---
 include/uapi/drm/exynos_drm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index 5575ed1..a5b2dd9 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -15,7 +15,7 @@
 #ifndef _UAPI_EXYNOS_DRM_H_
 #define _UAPI_EXYNOS_DRM_H_
 
-#include <drm/drm.h>
+#include "drm.h"
 
 /**
  * User-desired buffer creation information structure.
-- 
2.6.2
