From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 May 2012 15:44:48 -0600
Subject: [PATCH 1/3] ARM: tegra: make .dts compilation depend on Tegra2 support
Message-ID: <1337636690-28211-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Update Makefile.boot to compile *.dts when the appropriate Tegra SoC
support is enabled, rather than requiring Kconfig to list each board
individually. Remove CONFIG_MACH_VENTANA now that it has no use.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This series is for 3.6.

 arch/arm/mach-tegra/Kconfig       |    7 -------
 arch/arm/mach-tegra/Makefile.boot |   10 +++++-----
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 7c40739..5b9b116 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -108,13 +108,6 @@ config MACH_WARIO
        help
          Support for the Wario version of Seaboard
 
-config MACH_VENTANA
-       bool "Ventana board"
-       depends on ARCH_TEGRA_2x_SOC
-       select MACH_TEGRA_DT
-       help
-         Support for the nVidia Ventana development platform
-
 choice
         prompt "Default low-level debug console UART"
         default TEGRA_DEBUG_UART_NONE
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
index 2d1993e..db7ad53 100644
--- a/arch/arm/mach-tegra/Makefile.boot
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -2,10 +2,10 @@ zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	+= 0x00008000
 params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
 initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
 
-dtb-$(CONFIG_MACH_HARMONY) += tegra-harmony.dtb
-dtb-$(CONFIG_MACH_PAZ00) += tegra-paz00.dtb
-dtb-$(CONFIG_MACH_SEABOARD) += tegra-seaboard.dtb
-dtb-$(CONFIG_MACH_TRIMSLICE) += tegra-trimslice.dtb
-dtb-$(CONFIG_MACH_VENTANA) += tegra-ventana.dtb
+dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra-harmony.dtb
+dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra-paz00.dtb
+dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra-seaboard.dtb
+dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra-trimslice.dtb
+dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra-ventana.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra-whistler.dtb
 dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra-cardhu.dtb
-- 
1.7.0.4
