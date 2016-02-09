From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Tue,  9 Feb 2016 12:19:45 +0200
Subject: [PATCH v2] arm64: defconfig: Add Qualcomm sdhci and restart
 functionality
Message-ID: <1455013185-946-1-git-send-email-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sdhci and restart functionality for devices based on msm8916 platform.
Also increase the number of minors per block device to detect all available
partitions.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

Changes since v1 (https://lkml.org/lkml/2016/2/4/259)
 * Rebased onto arm-soc/next/arm64

 arch/arm64/configs/defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 91ae2634cae9..ad26a53ddfe9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -150,6 +150,7 @@ CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
+CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
@@ -186,10 +187,12 @@ CONFIG_USB_MSM_OTG=y
 CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_MMC=y
+CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_TEGRA=y
+CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
