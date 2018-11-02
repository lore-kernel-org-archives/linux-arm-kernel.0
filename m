From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri,  2 Nov 2018 14:53:03 -0700
Subject: [PATCH] arm64: defconfig: Enable core Qualcomm SDM845 options
Message-ID: <20181102215303.18405-1-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable a few core config options to be able to boot SDM845 MTP.

The GCC, PINCTRL and GENI options are required to be able to boot to a
console. Several clocks from GCC are parented by the "bi_tcxo" clock
from the RPMH clock driver, so enable this to save others the time to
debug the missing parent clocks later. RPMH depends on the COMMAND_DB.
While we're enabling the others let's do RPMH regulators as well, as
everything beyond this point depends on that.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3cb995606e60..4d9425a2e0d1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -303,6 +303,8 @@ CONFIG_SERIAL_TEGRA=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
+CONFIG_SERIAL_QCOM_GENI=y
+CONFIG_SERIAL_QCOM_GENI_CONSOLE=y
 CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
@@ -347,6 +349,7 @@ CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
+CONFIG_PINCTRL_SDM845=y
 CONFIG_PINCTRL_MT7622=y
 CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_MB86S7X=y
@@ -411,6 +414,7 @@ CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_PWM=y
+CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_REGULATOR_RK808=y
@@ -593,10 +597,12 @@ CONFIG_COMMON_CLK_PWM=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
+CONFIG_QCOM_CLK_RPMH=y
 CONFIG_IPQ_GCC_8074=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
+CONFIG_SDM_GCC_845=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
@@ -612,6 +618,9 @@ CONFIG_QCOM_IOMMU=y
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_GENI_SE=y
+CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
-- 
2.18.0
