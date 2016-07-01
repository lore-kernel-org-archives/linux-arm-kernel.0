From: cov@codeaurora.org (Christopher Covington)
Date: Fri,  1 Jul 2016 10:27:17 -0400
Subject: [PATCH v2] arm64: defconfig: Enable QDF2432 config options
In-Reply-To: <1467382327-9726-1-git-send-email-cov@codeaurora.org>
References: <1467382327-9726-1-git-send-email-cov@codeaurora.org>
Message-ID: <1467383237-11005-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ACPI is on in the defconfig, the time seems right to enable
drivers for the SD/MMC, DMA, and pin control hardware described in the ACPI
tables of the QDF2432 server platform.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
v2: Remove unrelated script changes.
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d..c138425 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -186,6 +186,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MSM8916=y
+CONFIG_PINCTRL_QDF2XXX=m
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DWAPB=y
@@ -245,6 +246,7 @@ CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ACPI=m
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_TEGRA=y
@@ -272,6 +274,8 @@ CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_QCOM_BAM_DMA=y
+CONFIG_QCOM_HIDMA_MGMT=m
+CONFIG_QCOM_HIDMA=m
 CONFIG_RCAR_DMAC=y
 CONFIG_VFIO=y
 CONFIG_VFIO_PCI=y
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
