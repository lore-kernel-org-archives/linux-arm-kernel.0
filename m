From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 29 Feb 2016 18:32:52 +0530
Subject: [PATCH 1/1] arm64: defconfig: Enable Maxim PMIC max77620 config
Message-ID: <1456750972-13972-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable following configs for the Maxim Semiconductor's PMIC
MAX77620/MAX20024. This is used on NVIDIA's Tegra 210 platform
Jetson-TX1.

 CONFIG_MFD_MAX77620 For MFD driver.
 CONFIG_PINCTRL_MAX77620 For pin control support
 CONFIG_GPIO_MAX77620 for GPIO Support.
 CONFIG_REGULATOR_MAX77620 for regulator support.
 CONFIG_RTC_DRV_MAX77686 for RTC support.

Enable Tegra I2C config to enable I2C in NVIDIA's Tegra 210
platforms.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
The patches for drivers of MFD/GPIO/Pincontrol are in flight.

 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a98a8ad..af3d4df 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -147,27 +147,32 @@ CONFIG_VIRTIO_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_QUP=y
+CONFIG_I2C_TEGRA=y
 CONFIG_I2C_UNIPHIER_F=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_QUP=y
 CONFIG_SPMI=y
+CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
+CONFIG_GPIO_MAX77620=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
+CONFIG_MFD_MAX77620=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_QCOM_SPMI=y
 CONFIG_FB=y
@@ -216,6 +221,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_SUN6I=y
-- 
2.1.4
