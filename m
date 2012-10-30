From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 31 Oct 2012 00:03:45 +0100 (CET)
Subject: [PATCH] ARM: shmobile: leave CONFIG_INOTIFY_USER enabled by default
Message-ID: <Pine.LNX.4.64.1210302358590.29432@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_INOTIFY_USER is enabled by default in its Kconfig. Disabling it 
breaks udevd. Fix shmobile defconfig files to not specify this option 
explicitly.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Thanks to Randy for the hint :-)

diff --git a/arch/arm/configs/ap4evb_defconfig b/arch/arm/configs/ap4evb_defconfig
index 2eef85e..66894f7 100644
--- a/arch/arm/configs/ap4evb_defconfig
+++ b/arch/arm/configs/ap4evb_defconfig
@@ -46,7 +46,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/kota2_defconfig b/arch/arm/configs/kota2_defconfig
index b7735d6..fa83db1 100644
--- a/arch/arm/configs/kota2_defconfig
+++ b/arch/arm/configs/kota2_defconfig
@@ -112,7 +112,6 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_RENESAS_TPU=y
 CONFIG_LEDS_TRIGGERS=y
 # CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index ce99e3e..afbae28 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -124,7 +124,6 @@ CONFIG_STAGING=y
 CONFIG_SENSORS_AK8975=y
 CONFIG_IIO=y
 # CONFIG_DNOTIFY is not set
-CONFIG_INOTIFY_USER=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 7b79a0b..2098ce1 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -105,7 +105,6 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 # CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
