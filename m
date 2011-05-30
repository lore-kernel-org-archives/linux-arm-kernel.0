From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Mon, 30 May 2011 23:44:01 +0200
Subject: [PATCH 3.0-rc1] OMAP: fix compilation error
Message-ID: <201105302344.01530.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include <linux/platform_device.h> from 
arch/arm/plat-omap/include/plat/flash.h, otherwise compilation may break 
with:

In file included from arch/arm/mach-omap1/flash.c:15:
arch/arm/plat-omap/include/plat/flash.h:14: warning: 'struct platform_device' declared inside parameter list
arch/arm/plat-omap/include/plat/flash.h:14: warning: its scope is only this definition or declaration, which is probably not what you want
arch/arm/mach-omap1/flash.c:16: warning: 'struct platform_device' declared inside parameter list
arch/arm/mach-omap1/flash.c:17: error: conflicting types for 'omap1_set_vpp'
arch/arm/plat-omap/include/plat/flash.h:14: error: previous declaration of 'omap1_set_vpp' was here

Detected and corrected while building for Amstrad Delta, confirmed with 
omap1_defconfig.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/plat-omap/include/plat/flash.h |    1 +
 1 file changed, 1 insertion(+)

--- git/arch/arm/plat-omap/include/plat/flash.h.orig	2011-05-30 22:15:54.000000000 +0200
+++ git/arch/arm/plat-omap/include/plat/flash.h	2011-05-30 22:38:15.000000000 +0200
@@ -10,6 +10,7 @@
 #define __OMAP_FLASH_H
 
 #include <linux/mtd/map.h>
+#include <linux/platform_device.h>
 
 extern void omap1_set_vpp(struct platform_device *pdev, int enable);
 
