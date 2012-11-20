From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Nov 2012 13:34:58 -0200
Subject: [PATCH] ARM: Kconfig: Do not force selection of ARCH_VEXPRESS by
 ARCH_MULTI_V7
Message-ID: <1353425698-14415-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When building a kernel using imx_v6_v7_defconfig, it is not possible to unselect
ARCH_VEXPRESS due to the fact that it is automatically selected by ARCH_MULTI_V7.

This is not good when someone wants to create a minimal kernel build, so let 
multi_v7_defconfig select ARCH_VEXPRESS instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/Kconfig                    |    1 -
 arch/arm/configs/multi_v7_defconfig |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 14f8160..d40e9d3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1000,7 +1000,6 @@ config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
 	default y
 	select ARCH_MULTI_V6_V7
-	select ARCH_VEXPRESS
 	select CPU_V7
 
 config ARCH_MULTI_V6_V7
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 159f75f..531c538 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -6,6 +6,7 @@ CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_SOCFPGA=y
+CONFIG_ARCH_VEXPRESS=y
 # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_SMP=y
-- 
1.7.9.5
