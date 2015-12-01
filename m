From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 17:08:57 -0800
Subject: [PATCH] ARM: defconfig: qcom: Enable SSBI drivers
Message-ID: <1448932137-12717-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable some ssbi drivers present on msm8660, msm8960 and apq8064
devices so that we fully exercise the devices present in the dts
files.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 39e269088b34..195be8b9f172 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -80,10 +80,13 @@ CONFIG_USB_USBNET=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_PMIC8XXX=y
 # CONFIG_MOUSE_PS2 is not set
 CONFIG_INPUT_JOYSTICK=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_PM8XXX_VIBRATOR=y
+CONFIG_INPUT_PMIC8XXX_PWRKEY=y
 CONFIG_INPUT_UINPUT=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_LEGACY_PTYS is not set
@@ -110,6 +113,7 @@ CONFIG_CHARGER_QCOM_SMBB=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_THERMAL=y
+CONFIG_MFD_PM8921_CORE=y
 CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_REGULATOR=y
@@ -142,6 +146,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PM8XXX=y
 CONFIG_DMADEVICES=y
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_STAGING=y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
