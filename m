From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 12 Nov 2012 16:17:08 +0100
Subject: [PATCH linux-next] ARM: OMAP2: Fix compillation error in cm_common
Message-ID: <1352733428-27889-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following error:
  CC      arch/arm/mach-omap2/cm_common.o
arch/arm/mach-omap2/cm_common.c: In function ?cm_register?:
arch/arm/mach-omap2/cm_common.c:42:11: error: ?EINVAL? undeclared (first use in this function)
arch/arm/mach-omap2/cm_common.c:42:11: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/mach-omap2/cm_common.c:45:11: error: ?EEXIST? undeclared (first use in this function)
arch/arm/mach-omap2/cm_common.c: In function ?cm_unregister?:
arch/arm/mach-omap2/cm_common.c:66:11: error: ?EINVAL? undeclared (first use in this function)
make[1]: *** [arch/arm/mach-omap2/cm_common.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi,

with today's linux-next the kernel build failed with the abive error for OMAP.

Regards,
Peter

 arch/arm/mach-omap2/cm_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 3246cef..3fafc27 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/errno.h>
 
 #include "cm2xxx.h"
 #include "cm3xxx.h"
-- 
1.8.0
