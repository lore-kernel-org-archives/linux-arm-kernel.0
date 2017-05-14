From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 14 May 2017 23:45:02 +0200
Subject: [PATCH] ARM: configs: add a gemini defconfig
Message-ID: <20170514214502.26243-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It makes sense to have a stripped-down defconfig for just Gemini, as
it is a pretty small platform used in NAS etc, and will use appended
device tree. It is also quick to compile and test. Hopefully this
defconfig can be a good base for distributions such as OpenWRT.

I plan to add in the config options needed for the different
variants of Gemini as we go along.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this where apropriate for v4.12.
---
 arch/arm/configs/gemini_defconfig | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 arch/arm/configs/gemini_defconfig

diff --git a/arch/arm/configs/gemini_defconfig b/arch/arm/configs/gemini_defconfig
new file mode 100644
index 000000000000..d2d75fa664a6
--- /dev/null
+++ b/arch/arm/configs/gemini_defconfig
@@ -0,0 +1,68 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_USER_NS=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARCH_MULTI_V4=y
+# CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_ARCH_GEMINI=y
+CONFIG_PCI=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+CONFIG_CMDLINE="console=ttyS0,115200n8"
+CONFIG_KEXEC=y
+CONFIG_BINFMT_MISC=y
+CONFIG_PM=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=16384
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_GEMINI_WATCHDOG=y
+CONFIG_USB=y
+CONFIG_USB_MON=y
+CONFIG_USB_FOTG210_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GEMINI=y
+CONFIG_DMADEVICES=y
+# CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_ROMFS_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_FS=y
-- 
2.9.3
