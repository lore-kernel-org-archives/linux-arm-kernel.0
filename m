From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Fri, 10 Oct 2014 16:51:24 +0300
Subject: [PATCH] ARM: multi_v7_defconfig: Enable SDHCI for Qualcomm platforms
Message-ID: <1412949084-9707-1-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable MMC support for Qualcomm msm8974, apq8074 and apq8084 platforms.
Also increase the number of minors per block device in order to detect
all the 25 eMMC partitions.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/configs/multi_v7_defconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9702b140ae04..5fcdb791fa74 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -334,7 +334,7 @@ CONFIG_USB_GPIO_VBUS=y
 CONFIG_USB_ISP1301=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_MMC=y
-CONFIG_MMC_BLOCK_MINORS=16
+CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
@@ -347,6 +347,7 @@ CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_MMC_SDHCI_S3C=y
 CONFIG_MMC_SDHCI_S3C_DMA=y
 CONFIG_MMC_SDHCI_BCM_KONA=y
+CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SDHCI_ST=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
-- 
1.7.9.5
