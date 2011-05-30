From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Tue, 31 May 2011 00:44:31 +0200
Subject: [PATCH 3.0-rc1 v2] OMAP: fix compilation error
In-Reply-To: <20110530222107.GA21753@n2100.arm.linux.org.uk>
References: <201105302344.01530.jkrzyszt@tis.icnet.pl>
	<20110530222107.GA21753@n2100.arm.linux.org.uk>
Message-ID: <201105310044.31746.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forward-declare platform_device structure in
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
v1 -> v2 change requested by Russell King (thanks!):
- no need to add to the complexities of header file inclusion

 arch/arm/plat-omap/include/plat/flash.h |    1 +
 1 file changed, 1 insertion(+)

--- git/arch/arm/plat-omap/include/plat/flash.h.orig	2011-05-31 00:29:36.000000000 +0200
+++ git/arch/arm/plat-omap/include/plat/flash.h	2011-05-31 00:30:50.000000000 +0200
@@ -11,6 +11,7 @@
 
 #include <linux/mtd/map.h>
 
+struct platform_device;
 extern void omap1_set_vpp(struct platform_device *pdev, int enable);
 
 #endif
