From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 3 Oct 2018 16:41:29 +0200
Subject: [PATCH v2] ARM: multi_v7_defconfig: enable STM32 analog & timer
 drivers
Message-ID: <1538577689-22847-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables drivers for STM32 timer, low power timer and analog hardware
that can be used on STM32MP1 SoC:
- Timer & LP Timer MFD core, PWM, trigger & encoder drivers
- IIO ADC/DAC/DFSDM
- vrefbuf regu driver (voltage reference buffer).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fc33444..15700cb 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -518,6 +518,7 @@ CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
+CONFIG_MFD_STM32_LPTIMER=m
 CONFIG_REGULATOR_ACT8865=y
 CONFIG_REGULATOR_ACT8945A=y
 CONFIG_REGULATOR_ANATOP=y
@@ -548,6 +549,7 @@ CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_RN5T618=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
+CONFIG_REGULATOR_STM32_VREFBUF=m
 CONFIG_REGULATOR_TI_ABB=y
 CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
@@ -902,14 +904,20 @@ CONFIG_AT91_SAMA5D2_ADC=m
 CONFIG_BERLIN2_ADC=m
 CONFIG_CPCAP_ADC=m
 CONFIG_EXYNOS_ADC=m
+CONFIG_STM32_ADC_CORE=m
+CONFIG_STM32_ADC=m
+CONFIG_STM32_DFSDM_ADC=m
 CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
+CONFIG_STM32_LPTIMER_CNT=m
+CONFIG_STM32_DAC=m
 CONFIG_MPU3050_I2C=y
 CONFIG_CM36651=m
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
 CONFIG_AK8975=y
 CONFIG_IIO_HRTIMER_TRIGGER=y
+CONFIG_IIO_STM32_LPTIMER_TRIGGER=m
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_HLCDC_PWM=m
@@ -923,6 +931,8 @@ CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_ROCKCHIP=m
 CONFIG_PWM_SAMSUNG=m
 CONFIG_PWM_STI=y
+CONFIG_PWM_STM32=m
+CONFIG_PWM_STM32_LP=m
 CONFIG_PWM_SUN4I=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
-- 
1.9.1
