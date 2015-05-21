From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 21 May 2015 12:07:33 +0900
Subject: [GIT PULL] Samsung related to updating multi_v7_defconfig
Message-ID: <555D4BF5.20008@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Here is multi_v7_defconfig update and mostly including regarding exynos
stuff based on savedefconfig which could remove useless configs based on
checking of dependencies.

This series is based on v4.1-rc1 and I can provide resolution of
conflicts with arm-soc/next/defconfig. See below.

Note that, IMHO we need to check 'savedefconfig when defconfig is
updated so that we could remove useless lines and avoid to miss some
defconfigs because of dependency.

Anyway please pull and if any concerns, please kindly let me know.

Thanks,
Kukjin
---
diff --git a/arch/arm/configs/multi_v7_defconfig
b/arch/arm/configs/multi_v7_defconfig
index d9da5b4..2ed424b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -19,10 +19,10 @@ CONFIG_MACH_ARMADA_38X=y
 CONFIG_MACH_ARMADA_39X=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_MACH_DOVE=y
+CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
-CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_CYGNUS=y
 CONFIG_ARCH_BCM_5301X=y
@@ -89,8 +89,6 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
-CONFIG_TEGRA_EMC_SCALING_ENABLE=y
-CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_U8500=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
@@ -115,10 +113,9 @@ CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
-CONFIG_NEON=y
-CONFIG_KERNEL_MODE_NEON=y
 CONFIG_ARM_ZYNQ_CPUIDLE=y
 CONFIG_ARM_EXYNOS_CPUIDLE=y
+CONFIG_KERNEL_MODE_NEON=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -136,9 +133,6 @@ CONFIG_IPV6_MIP6=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_CAN=y
-CONFIG_CAN_RAW=y
-CONFIG_CAN_BCM=y
-CONFIG_CAN_DEV=y
 CONFIG_CAN_AT91=m
 CONFIG_CAN_XILINXCAN=y
 CONFIG_CAN_MCP251X=y
@@ -357,7 +351,6 @@ CONFIG_WATCHDOG=y
 CONFIG_XILINX_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
-CONFIG_ST_LPC_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MESON_WATCHDOG=y
 CONFIG_MFD_AS3711=y
@@ -527,14 +520,13 @@ CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_MAX77802=m
 CONFIG_RTC_DRV_RS5C372=m
 CONFIG_RTC_DRV_PALMAS=y
-CONFIG_RTC_DRV_ST_LPC=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_TPS6586X=y
 CONFIG_RTC_DRV_TPS65910=y
 CONFIG_RTC_DRV_S35390A=m
 CONFIG_RTC_DRV_EM3027=y
-CONFIG_RTC_DRV_DIGICOLOR=m
 CONFIG_RTC_DRV_S5M=m
+CONFIG_RTC_DRV_DIGICOLOR=m
 CONFIG_RTC_DRV_S3C=m
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_AT91RM9200=m
@@ -600,8 +592,6 @@ CONFIG_KEYSTONE_IRQ=y
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_RCAR_GEN2=m
-CONFIG_PHY_STIH41X_USB=y
-CONFIG_PHY_STIH407_USB=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_PHY_HIX5HD2_SATA=y
@@ -631,20 +621,13 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOCKUP_DETECTOR=y
-CONFIG_CRYPTO_DEV_TEGRA_AES=y
-CONFIG_CPUFREQ_DT=y
-CONFIG_KEYSTONE_IRQ=y
+CONFIG_CRYPTO_DEV_ATMEL_AES=m
+CONFIG_CRYPTO_DEV_ATMEL_TDES=m
+CONFIG_CRYPTO_DEV_ATMEL_SHA=m
 CONFIG_ARM_CRYPTO=y
-CONFIG_CRYPTO_SHA1_ARM=m
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
 CONFIG_CRYPTO_SHA2_ARM_CE=m
-CONFIG_CRYPTO_SHA256_ARM=m
-CONFIG_CRYPTO_SHA512_ARM=m
-CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_AES_ARM_CE=m
 CONFIG_CRYPTO_GHASH_ARM_CE=m
-CONFIG_CRYPTO_DEV_ATMEL_AES=m
-CONFIG_CRYPTO_DEV_ATMEL_TDES=m
-CONFIG_CRYPTO_DEV_ATMEL_SHA=m
---

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig-1

for you to fetch changes up to 3587b8272b4a496e559935b585904647fcfb2a52:

  ARM: multi_v7_defconfig: Enable OHCI on exynos SoCs (2015-05-19
15:09:44 +0900)

----------------------------------------------------------------
Update multi_v7_defconfig

- From Javier Martinez Canillas:
  "Since the policy is now to now enable as much as possible, I did
  build as a module all the Kconfig symbols that were tristate and
  only enable as built-in those that can't be a module because are
  boolean options.
  A nice side effect of this series is that many drivers were not
  working properly when built as a module because the modalias
  information was not filled properly or at all. I've posted patches
  to fix the issues I found when testing this series.
  The patches have been tested on an Exynos5250 Snow, Exynos5420 Peach
  Pit and Exynos5800 Peach Pi Chromebooks but most config options will
  be useful for others Exynos5 or other Samsung SoCs."
  : Enable Cypress APA I2C Trackpad and GPIO-based I2C arbitration
  : Enable options for Exynos display support
  : Enable Samsung S3C SoC RTC and Samsung PWM support
  : Enable support for missing ChromeOS EC drivers and S3C64XX SPI
  : Enable Exynos USB PHY drivers support
  : Enable max77802 regulator, rtc and clock drivers

- From Krzysztof Kozlowski:
  : Enable CPU idle, TMU, USB OHCI for Exynos SoCs
  : Enable PMIC and MUIC drivers for Exynos boards

----------------------------------------------------------------
Javier Martinez Canillas (9):
      ARM: multi_v7_defconfig: Enable support for Samsung S3C64XX SPI
      ARM: multi_v7_defconfig: Enable max77802 regulator, rtc and clock
drivers
      ARM: multi_v7_defconfig: Enable Exynos USB PHY drivers support
      ARM: multi_v7_defconfig: Enable support for missing ChromeOS EC
drivers
      ARM: multi_v7_defconfig: Enable Samsung PWM support
      ARM: multi_v7_defconfig: Enable Samsung S3C SoC RTC
      ARM: multi_v7_defconfig: Enable options for Exynos display support
      ARM: multi_v7_defconfig: Enable GPIO-based I2C arbitration support
      ARM: multi_v7_defconfig: Enable Cypress APA I2C Trackpad support

Krzysztof Kozlowski (4):
      ARM: multi_v7_defconfig: Enable CPU idle for exynos SoCs
      ARM: multi_v7_defconfig: Enable PMIC and MUIC drivers for exynos
      ARM: multi_v7_defconfig: Enable TMU for exynos SoCs
      ARM: multi_v7_defconfig: Enable OHCI on exynos SoCs

Kukjin Kim (1):
      ARM: multi_v7_defconfig: make savedefconfig for removing useless
configs

 arch/arm/configs/multi_v7_defconfig | 108
++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 53 deletions(-)
