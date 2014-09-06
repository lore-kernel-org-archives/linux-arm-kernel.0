From: broonie@kernel.org (Mark Brown)
Date: Sat,  6 Sep 2014 11:14:16 +0100
Subject: [PATCH] ARM: omap: Remove stray ARCH_HAS_OPP references
Message-ID: <1409998456-28066-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OPP is now a normal kernel library selected by its users rather than a
feature that architectures need to enable so ARCH_HAS_OPP serves no
function any more - remove the selects.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/mach-omap2/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e7189dcc9309..11ccf0b4e5c2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -25,7 +25,6 @@ config ARCH_OMAP4
 	bool "TI OMAP4"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
-	select ARCH_HAS_OPP
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARM_CPU_SUSPEND if PM
 	select ARM_ERRATA_720789
@@ -44,7 +43,6 @@ config SOC_OMAP5
 	bool "TI OMAP5"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
-	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select HAVE_ARM_SCU if SMP
@@ -56,14 +54,12 @@ config SOC_AM33XX
 	bool "TI AM33XX"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
-	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
 
 config SOC_AM43XX
 	bool "TI AM43x"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
-	select ARCH_HAS_OPP
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
 	select MIGHT_HAVE_CACHE_L2X0
@@ -72,7 +68,6 @@ config SOC_DRA7XX
 	bool "TI DRA7XX"
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
-	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
-- 
2.1.0
