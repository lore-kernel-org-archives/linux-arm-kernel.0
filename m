From: denis@eukrea.com (Denis Carikli)
Date: Wed, 12 Mar 2014 11:01:58 +0100
Subject: [PATCH v3][ 9/9] ARM: imx_v4_v5_defconfig: Enable drivers for
 i.MX25/i.MX35 USB support.
In-Reply-To: <1394618518-13803-1-git-send-email-denis@eukrea.com>
References: <1394618518-13803-1-git-send-email-denis@eukrea.com>
Message-ID: <1394618518-13803-9-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v2->v3:
- Extra gadget drivers additions were removed from this patch.

Changelog v1->v2:
- With the clock fix patches, the usb gadget also work.
  So I've addeed it to this patch too.
- CONFIG_USB_OTG_FSM=y was not needed, so it was removed.
---
 arch/arm/configs/imx_v4_v5_defconfig |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index f1aeb7d..ec9b365 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -80,6 +80,7 @@ CONFIG_MTD_UBI=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_ATA=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_PATA_IMX=y
 CONFIG_NETDEVICES=y
 CONFIG_CS89x0=y
@@ -153,6 +154,11 @@ CONFIG_USB_HID=m
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_UDC=y
+CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_NOP_USB_XCEIV=y
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_SDHCI=y
-- 
1.7.9.5
