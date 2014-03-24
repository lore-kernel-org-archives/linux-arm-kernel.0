From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 24 Mar 2014 20:14:48 +0800
Subject: [PATCH] drm/cma: include <drm/drmP.h> as needed
Message-ID: <1395663288-30940-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following error and warnings will be seen when compiling a C file
which includes <drm/drm_gem_cma_helper.h> but without <drm/drmP.h>
being included before.

include/drm/drm_gem_cma_helper.h:5:24: error: field ?base? has incomplete type
include/drm/drm_gem_cma_helper.h: In function ?to_drm_gem_cma_obj?:
include/drm/drm_gem_cma_helper.h:16:9: warning: initialization from incompatible pointer type [enabled by default]
include/drm/drm_gem_cma_helper.h: At top level:
include/drm/drm_gem_cma_helper.h:24:34: warning: ?struct drm_mode_create_dumb? declared inside parameter list [enabled by default]
include/drm/drm_gem_cma_helper.h:24:34: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
include/drm/drm_gem_cma_helper.h:24:34: warning: ?struct drm_device? declared inside parameter list [enabled by default]
include/drm/drm_gem_cma_helper.h:24:34: warning: ?struct drm_file? declared inside parameter list [enabled by default]
include/drm/drm_gem_cma_helper.h:28:10: warning: ?struct drm_device? declared inside parameter list [enabled by default]
include/drm/drm_gem_cma_helper.h:28:10: warning: ?struct drm_file? declared inside parameter list [enabled by default]
include/drm/drm_gem_cma_helper.h:35:3: warning: ?struct drm_device? declared inside parameter list [enabled by default]
include/drm/drm_gem_cma_helper.h:46:14: warning: ?struct drm_device? declared inside parameter list [enabled by default]

Fix them by including <drm/drmP.h> in drm_gem_cma_helper.h.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 include/drm/drm_gem_cma_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index 89b4d7d..2a3cea9 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -1,6 +1,8 @@
 #ifndef __DRM_GEM_CMA_HELPER_H__
 #define __DRM_GEM_CMA_HELPER_H__
 
+#include <drm/drmP.h>
+
 struct drm_gem_cma_object {
 	struct drm_gem_object base;
 	dma_addr_t paddr;
-- 
1.8.3.2
