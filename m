From: axel.lin@gmail.com (Axel Lin)
Date: Thu, 03 Nov 2011 15:00:38 +0800
Subject: [PATCH RESEND] ARM: OMAP: omap_device: Include linux/export.h
Message-ID: <1320303638.17983.5.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include linux/export.h to fix below build warning:

  CC      arch/arm/plat-omap/omap_device.o
arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This resend also CC linux-omap at vger.kernel.org and linux-arm-kernel at lists.infradead.org.
This patch is against linux-next 20111103.

 arch/arm/plat-omap/omap_device.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index cd90bed..f839f94 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -78,6 +78,7 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
+#include <linux/export.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-- 
1.7.5.4
