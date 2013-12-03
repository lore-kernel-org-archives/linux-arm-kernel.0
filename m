From: olof@lixom.net (Olof Johansson)
Date: Tue,  3 Dec 2013 10:21:49 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: enable SDHCI_BCM_KONA and
 MMC_BLOCK_MINORS=16
Message-ID: <1386094909-4211-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable MMC/SD on the Broadcom mobile platforms, and increase the block
minors from the default 8 to 16 (since the Broadcom board by default
has root on the 8th partition).

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4a5903e..7d3ab95 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -133,12 +133,14 @@ CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_MMC=y
+CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_SPEAR=y
+CONFIG_MMC_SDHCI_BCM_KONA=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_EDAC=y
-- 
1.7.10.4
