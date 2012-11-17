From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 17 Nov 2012 17:57:23 +0400
Subject: [PATCH v3 17/18] ARM: clps711x: Update defconfig due latest changes
 and new kernel symbols
In-Reply-To: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
References: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
Message-ID: <1353160644-22446-18-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/clps711x_defconfig |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 86209d1..1cd94c3 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -1,10 +1,14 @@
-CONFIG_EXPERIMENTAL=y
+CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_RD_LZMA=y
 CONFIG_EMBEDDED=y
+CONFIG_SLOB=y
+CONFIG_JUMP_LABEL=y
+# CONFIG_LBDAF is not set
 CONFIG_PARTITION_ADVANCED=y
-# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_CLPS711X=y
 CONFIG_ARCH_AUTCPU12=y
 CONFIG_ARCH_CDB89712=y
@@ -12,8 +16,10 @@ CONFIG_ARCH_CLEP7312=y
 CONFIG_ARCH_EDB7211=y
 CONFIG_ARCH_P720T=y
 CONFIG_ARCH_FORTUNET=y
+CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+# CONFIG_COREDUMP is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -22,6 +28,7 @@ CONFIG_INET=y
 CONFIG_IRDA=y
 CONFIG_IRTTY_SIR=y
 CONFIG_EP7211_DONGLE=y
+# CONFIG_WIRELESS is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
@@ -31,24 +38,21 @@ CONFIG_MTD_JEDECPROBE=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_CDB89712=y
 CONFIG_MTD_AUTCPU12=y
 CONFIG_MTD_PLATRAM=y
-CONFIG_BLK_DEV_RAM=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_GPIO=y
 CONFIG_NETDEVICES=y
-# CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CHELSIO is not set
 CONFIG_CS89x0=y
+CONFIG_CS89x0_PLATFORM=y
 # CONFIG_NET_VENDOR_FARADAY is not set
-# CONFIG_NET_VENDOR_FUJITSU is not set
-# CONFIG_NET_VENDOR_HP is not set
 # CONFIG_NET_VENDOR_INTEL is not set
 # CONFIG_NET_VENDOR_MARVELL is not set
 # CONFIG_NET_VENDOR_MICREL is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_RACAL is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
 # CONFIG_NET_VENDOR_SMSC is not set
 # CONFIG_NET_VENDOR_STMICRO is not set
@@ -59,14 +63,22 @@ CONFIG_CS89x0=y
 # CONFIG_VT is not set
 CONFIG_SERIAL_CLPS711X_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FB_CLPS711X=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_PLATFORM=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
+CONFIG_CRAMFS=y
 CONFIG_MINIX_FS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 # CONFIG_FTRACE is not set
-- 
1.7.8.6
