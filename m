From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 09 Feb 2014 16:01:28 +0100
Subject: [PATCH] ARM: OMAP2+: Remove MACH_NOKIA_N800
Message-ID: <1391958088.25424.17.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last caller of machine_is_nokia_n800() was removed in commit
5a87cde490e1 ("ARM: OMAP2+: Remove legacy booting support for n8x0").
That means that the Kconfig symbol MACH_NOKIA_N800 is now unused. It can
safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/arm/mach-omap2/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 653b489..66da3f5 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -268,9 +268,6 @@ config MACH_OMAP_3430SDP
 	default y
 	select OMAP_PACKAGE_CBB
 
-config MACH_NOKIA_N800
-       bool
-
 config MACH_NOKIA_N810
        bool
 
@@ -281,7 +278,6 @@ config MACH_NOKIA_N8X0
 	bool "Nokia N800/N810"
 	depends on SOC_OMAP2420
 	default y
-	select MACH_NOKIA_N800
 	select MACH_NOKIA_N810
 	select MACH_NOKIA_N810_WIMAX
 	select OMAP_PACKAGE_ZAC
-- 
1.8.5.3
