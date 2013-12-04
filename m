From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  3 Dec 2013 21:32:56 -0700
Subject: [PATCH 2/2] ARM: bcm2835: enable USB in defconfig
In-Reply-To: <1386131576-21137-1-git-send-email-swarren@wwwdotorg.org>
References: <1386131576-21137-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1386131576-21137-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the DWC2 USB controller present in the BCM2835 SoC. Also enable
support for various USB devices and classes, which make the controller
useful.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/configs/bcm2835_defconfig |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index c773ade..f43392d 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -44,17 +44,26 @@ CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
 CONFIG_NET=y
+CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_NETWORK_SECMARK=y
-# CONFIG_WIRELESS is not set
+CONFIG_NETFILTER=y
+CONFIG_CFG80211=y
+CONFIG_MAC80211=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_NETDEVICES=y
+CONFIG_USB_USBNET=y
+CONFIG_USB_NET_SMSC95XX=y
+CONFIG_ZD1211RW=y
+CONFIG_INPUT_EVDEV=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_AMBA_PL011=y
@@ -71,7 +80,8 @@ CONFIG_FB=y
 CONFIG_FB_SIMPLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB=y
+CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
@@ -85,6 +95,8 @@ CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_LEDS_TRIGGER_TRANSIENT=y
 CONFIG_LEDS_TRIGGER_CAMERA=y
+CONFIG_STAGING=y
+CONFIG_USB_DWC2=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
1.7.10.4
