From: kostap@marvell.com (Konstantin Porotchkin)
Date: Sun,  3 Apr 2011 10:13:12 +0300
Subject: [PATCH] Moving Marvell Dove platform defaults to ARMv7
Message-ID: <1301814792-9438-1-git-send-email-kostap@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disabled legacy support for ARMv6 archtecture on Dove platform.
Latest Dove HW uses only ARMv7 model.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm/Kconfig                |    2 +-
 arch/arm/configs/dove_defconfig |   12 +-----------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 599e163..e9d9a4f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -463,7 +463,7 @@ config ARCH_IXP4XX
 
 config ARCH_DOVE
 	bool "Marvell Dove"
-	select CPU_V6K
+	select CPU_V7
 	select PCI
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 54bf5ee..40db34c 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -8,8 +8,6 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_DOVE=y
 CONFIG_MACH_DOVE_DB=y
-CONFIG_CPU_V6=y
-CONFIG_CPU_32v6K=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_AEABI=y
@@ -44,7 +42,6 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
-# CONFIG_MISC_DEVICES is not set
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
@@ -59,12 +56,12 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_MOUSE_PS2 is not set
 # CONFIG_SERIO is not set
+CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
-CONFIG_LEGACY_PTY_COUNT=16
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -72,12 +69,10 @@ CONFIG_I2C_MV64XXX=y
 CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
-CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_STORAGE=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MV=y
@@ -86,7 +81,6 @@ CONFIG_MV_XOR=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-CONFIG_INOTIFY=y
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_UDF_FS=m
@@ -110,23 +104,19 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_CRYPTO_NULL=y
-CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_AES=y
 CONFIG_CRYPTO_BLOWFISH=y
-CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_TEA=y
 CONFIG_CRYPTO_TWOFISH=y
 CONFIG_CRYPTO_DEFLATE=y
-- 
1.7.4.1
