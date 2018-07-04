From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Wed,  4 Jul 2018 16:40:55 +0200
Subject: [RESEND PATCH] ARM: multi_v7_defconfig: Enable missing drivers for
 supported Chromebooks.
Message-ID: <20180704144055.22005-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable following drivers for merged devices:
- Batteries with BQ27XXX chips for Minnie boards.
- Elan eKTH I2C touchscreen for Minnie boards.
- GPIO charger for all Veyron boards..
- Rockchip SARADC driver for all rk3288 boards.
- Rockchip eFUSE driver for all rk3288 boards.
- TPM security chip for all Veyron boards.
- ChromeOS EC userspace interface for all chromebooks boards.
- ChromeOS EC light and proximity sensors for some chromebooks.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Fixed some conflicts when I picked up the old patch [1]

[1] https://patchwork.kernel.org/patch/10300677/

 arch/arm/configs/multi_v7_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8f6be1982545..764b14ac271c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -280,6 +280,7 @@ CONFIG_MOUSE_CYAPA=m
 CONFIG_MOUSE_ELAN_I2C=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
+CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_MMS114=m
 CONFIG_TOUCHSCREEN_WM97XX=m
 CONFIG_TOUCHSCREEN_ST1232=m
@@ -340,6 +341,8 @@ CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_ST=y
+CONFIG_TCG_TPM=m
+CONFIG_TCG_TIS_I2C_INFINEON=m
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=m
 CONFIG_I2C_MUX_PCA954x=y
@@ -433,9 +436,11 @@ CONFIG_POWER_RESET_RMOBILE=y
 CONFIG_BATTERY_ACT8945A=y
 CONFIG_BATTERY_CPCAP=m
 CONFIG_BATTERY_SBS=y
+CONFIG_BATTERY_BQ27XXX=m
 CONFIG_AXP20X_POWER=m
 CONFIG_BATTERY_MAX17040=m
 CONFIG_BATTERY_MAX17042=m
+CONFIG_CHARGER_GPIO=m
 CONFIG_CHARGER_CPCAP=m
 CONFIG_CHARGER_MAX14577=m
 CONFIG_CHARGER_MAX77693=m
@@ -492,6 +497,7 @@ CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=m
 CONFIG_MFD_CROS_EC_I2C=m
 CONFIG_MFD_CROS_EC_SPI=m
+CONFIG_MFD_CROS_EC_CHARDEV=m
 CONFIG_MFD_DA9063=m
 CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX77686=y
@@ -892,10 +898,14 @@ CONFIG_AT91_SAMA5D2_ADC=m
 CONFIG_BERLIN2_ADC=m
 CONFIG_CPCAP_ADC=m
 CONFIG_EXYNOS_ADC=m
+CONFIG_ROCKCHIP_SARADC=m
 CONFIG_VF610_ADC=m
 CONFIG_XILINX_XADC=y
+CONFIG_IIO_CROS_EC_SENSORS_CORE=m
+CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_MPU3050_I2C=y
 CONFIG_CM36651=m
+CONFIG_IIO_CROS_EC_LIGHT_PROX=m
 CONFIG_SENSORS_ISL29018=y
 CONFIG_SENSORS_ISL29028=y
 CONFIG_AK8975=y
@@ -936,6 +946,7 @@ CONFIG_PHY_DM816X_USB=m
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_TWL4030_USB=m
+CONFIG_ROCKCHIP_EFUSE=m
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_VF610_OCOTP=y
-- 
2.18.0
