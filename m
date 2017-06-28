From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 28 Jun 2017 15:33:03 -0700
Subject: [PATCH] ARM: qcom_defconfig: Enable configs for USB on apq8064/msm8974
Message-ID: <20170628223303.21809-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the regulator driver, usb phy drivers, and hsic hub driver
to support USB devices on apq8064 and msm8974.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Patch generated against next-20170628.

 arch/arm/configs/qcom_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 36b58d41c52d..89aedc8094d2 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -135,6 +135,7 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
+CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_FB=y
 CONFIG_SOUND=y
@@ -155,11 +156,14 @@ CONFIG_USB_ACM=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=y
+CONFIG_USB_HSIC_USB4604=y
 CONFIG_USB_MSM_OTG=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_VBUS_DRAW=500
+CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
@@ -203,6 +207,7 @@ CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
 CONFIG_QCOM_WCNSS_CTRL=y
+CONFIG_EXTCON_QCOM_SPMI_MISC=y
 CONFIG_IIO=y
 CONFIG_IIO_BUFFER_CB=y
 CONFIG_IIO_SW_TRIGGER=y
@@ -213,6 +218,8 @@ CONFIG_IIO_HRTIMER_TRIGGER=y
 CONFIG_BMP280=y
 CONFIG_PHY_QCOM_APQ8064_SATA=y
 CONFIG_PHY_QCOM_IPQ806X_SATA=y
+CONFIG_PHY_QCOM_USB_HS=y
+CONFIG_PHY_QCOM_USB_HSIC=y
 CONFIG_NVMEM=y
 CONFIG_QCOM_QFPROM=y
 CONFIG_EXT2_FS=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
