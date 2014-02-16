From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 16 Feb 2014 20:05:24 +0100
Subject: [PATCH] arm: sti: Remove SOC_STIH415 and SOC_STIH416
Message-ID: <1392577524.28866.32.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbols SOC_STIH415 and SOC_STIH416 were added in v3.11.
They have never been used. They default to "y" but nothing cares. They
can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep".

 arch/arm/mach-sti/Kconfig | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index d71654b..c360ae1 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -21,26 +21,3 @@ menuconfig ARCH_STI
 	  for discovery
 	  More information at Documentation/arm/STiH41x and
 	  at Documentation/devicetree
-
-
-if ARCH_STI
-
-config SOC_STIH415
-	bool "STiH415 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH415 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattned Device
-	  Trees.
-
-config SOC_STIH416
-	bool "STiH416 STMicroelectronics Consumer Electronics family"
-	default y
-	help
-	  This enables support for STMicroelectronics Digital Consumer
-	  Electronics family StiH416 parts, primarily targeted at set-top-box
-	  and other digital audio/video applications using Flattened Device
-	  Trees.
-
-endif
-- 
1.8.5.3
