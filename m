From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Jun 2013 01:04:31 +0200
Subject: [PATCH] ARM: keystone: select ARM_ERRATA_798181 only for SMP
Message-ID: <201306220104.31656.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Selecting this symbol causes a build warning without SMP:

warning: (ARCH_KEYSTONE) selects ARM_ERRATA_798181 which has unmet direct dependencies (CPU_V7 && SMP)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 2dbd4ce..51a50e9 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -9,7 +9,7 @@ config ARCH_KEYSTONE
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SCHED_CLOCK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_ERRATA_798181
+	select ARM_ERRATA_798181 if SMP
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
