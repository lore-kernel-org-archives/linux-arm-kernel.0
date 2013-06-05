From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 13:31:52 +0900
Subject: [PATCH 5/6] ARM: shmobile: bockw: enable USB in defconfig
In-Reply-To: <1370406713-26599-1-git-send-email-horms+renesas@verge.net.au>
References: <1370406713-26599-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370406713-26599-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Enable USB platform EHCI/OHCI and common PHY drivers in 'bockw_defconfig'.
Enable USB storage driver and SCSI disk driver that it needs as well...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index a4bc76d..d662608 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -49,6 +49,8 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
@@ -74,7 +76,14 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HWMON is not set
 CONFIG_I2C=y
 CONFIG_I2C_RCAR=y
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
 CONFIG_UIO=y
-- 
1.8.2.1
