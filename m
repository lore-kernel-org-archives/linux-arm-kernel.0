From: olof@lixom.net (Olof Johansson)
Date: Sun,  3 Jun 2012 21:38:55 -0700
Subject: [PATCH] ARM: exynos: enable more platforms in defconfig
Message-ID: <1338784735-10683-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the new EXYNOS5 platforms in the defconfig, and enables DT
support on EXYNOS4.

While I'm at it, I renamed it exynos4_defconfig -> exynos_defconfig,
since it now encompasses all (known and supported) versions of exynos.

Other options enabled: USB host, EXT3/4, regulators and tps65090,
networking and a few of the common usb ethernet adapters as well as the
smsc911x controller used on some boards.

I enabled EFI_PARTITION, since it's used on some filesystem images I'm
using. I didn't see a need to keep Solaris and BSD partition format
still enabled.

Finally, framebuffer console, logo and fonts were enabled.

Note that enabling some of these options introduces build coverage
previously missing, thus introducing a few build errors and warnings
for which fixes have been sent out already.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/exynos4_defconfig | 68 --------------------------
 arch/arm/configs/exynos_defconfig  | 98 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 68 deletions(-)
 delete mode 100644 arch/arm/configs/exynos4_defconfig
 create mode 100644 arch/arm/configs/exynos_defconfig

diff --git a/arch/arm/configs/exynos4_defconfig b/arch/arm/configs/exynos4_defconfig
deleted file mode 100644
index bffe68e..0000000
--- a/arch/arm/configs/exynos4_defconfig
+++ /dev/null
@@ -1,68 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_EXYNOS=y
-CONFIG_S3C_LOWLEVEL_UART_PORT=1
-CONFIG_MACH_SMDKC210=y
-CONFIG_MACH_ARMLEX4210=y
-CONFIG_MACH_UNIVERSAL_C210=y
-CONFIG_MACH_NURI=y
-CONFIG_MACH_ORIGEN=y
-CONFIG_MACH_SMDK4412=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=2
-CONFIG_PREEMPT=y
-CONFIG_AEABI=y
-CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
-CONFIG_VFP=y
-CONFIG_NEON=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_SCSI=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_SG=y
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_SAMSUNG=y
-CONFIG_SERIAL_SAMSUNG_CONSOLE=y
-CONFIG_HW_RANDOM=y
-CONFIG_I2C=y
-# CONFIG_HWMON is not set
-# CONFIG_MFD_SUPPORT is not set
-# CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
-CONFIG_CRAMFS=y
-CONFIG_ROMFS_FS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_RT_MUTEXES=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_INFO=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_EARLY_PRINTK=y
-CONFIG_CRC_CCITT=y
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
new file mode 100644
index 0000000..5f75557
--- /dev/null
+++ b/arch/arm/configs/exynos_defconfig
@@ -0,0 +1,98 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_EFI_PARTITION=y
+CONFIG_ARCH_EXYNOS=y
+CONFIG_S3C_LOWLEVEL_UART_PORT=1
+CONFIG_S3C24XX_PWM=y
+CONFIG_ARCH_EXYNOS5=y
+CONFIG_MACH_SMDKC210=y
+CONFIG_MACH_ARMLEX4210=y
+CONFIG_MACH_UNIVERSAL_C210=y
+CONFIG_MACH_NURI=y
+CONFIG_MACH_ORIGEN=y
+CONFIG_MACH_SMDK4412=y
+CONFIG_MACH_EXYNOS4_DT=y
+CONFIG_MACH_EXYNOS5_DT=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_RFKILL_REGULATOR=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_NETDEVICES=y
+CONFIG_SMSC911X=y
+CONFIG_USB_USBNET=y
+CONFIG_USB_NET_SMSC75XX=y
+CONFIG_USB_NET_SMSC95XX=y
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_SAMSUNG=y
+CONFIG_SERIAL_SAMSUNG_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_HW_RANDOM=y
+CONFIG_I2C=y
+# CONFIG_HWMON is not set
+CONFIG_MFD_TPS65090=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_TPS65090=y
+CONFIG_FB=y
+CONFIG_FB_S3C=y
+CONFIG_EXYNOS_VIDEO=y
+CONFIG_EXYNOS_MIPI_DSI=y
+CONFIG_EXYNOS_DP=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FONTS=y
+CONFIG_FONT_7x14=y
+CONFIG_LOGO=y
+# CONFIG_HID_SUPPORT is not set
+CONFIG_USB=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CRAMFS=y
+CONFIG_ROMFS_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_USER=y
+CONFIG_DEBUG_LL=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_CRC_CCITT=y
-- 
1.7.10.1.488.g05fbf7a
