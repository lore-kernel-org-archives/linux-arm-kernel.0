From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri,  3 Sep 2010 23:12:11 +0200
Subject: [PATCH] ARM: Update RealView defconfig
Message-ID: <1283548331-21264-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches the condensed RealView defconfig activating some
stuff that has been missing from this config for some time and
some stuff that was merged in the 2.6.36 merge window:

- The new character LCD driver is enabled
- The Versatile I2C is enabled
- The PL022 SPI driver is enabled
- gpiolib is enabled (and makes MMC detection work properly)
- The new LEDs code is enabled with a heartbeat trigger
- The RTC class is enabled, and the PL031 RTC (onchip) and
  the offchip DS1307 on I2C is enabled

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/configs/realview_defconfig |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index fb75192..fcaa603 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -38,6 +38,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_ARM_INTEGRATOR=y
+CONFIG_ARM_CHARLCD=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
 CONFIG_NET_ETHERNET=y
@@ -51,10 +52,13 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_VERSATILE=y
+CONFIG_SPI=y
+CONFIG_GPIOLIB=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
@@ -69,7 +73,13 @@ CONFIG_SND_ARMAACI=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
-CONFIG_INOTIFY=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_PL031=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
@@ -79,6 +89,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
-- 
1.7.2.2
