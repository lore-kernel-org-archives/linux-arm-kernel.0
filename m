From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri,  3 Sep 2010 23:12:29 +0200
Subject: [PATCH] ARM: update U300 defconfig
Message-ID: <1283548349-21540-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This mainly removes a lot of unused subsystems (as for the mainline
drivers) in the U300 defconfig, switch of MMC debugging by default
and enables debugfs on the builds. Once we merge the drivers we'll
configure it on again.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/configs/u300_defconfig |   37 ++-----------------------------------
 1 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index 46e5e07..c1c252c 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -28,26 +28,9 @@ CONFIG_CPU_IDLE=y
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 # CONFIG_SUSPEND is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
-CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_ECC_SMC=y
+# CONFIG_MISC_DEVICES is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -58,7 +41,6 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
-CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_REGULATOR=y
@@ -66,24 +48,10 @@ CONFIG_FB=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_SOUND=y
-CONFIG_SND=y
-# CONFIG_SND_SUPPORT_OLD_API is not set
-# CONFIG_SND_VERBOSE_PROCFS is not set
-# CONFIG_SND_DRIVERS is not set
-# CONFIG_SND_ARM is not set
-# CONFIG_SND_SPI is not set
-CONFIG_SND_SOC=y
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-CONFIG_MMC_DEBUG=y
 CONFIG_MMC_ARMMMCI=y
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_RTC_DRV_COH901331=y
@@ -93,12 +61,11 @@ CONFIG_COH901318=y
 CONFIG_FUSE_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-# CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
-# CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_PREEMPT is not set
-- 
1.7.2.2
