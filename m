From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 11 Feb 2014 22:21:16 +0100
Subject: [PATCH] ARM: spear: Remove references to PLAT_SPEAR_SINGLE
Message-ID: <1392153676.14317.8.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol PLAT_SPEAR_SINGLE briefly appeared during the v3.10
development cycle. It was removed in a merge commit before v3.10. A few
references to it were left in the tree, probably because they didn't
generate merge conflicts. Whatever it was, they're useless now and can
safely be removed.

Reported-by: Martin Walch <walch.martin@web.de>
Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/arm/mach-spear/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index ac1710e6..1595776 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -4,7 +4,6 @@
 
 menuconfig PLAT_SPEAR
 	bool "ST SPEAr Family" if ARCH_MULTI_V7 || ARCH_MULTI_V5
-	default PLAT_SPEAR_SINGLE
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select CLKSRC_MMIO
@@ -15,7 +14,7 @@ if PLAT_SPEAR
 
 config ARCH_SPEAR13XX
 	bool "ST SPEAr13xx"
-	depends on ARCH_MULTI_V7 || PLAT_SPEAR_SINGLE
+	depends on ARCH_MULTI_V7
 	select ARCH_HAS_CPUFREQ
 	select ARM_GIC
 	select CPU_V7
@@ -47,7 +46,7 @@ endif #ARCH_SPEAR13XX
 
 config ARCH_SPEAR3XX
 	bool "ST SPEAr3xx"
-	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
+	depends on ARCH_MULTI_V5
 	depends on !ARCH_SPEAR13XX
 	select ARM_VIC
 	select CPU_ARM926T
@@ -80,7 +79,7 @@ endif
 
 config ARCH_SPEAR6XX
 	bool "ST SPEAr6XX"
-	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
+	depends on ARCH_MULTI_V5
 	depends on !ARCH_SPEAR13XX
 	select ARM_VIC
 	select CPU_ARM926T
@@ -95,7 +94,6 @@ config MACH_SPEAR600
 	  Supports ST SPEAr600 boards configured via the device-treesource "arch/arm/mach-spear6xx/Kconfig"
 
 config ARCH_SPEAR_AUTO
-	def_bool PLAT_SPEAR_SINGLE
 	depends on !ARCH_SPEAR13XX && !ARCH_SPEAR6XX
 	select ARCH_SPEAR3XX
 
-- 
1.8.5.3
