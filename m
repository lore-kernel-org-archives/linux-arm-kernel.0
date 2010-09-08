From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 8 Sep 2010 15:42:22 +0200
Subject: [PATCH] ARM: Update RealView SMP defconfig
Message-ID: <1283953342-23811-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches the condensed RealView SMP defconfig activating the
same features mentioned in the vanilla RealView defconfig patch
submitted earlier.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/configs/realview-smp_defconfig |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/realview-smp_defconfig b/arch/arm/configs/realview-smp_defconfig
index 9312ef9..5ca7a61 100644
--- a/arch/arm/configs/realview-smp_defconfig
+++ b/arch/arm/configs/realview-smp_defconfig
@@ -39,6 +39,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_ARM_INTEGRATOR=y
+CONFIG_ARM_CHARLCD=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC_PHY=y
 CONFIG_NET_ETHERNET=y
@@ -52,10 +53,13 @@ CONFIG_SERIAL_AMBA_PL011=y
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
@@ -70,7 +74,13 @@ CONFIG_SND_ARMAACI=y
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
@@ -80,6 +90,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
-- 
1.7.2.2
