From: horms@verge.net.au (Simon Horman)
Date: Thu,  1 Nov 2012 09:02:11 +0800
Subject: [PATCH 3/3] ARM: shmobile: leave CONFIG_INOTIFY_USER enabled by
 default
In-Reply-To: <1351731731-8435-1-git-send-email-horms@verge.net.au>
References: <1351731731-8435-1-git-send-email-horms@verge.net.au>
Message-ID: <1351731731-8435-4-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

CONFIG_INOTIFY_USER is enabled by default in its Kconfig. Disabling it
breaks udevd. Fix shmobile defconfig files to not specify this option
explicitly.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/ap4evb_defconfig   |    1 -
 arch/arm/configs/kota2_defconfig    |    1 -
 arch/arm/configs/kzm9g_defconfig    |    1 -
 arch/arm/configs/mackerel_defconfig |    1 -
 4 files changed, 4 deletions(-)

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
index c88b578..b377a6f 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -120,7 +120,6 @@ CONFIG_SH_DMAE=y
 CONFIG_ASYNC_TX_DMA=y
 CONFIG_STAGING=y
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
-- 
1.7.10.4
