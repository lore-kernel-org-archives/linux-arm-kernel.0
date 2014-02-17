From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 17 Feb 2014 14:04:17 -0300
Subject: [PATCH] ARM: mach-imx: Select CONFIG_SRAM at ARCH_MXC level
Message-ID: <1392656657-25594-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting a mx6q system built with multi_v7_defconfig leads to the following
error messages on boot:

[    0.037758] imx6q_ocram_suspend_init: ocram pool unavailable!
[    0.037768] imx6_pm_common_init: failed to initialize ocram suspend -19!

This happens because CONFIG_SRAM is not selected by default in 
multi_v7_defconfig.

Fix this by selecting CONFIG_SRAM at ARCH_MXC level, so that other SoCs could
use the SRAM driver as well.

As SRAM automatically selects GENERIC_ALLOCATOR, just drop it from the Kconfig
entry.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 19196af..04aa1de 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -7,7 +7,6 @@ config ARCH_MXC
 	select ARM_PATCH_PHYS_VIRT
 	select CLKSRC_MMIO
 	select COMMON_CLK
-	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
@@ -16,6 +15,7 @@ config ARCH_MXC
 	select PM_OPP if PM
 	select SOC_BUS
 	select SPARSE_IRQ
+	select SRAM
 	select USE_OF
 	help
 	  Support for Freescale MXC/iMX-based family of processors
-- 
1.8.1.2
