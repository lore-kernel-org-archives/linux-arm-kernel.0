From: axel.lin@gmail.com (Axel Lin)
Date: Mon, 03 Sep 2012 20:29:28 +0800
Subject: [PATCH] ARM: ep93xx: Fix build error due to 'SZ_32M' undeclared
Message-ID: <1346675368.15950.0.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include linux/sizes.h to fix below build errors:

  CC      arch/arm/mach-ep93xx/adssphere.o
arch/arm/mach-ep93xx/adssphere.c: In function 'adssphere_init_machine':
arch/arm/mach-ep93xx/adssphere.c:32:49: error: 'SZ_32M' undeclared (first use in this function)
arch/arm/mach-ep93xx/adssphere.c:32:49: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/arm/mach-ep93xx/adssphere.o] Error 1
make: *** [arch/arm/mach-ep93xx] Error 2

  CC      arch/arm/mach-ep93xx/gesbc9312.o
arch/arm/mach-ep93xx/gesbc9312.c: In function 'gesbc9312_init_machine':
arch/arm/mach-ep93xx/gesbc9312.c:32:49: error: 'SZ_8M' undeclared (first use in this function)
arch/arm/mach-ep93xx/gesbc9312.c:32:49: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/arm/mach-ep93xx/gesbc9312.o] Error 1
make: *** [arch/arm/mach-ep93xx] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch is against linux-next tree.
Axel
 arch/arm/mach-ep93xx/adssphere.c |    1 +
 arch/arm/mach-ep93xx/gesbc9312.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
index a472777..41383bf 100644
--- a/arch/arm/mach-ep93xx/adssphere.c
+++ b/arch/arm/mach-ep93xx/adssphere.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
index 437c341..7fd705b 100644
--- a/arch/arm/mach-ep93xx/gesbc9312.c
+++ b/arch/arm/mach-ep93xx/gesbc9312.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 
 #include <mach/hardware.h>
 
-- 
1.7.9.5
