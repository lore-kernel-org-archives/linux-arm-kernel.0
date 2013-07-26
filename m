From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 26 Jul 2013 00:17:35 -0300
Subject: [PATCH 1/2] ARM: mach-imx: Select ARM_CPU_SUSPEND at ARCH_MXC level
Message-ID: <1374808656-28609-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of selecting ARM_CPU_SUSPEND only for mx6, we can select it for 
all SoCs from the ARCH_MXC family.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index bb1cc9e..1cc219f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,5 +1,6 @@
 config ARCH_MXC
 	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
+	select ARM_CPU_SUSPEND if PM
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR if !ZBOOT_ROM
@@ -786,7 +787,6 @@ config SOC_IMX6Q
 	bool "i.MX6 Quad/DualLite support"
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
-	select ARM_CPU_SUSPEND if PM
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
-- 
1.8.1.2
