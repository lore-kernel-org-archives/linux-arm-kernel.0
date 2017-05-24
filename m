From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 25 May 2017 01:06:50 +0200
Subject: [PATCH v2] arm64: defconfig: enable some core options for 64bit
 Rockchip socs
Message-ID: <20170524230650.17849-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable some very core config options used on 64bit Rockchip socs.

As built-in driver enable the Rockchip spi driver as well as the
cros-ec-spi and cros-ec keyboard driver, as this may be helpful
in case an initrd does not work as expected and drops the user
into a shell. Another built-in is the fan53555 regulator driver,
as it and its register-compatible cousins Silergy syr827 and syr828
are often used on Rockchip socs as cpu-supply next to regular pmic.

The rest can be enabled as modules and contains the pcie host
controller and its phy, the sucessive approximation adc (saradc)
that gets often used for additional buttons on Rockchip boards
as well as the adc-keys Keyboard driver for these keys.

The cros-ec-pwm also can be a module, as it is normally only used to
drive display backlights as well as the Rockchip thermal controller
that allows to read the cpu and gpu temperatures and affect frequency
scaling if necessary.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 65cdd878cfbd..97c123e09e45 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -68,6 +68,7 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCIE_RCAR=y
+CONFIG_PCIE_ROCKCHIP=m
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_ARM64_VA_BITS_48=y
@@ -208,6 +209,8 @@ CONFIG_BRCMFMAC=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
 CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_ADC=m
+CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
@@ -263,6 +266,7 @@ CONFIG_SPI_MESON_SPIFC=m
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_QUP=y
+CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
@@ -292,6 +296,7 @@ CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
@@ -300,12 +305,14 @@ CONFIG_RENESAS_WDT=y
 CONFIG_BCM2835_WDT=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
+CONFIG_MFD_CROS_EC_SPI=y
 CONFIG_MFD_EXYNOS_LPASS=m
 CONFIG_MFD_HI655X_PMIC=y
 CONFIG_MFD_MAX77620=y
 CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
+CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI655X=y
@@ -473,8 +480,10 @@ CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
+CONFIG_ROCKCHIP_SARADC=m
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
+CONFIG_PWM_CROS_EC=m
 CONFIG_PWM_MESON=m
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=y
@@ -484,6 +493,7 @@ CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_EMMC=y
+CONFIG_PHY_ROCKCHIP_PCIE=m
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_ARM_SCPI_PROTOCOL=y
-- 
2.11.0
