From: robh@kernel.org (Rob Herring)
Date: Wed, 17 May 2017 16:52:30 -0500
Subject: [PATCH 2/2] arm64: defconfig: enable options needed for QCom DB410c
 board
In-Reply-To: <20170517215230.15108-1-robh@kernel.org>
References: <20170517215230.15108-1-robh@kernel.org>
Message-ID: <20170517215230.15108-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Qualcomm drivers needed to boot Dragonboard 410c with HDMI. This
enables support for clocks, regulators, and USB PHY.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d916fc316698..5b94e3d24c16 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -303,6 +303,7 @@ CONFIG_MFD_CROS_EC_I2C=y
 CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI655X_PMIC=y
 CONFIG_MFD_MAX77620=y
+CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
@@ -311,6 +312,8 @@ CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_PWM=y
+CONFIG_REGULATOR_QCOM_RPM=y
+CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_S2MPS11=y
@@ -381,6 +384,7 @@ CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_USB_MSM_OTG=y
+CONFIG_USB_QCOM_8X16_PHY=y
 CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
@@ -447,6 +451,8 @@ CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_QCOM_CLK_RPM=y
+CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
@@ -457,8 +463,12 @@ CONFIG_BCM2835_MBOX=y
 CONFIG_HI6220_MBOX=y
 CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
+CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_QCOM_SMEM=y
+CONFIG_QCOM_SMD_RPM=y
+CONFIG_QCOM_SMP2P=y
+CONFIG_QCOM_SMSM=y
 CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
-- 
2.11.0
