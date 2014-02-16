From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 16 Feb 2014 18:34:40 +0100
Subject: [PATCH] arm: msm: remove MACH_MSM7X30_SURF
Message-ID: <1392572080.28866.19.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol MACH_MSM7X30_SURF was added in v2.6.35. It has never
been used. Setting it has no effect. There are no calls for
machine_is_mach_msm7x30(). This symbol can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested only with "git grep".

 arch/arm/mach-msm/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 9625cf3..dab941a 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -62,7 +62,6 @@ config ARCH_MSM7X30
 	select ARCH_MSM_SCORPION
 	select CPU_V7
 	select GPIO_MSM_V1
-	select MACH_MSM7X30_SURF # if !
 	select MSM_GPIOMUX
 	select MSM_PROC_COMM
 	select MSM_SMD
@@ -115,12 +114,6 @@ config MACH_TROUT
 	help
 	  Support for the HTC Dream, T-Mobile G1, Android ADP1 devices.
 
-config MACH_MSM7X30_SURF
-	depends on ARCH_MSM7X30
-	bool "MSM7x30 SURF"
-	help
-	  Support for the Qualcomm MSM7x30 SURF eval board.
-
 config MACH_QSD8X50_SURF
 	depends on ARCH_QSD8X50
 	bool "QSD8x50 SURF"
-- 
1.8.5.3
