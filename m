From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Mon,  5 Aug 2013 14:37:04 +0530
Subject: [PATCH] mach-ks8695/Kconfig: Make MACH_KS8695 depends on PCI
Message-ID: <1375693624-21548-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: root <root@si-cspbld63.lge.net>

This patch adds a Kconfig dependency on MACH_KS8695,MACH_CM* or MACH_IM*
being available before PCI can be enabled. Without this patch,build system
can lead to issues. This was discovered during randconfig testing,
without PCI if any one of MACH_KS8695,MACH_CM* or MACH_IM* being enabled,
leading to the following error:

LD      init/built-in.o
arch/arm/mach-ks8695/built-in.o: In function `og_register_pci':
arch/arm/mach-ks8695/board-og.c:47:undefined reference to `ks8695_init_pci'
make: *** [vmlinux] Error 1

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Deepak Saxena <dsaxena@linaro.org>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-ks8695/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-ks8695/Kconfig b/arch/arm/mach-ks8695/Kconfig
index a545976..29d7d9f 100644
--- a/arch/arm/mach-ks8695/Kconfig
+++ b/arch/arm/mach-ks8695/Kconfig
@@ -5,6 +5,7 @@ menu "Kendin/Micrel KS8695 Implementations"
 config MACH_KS8695
 	bool "KS8695 development board"
 	select MIGHT_HAVE_PCI
+	depends on PCI
 	help
 	  Say 'Y' here if you want your kernel to run on the original
 	  Kendin-Micrel KS8695 development board.
@@ -53,6 +54,7 @@ config MACH_CM4002
 config MACH_CM4008
 	bool "OpenGear CM4008"
 	select MIGHT_HAVE_PCI
+	depends on PCI
 	help
 	  Say 'Y' here if you want your kernel to support the OpenGear
 	  CM4008 Console Server. See http://www.opengear.com for more
@@ -61,6 +63,7 @@ config MACH_CM4008
 config MACH_CM41xx
 	bool "OpenGear CM41xx"
 	select MIGHT_HAVE_PCI
+	depends on PCI
 	help
 	  Say 'Y' here if you want your kernel to support the OpenGear
 	  CM4016 or CM4048 Console Servers. See http://www.opengear.com for
@@ -69,6 +72,7 @@ config MACH_CM41xx
 config MACH_IM4004
 	bool "OpenGear IM4004"
 	select MIGHT_HAVE_PCI
+	depends on PCI
 	help
 	  Say 'Y' here if you want your kernel to support the OpenGear
 	  IM4004 Secure Access Server. See http://www.opengear.com for
@@ -77,6 +81,7 @@ config MACH_IM4004
 config MACH_IM42xx
 	bool "OpenGear IM42xx"
 	select MIGHT_HAVE_PCI
+	depends on PCI
 	help
 	  Say 'Y' here if you want your kernel to support the OpenGear
 	  IM4216 or IM4248 Console Servers. See http://www.opengear.com for
-- 
1.8.1.2
