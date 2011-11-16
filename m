From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 16 Nov 2011 20:45:33 +0100
Subject: [PATCH] ARM: u300: update defconfig
Message-ID: <1321472733-26031-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This updates the U300 defconfig to support some new drivers like
FSMC, sets it to use the MMC clock gating scheme, and removes
some stale config options.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u300_defconfig |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index 4a5a126..374000e 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -14,8 +14,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_U300=y
 CONFIG_MACH_U300=y
 CONFIG_MACH_U300_BS335=y
-CONFIG_MACH_U300_DUAL_RAM=y
-CONFIG_U300_DEBUG=y
 CONFIG_MACH_U300_SPIDUMMY=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -26,19 +24,21 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/ram0 rw rootfstype=rootfs console=ttyAMA0,115200n8 lpj=515072"
 CONFIG_CPU_IDLE=y
 CONFIG_FPE_NWFPE=y
-CONFIG_PM=y
 # CONFIG_SUSPEND is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
-# CONFIG_MISC_DEVICES is not set
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_FSMC=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 # CONFIG_HWMON is not set
@@ -51,6 +51,7 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
+CONFIG_MMC_CLKGATE=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
@@ -65,10 +66,8 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_PREEMPT is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_CRC32 is not set
-- 
1.7.3.2
