From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Dec 2016 13:05:28 +0100
Subject: [PATCH 1/3] ARM: defconfig: replace MPU3050 driver on multi_v7
In-Reply-To: <20161227120530.31190-1-linus.walleij@linaro.org>
References: <20161227120530.31190-1-linus.walleij@linaro.org>
Message-ID: <20161227120530.31190-2-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The multi_v7 config enable the MPU3050 gyro input driver, but
there is now a dedicated IIO gyro driver for the same component,
which is the right subsystem to handle this. Replace it in the
defconfig. As we want the full IIO featureset and as other v7
systems will likely enjoy using IIO for their sensor work (such
as the Android-to-IIO userspace HAL), we take this opportunity to
turn on the standard sensor HRtimer triggering.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b01a43851294..a4607224289e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -296,7 +296,6 @@ CONFIG_TOUCHSCREEN_WM97XX=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MAX77693_HAPTIC=m
 CONFIG_INPUT_MAX8997_HAPTIC=m
-CONFIG_INPUT_MPU3050=y
 CONFIG_INPUT_AXP20X_PEK=m
 CONFIG_INPUT_ADXL34X=m
 CONFIG_SERIO_AMBAKMI=y
@@ -847,15 +846,18 @@ CONFIG_MEMORY=y
 CONFIG_EXTCON=y
 CONFIG_TI_AEMIF=y
 CONFIG_IIO=y
+CONFIG_IIO_SW_TRIGGER=y
 CONFIG_AT91_ADC=m
 CONFIG_AT91_SAMA5D2_ADC=m
 CONFIG_BERLIN2_ADC=m
 CONFIG_EXYNOS_ADC=m
 CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
+CONFIG_MPU3050_I2C=y
 CONFIG_CM36651=m
 CONFIG_AK8975=y
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_IIO_HRTIMER_TRIGGER=y
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=m
 CONFIG_PWM_ATMEL_HLCDC_PWM=m
-- 
2.9.3
