From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Aug 2013 08:55:52 -0300
Subject: [PATCH 1/2] ARM: imx: Remove CONFIG_USB_PHY selection from defconfig
Message-ID: <1376308553-2824-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 052a11d1 (usb: phy: make PHY driver selection possible by 
controller drivers), CONFIG_USB_PHY is selected via drivers/usb/phy/Kconfig, so
there is no need to select it via defconfig anymore.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 arch/arm/configs/mxs_defconfig       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 577f054..c2c024f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -194,7 +194,6 @@ CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_PHY=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_MMC=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 4555c02..a9fb093 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -116,7 +116,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_PHY=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_UNSAFE_RESUME=y
-- 
1.8.1.2
