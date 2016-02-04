From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Thu,  4 Feb 2016 12:32:56 +0200
Subject: [PATCH] arm64: defconfig: Add Qualcomm sdhci and restart functionality
Message-ID: <1454581976-25364-1-git-send-email-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sdhci and restart functionality for devices based on msm8916 platform.
Also increase the number of minors per block device to detect all available
partitions.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/configs/defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bdd7aa358d2a..901d3a311ed4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -131,6 +131,7 @@ CONFIG_SPI_QUP=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_XGENE=y
+CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
@@ -152,9 +153,11 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_ULPI=y
 CONFIG_MMC=y
+CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_IDMAC=y
