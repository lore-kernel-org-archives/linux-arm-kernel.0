From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Mar 2013 14:48:07 -0600
Subject: [PATCH] ARM: tegra: enable Tegra114 in defconfig, rebuild defconfig
Message-ID: <1364330887-6039-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This enables CONFIG_ARCH_TEGRA_114_SOC, and rebuilds tegra_defconfig
based on v3.9-rc1. Hence, some other changes are includes, due to moved,
removed, or now-default options.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 34b9342..2b42a2c 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -1,4 +1,3 @@
-CONFIG_EXPERIMENTAL=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
@@ -20,15 +19,14 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
-CONFIG_EFI_PARTITION=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_TEGRA=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
+CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_TEGRA_PCI=y
-CONFIG_TEGRA_DEBUG_UART_AUTO_ODMDATA=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
@@ -37,8 +35,8 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_AUTO_ZRELADDR=y
 CONFIG_KEXEC=y
+CONFIG_AUTO_ZRELADDR=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
@@ -117,7 +115,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_TEGRA=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PINCTRL=y
@@ -193,9 +190,6 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_RTC_CLASS=y
-CONFIG_RTC_INTF_SYSFS=y
-CONFIG_RTC_INTF_PROC=y
-CONFIG_RTC_INTF_DEV=y
 CONFIG_RTC_DRV_MAX8907=y
 CONFIG_RTC_DRV_PALMAS=y
 CONFIG_RTC_DRV_TPS6586X=y
-- 
1.7.10.4
