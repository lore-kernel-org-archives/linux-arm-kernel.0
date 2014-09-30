From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Sep 2014 10:00:39 +0800
Subject: [PATCH 6/6] ARM: imx_v6_v7_defconfig: enable several usb gadgets
In-Reply-To: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
References: <1412042439-13977-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1412042439-13977-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Below drivers will be built as modules
- Configfs
- NCM
- Zero (used for test)
- Gadgetfs
- Serial

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index c164844..72ac582 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -236,8 +236,24 @@ CONFIG_USB_EHSET_TEST_FIXTURE=m
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_USB_GADGET=y
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
+CONFIG_USB_ZERO=m
 CONFIG_USB_ETH=m
+CONFIG_USB_G_NCM=m
+CONFIG_USB_GADGETFS=m
 CONFIG_USB_MASS_STORAGE=m
+CONFIG_USB_G_SERIAL=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-- 
1.7.9.5
