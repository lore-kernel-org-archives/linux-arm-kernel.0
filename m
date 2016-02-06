From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Sat,  6 Feb 2016 07:07:33 +0000
Subject: [PATCH] arm64: defconfig: add spmi and usb related configs
Message-ID: <1454742453-24157-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds kconfigs for spmi bus support, pinctrl drivers and usb
related to get USB working on Qualcomm DB410C board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/configs/defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8c6f05f..ad26a53 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -144,7 +144,9 @@ CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_QUP=y
+CONFIG_SPMI=y
 CONFIG_PINCTRL_MSM8916=y
+CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
@@ -152,9 +154,11 @@ CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
+CONFIG_MFD_SPMI_PMIC=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
+CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -167,13 +171,21 @@ CONFIG_SND_SOC=y
 CONFIG_SND_SOC_RCAR=y
 CONFIG_SND_SOC_AK4613=y
 CONFIG_USB=y
+CONFIG_USB_OTG=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_UDC=y
+CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
+CONFIG_USB_HSIC_USB3503=y
+CONFIG_USB_MSM_OTG=y
 CONFIG_USB_ULPI=y
+CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
@@ -216,6 +228,7 @@ CONFIG_QCOM_SMD_RPM=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_HISILICON_IRQ_MBIGEN=y
+CONFIG_EXTCON_USB_GPIO=y
 CONFIG_PHY_XGENE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.9.1
