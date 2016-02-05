From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat,  6 Feb 2016 02:38:40 +0900
Subject: [PATCH] ARM: integrator: remove redundant select in Kconfig
Message-ID: <1454693920-14794-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All of these are already select'ed by ARCH_MULTIPLATFORM.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-integrator/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index b01bdc9..b2a85ba 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -2,22 +2,16 @@ menuconfig ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6
 	select ARM_AMBA
-	select ARM_PATCH_PHYS_VIRT if MMU
-	select AUTO_ZRELADDR
-	select COMMON_CLK
 	select COMMON_CLK_VERSATILE
-	select GENERIC_CLOCKEVENTS
 	select HAVE_TCM
 	select ICST
 	select MFD_SYSCON
-	select MULTI_IRQ_HANDLER
 	select PLAT_VERSATILE
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
 	select POWER_SUPPLY
 	select SOC_INTEGRATOR_CM
 	select SPARSE_IRQ
-	select USE_OF
 	select VERSATILE_FPGA_IRQ
 	help
 	  Support for ARM's Integrator platform.
-- 
1.9.1
