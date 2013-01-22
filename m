From: archit@ti.com (Archit Taneja)
Date: Tue, 22 Jan 2013 13:58:47 +0530
Subject: [PATCH] arm: omap: Fix build break in drm.c
Message-ID: <1358843328-8178-1-git-send-email-archit@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building omapdrm leads to a build break because of a missing include needed
for the macro GET_OMAP_REVISION(). Add the missing inlclude.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/drm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/drm.c b/arch/arm/mach-omap2/drm.c
index 4c7566c..6b1a8df 100644
--- a/arch/arm/mach-omap2/drm.c
+++ b/arch/arm/mach-omap2/drm.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/omap_drm.h>
 
+#include "soc.h"
 #include "omap_device.h"
 #include "omap_hwmod.h"
 
-- 
1.7.9.5
