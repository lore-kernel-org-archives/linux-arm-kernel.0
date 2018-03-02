From: tony@atomide.com (Tony Lindgren)
Date: Fri,  2 Mar 2018 09:32:19 -0800
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: Enable USB gadget configfs as
 loadable module
In-Reply-To: <20180302173219.46112-1-tony@atomide.com>
References: <20180302173219.46112-1-tony@atomide.com>
Message-ID: <20180302173219.46112-4-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With USB OTG now enabled, it makes sense to allow configuring the
USB gadgets via configfs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/multi_v7_defconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -732,6 +732,25 @@ CONFIG_USB_MXS_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_FSL_USB2=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
+CONFIG_USB_CONFIGFS=m
+CONFIG_USB_CONFIGFS_SERIAL=y
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_OBEX=y
+CONFIG_USB_CONFIGFS_NCM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_CONFIGFS_ECM_SUBSET=y
+CONFIG_USB_CONFIGFS_RNDIS=y
+CONFIG_USB_CONFIGFS_EEM=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_LB_SS=y
+CONFIG_USB_CONFIGFS_F_FS=y
+CONFIG_USB_CONFIGFS_F_UAC1=y
+CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
+CONFIG_USB_CONFIGFS_F_UAC2=y
+CONFIG_USB_CONFIGFS_F_MIDI=y
+CONFIG_USB_CONFIGFS_F_HID=y
+CONFIG_USB_CONFIGFS_F_UVC=y
+CONFIG_USB_CONFIGFS_F_PRINTER=y
 CONFIG_USB_ETH=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=16
-- 
2.16.2
