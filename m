From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  4 Sep 2016 13:04:14 +0200
Subject: [PATCH v3 11/17] ARM: dts: exynos: Use macros for pinctrl
 configuration on exynos542x/exynos5800
In-Reply-To: <1472987060-28293-1-git-send-email-krzk@kernel.org>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
Message-ID: <1472987060-28293-12-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Usage of DTS macros instead of hard-coded numbers makes code easier to
read.  One does not have to remember which value means pull-up/down or
specific driver strength.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   6 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 126 ++++----
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 354 ++++++++++-----------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  18 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  18 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 126 ++++----
 6 files changed, 324 insertions(+), 324 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 39a3b81478fd..657ffbb096c1 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -378,9 +378,9 @@
 &pinctrl_0 {
 	s2mps11_irq: s2mps11-irq {
 		samsung,pins = "gpx3-2";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index f6f256fd9b5e..a51175ad4b9f 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -753,171 +753,171 @@
 
 	wifi_en: wifi-en {
 		samsung,pins = "gpx0-0";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	max98090_irq: max98090-irq {
 		samsung,pins = "gpx0-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	/* We need GPX0_6 to be low at sleep time; just keep it low always */
 	mask_tpm_reset: mask-tpm-reset {
 		samsung,pins = "gpx0-6";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 		samsung,pin-val = <0>;
 	};
 
 	tpm_irq: tpm-irq {
 		samsung,pins = "gpx1-0";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	trackpad_irq: trackpad-irq {
 		samsung,pins = "gpx1-1";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	power_key_irq: power-key-irq {
 		samsung,pins = "gpx1-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	ec_irq: ec-irq {
 		samsung,pins = "gpx1-5";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	tps65090_irq: tps65090-irq {
 		samsung,pins = "gpx2-5";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	dp_hpd_gpio: dp_hpd_gpio {
 		samsung,pins = "gpx2-6";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	max77802_irq: max77802-irq {
 		samsung,pins = "gpx3-1";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	lid_irq: lid-irq {
 		samsung,pins = "gpx3-4";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <1>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pmic_dvs_1: pmic-dvs-1 {
 		samsung,pins = "gpy7-6";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
 &pinctrl_1 {
 	/* Adjust WiFi drive strengths lower for EMI */
 	sd1_clk: sd1-clk {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	sd1_cmd: sd1-cmd {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	sd1_bus1: sd1-bus-width1 {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	sd1_bus4: sd1-bus-width4 {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	sd1_bus8: sd1-bus-width8 {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 };
 
 &pinctrl_2 {
 	pmic_dvs_2: pmic-dvs-2 {
 		samsung,pins = "gpj4-2";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pmic_dvs_3: pmic-dvs-3 {
 		samsung,pins = "gpj4-3";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
 &pinctrl_3 {
 	/* Drive SPI lines at x2 for better integrity */
 	spi2-bus {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	/* Drive SPI chip select at x2 for better integrity */
 	ec_spi_cs: ec-spi-cs {
 		samsung,pins = "gpb1-2";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	usb300_vbus_en: usb300-vbus-en {
 		samsung,pins = "gph0-0";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	usb301_vbus_en: usb301-vbus-en {
 		samsung,pins = "gph0-1";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pmic_selb: pmic-selb {
 		samsung,pins = "gph0-2", "gph0-3", "gph0-4", "gph0-5",
 			       "gph0-6";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index cf7d2986780a..3924b4fafe72 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -63,9 +63,9 @@
 
 	dp_hpd: dp_hpd {
 		samsung,pins = "gpx0-7";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
@@ -155,135 +155,135 @@
 
 	sd0_clk: sd0-clk {
 		samsung,pins = "gpc0-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd0_cmd: sd0-cmd {
 		samsung,pins = "gpc0-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd0_cd: sd0-cd {
 		samsung,pins = "gpc0-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd0_bus1: sd0-bus-width1 {
 		samsung,pins = "gpc0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd0_bus4: sd0-bus-width4 {
 		samsung,pins = "gpc0-4", "gpc0-5", "gpc0-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd0_bus8: sd0-bus-width8 {
 		samsung,pins = "gpc3-0", "gpc3-1", "gpc3-2", "gpc3-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd0_rclk: sd0-rclk {
 		samsung,pins = "gpc0-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <1>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd1_clk: sd1-clk {
 		samsung,pins = "gpc1-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd1_cmd: sd1-cmd {
 		samsung,pins = "gpc1-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd1_cd: sd1-cd {
 		samsung,pins = "gpc1-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd1_int: sd1-int {
 		samsung,pins = "gpd1-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	sd1_bus1: sd1-bus-width1 {
 		samsung,pins = "gpc1-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd1_bus4: sd1-bus-width4 {
 		samsung,pins = "gpc1-4", "gpc1-5", "gpc1-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd1_bus8: sd1-bus-width8 {
 		samsung,pins = "gpd1-4", "gpd1-5", "gpd1-6", "gpd1-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd2_clk: sd2-clk {
 		samsung,pins = "gpc2-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd2_cmd: sd2-cmd {
 		samsung,pins = "gpc2-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd2_cd: sd2-cd {
 		samsung,pins = "gpc2-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd2_bus1: sd2-bus-width1 {
 		samsung,pins = "gpc2-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
 	sd2_bus4: sd2-bus-width4 {
 		samsung,pins = "gpc2-4", "gpc2-5", "gpc2-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 };
 
@@ -356,52 +356,52 @@
 		samsung,pins = "gpe0-0", "gpe0-1", "gpe0-2", "gpe0-3",
 			       "gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
 			       "gpe1-0", "gpe1-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	cam_gpio_b: cam-gpio-b {
 		samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3",
 			       "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	cam_i2c2_bus: cam-i2c2-bus {
 		samsung,pins = "gpf0-4", "gpf0-5";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	cam_spi1_bus: cam-spi1-bus {
 		samsung,pins = "gpe0-4", "gpe0-5", "gpf0-2", "gpf0-3";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	cam_i2c1_bus: cam-i2c1-bus {
 		samsung,pins = "gpf0-2", "gpf0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	cam_i2c0_bus: cam-i2c0-bus {
 		samsung,pins = "gpf0-0", "gpf0-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	cam_spi0_bus: cam-spi0-bus {
 		samsung,pins = "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	cam_bayrgb_bus: cam-bayrgb-bus {
@@ -410,9 +410,9 @@
 			       "gpg1-0", "gpg1-1", "gpg1-2", "gpg1-3",
 			       "gpg1-4", "gpg1-5", "gpg1-6", "gpg1-7",
 			       "gpg2-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
@@ -491,216 +491,216 @@
 
 	uart0_data: uart0-data {
 		samsung,pins = "gpa0-0", "gpa0-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	uart0_fctl: uart0-fctl {
 		samsung,pins = "gpa0-2", "gpa0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	uart1_data: uart1-data {
 		samsung,pins = "gpa0-4", "gpa0-5";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	uart1_fctl: uart1-fctl {
 		samsung,pins = "gpa0-6", "gpa0-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c2_bus: i2c2-bus {
 		samsung,pins = "gpa0-6", "gpa0-7";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	uart2_data: uart2-data {
 		samsung,pins = "gpa1-0", "gpa1-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	uart2_fctl: uart2-fctl {
 		samsung,pins = "gpa1-2", "gpa1-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c3_bus: i2c3-bus {
 		samsung,pins = "gpa1-2", "gpa1-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	uart3_data: uart3-data {
 		samsung,pins = "gpa1-4", "gpa1-5";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	spi0_bus: spi0-bus {
 		samsung,pins = "gpa2-0", "gpa2-1", "gpa2-2", "gpa2-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	spi1_bus: spi1-bus {
 		samsung,pins = "gpa2-4", "gpa2-6", "gpa2-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c4_hs_bus: i2c4-hs-bus {
 		samsung,pins = "gpa2-0", "gpa2-1";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c5_hs_bus: i2c5-hs-bus {
 		samsung,pins = "gpa2-2", "gpa2-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2s1_bus: i2s1-bus {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 			       "gpb0-4";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pcm1_bus: pcm1-bus {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 			       "gpb0-4";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2s2_bus: i2s2-bus {
 		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
 			       "gpb1-4";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pcm2_bus: pcm2-bus {
 		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
 			       "gpb1-4";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	spdif_bus: spdif-bus {
 		samsung,pins = "gpb1-0", "gpb1-1";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	spi2_bus: spi2-bus {
 		samsung,pins = "gpb1-1", "gpb1-3", "gpb1-4";
-		samsung,pin-function = <5>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c6_hs_bus: i2c6-hs-bus {
 		samsung,pins = "gpb1-3", "gpb1-4";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pwm0_out: pwm0-out {
 		samsung,pins = "gpb2-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pwm1_out: pwm1-out {
 		samsung,pins = "gpb2-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pwm2_out: pwm2-out {
 		samsung,pins = "gpb2-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pwm3_out: pwm3-out {
 		samsung,pins = "gpb2-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c7_hs_bus: i2c7-hs-bus {
 		samsung,pins = "gpb2-2", "gpb2-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c0_bus: i2c0-bus {
 		samsung,pins = "gpb3-0", "gpb3-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c1_bus: i2c1-bus {
 		samsung,pins = "gpb3-2", "gpb3-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c8_hs_bus: i2c8-hs-bus {
 		samsung,pins = "gpb3-4", "gpb3-5";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c9_hs_bus: i2c9-hs-bus {
 		samsung,pins = "gpb3-6", "gpb3-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	i2c10_hs_bus: i2c10-hs-bus {
 		samsung,pins = "gpb4-0", "gpb4-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
@@ -716,8 +716,8 @@
 	i2s0_bus: i2s0-bus {
 		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 				"gpz-4", "gpz-5", "gpz-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 29546465d3da..92c8fef2e071 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -386,25 +386,25 @@
 &pinctrl_0 {
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <1>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
 &pinctrl_2 {
 	usb300_vbus_en: usb300-vbus-en {
 		samsung,pins = "gpg0-5";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	usb301_vbus_en: usb301-vbus-en {
 		samsung,pins = "gpg1-4";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 7bb8a370072a..1e670b851ff2 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -548,25 +548,25 @@
 &pinctrl_0 {
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <1>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	s2mps11_irq: s2mps11-irq {
 		samsung,pins = "gpx0-4";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
 &pinctrl_1 {
 	emmc_nrst_pin: emmc-nrst {
 		samsung,pins = "gpd1-0";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 51a8bca4691c..3f4cb6819820 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -722,171 +722,171 @@
 
 	wifi_en: wifi-en {
 		samsung,pins = "gpx0-0";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	max98091_irq: max98091-irq {
 		samsung,pins = "gpx0-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	/* We need GPX0_6 to be low at sleep time; just keep it low always */
 	mask_tpm_reset: mask-tpm-reset {
 		samsung,pins = "gpx0-6";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 		samsung,pin-val = <0>;
 	};
 
 	tpm_irq: tpm-irq {
 		samsung,pins = "gpx1-0";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	trackpad_irq: trackpad-irq {
 		samsung,pins = "gpx1-1";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	power_key_irq: power-key-irq {
 		samsung,pins = "gpx1-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	ec_irq: ec-irq {
 		samsung,pins = "gpx1-5";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	tps65090_irq: tps65090-irq {
 		samsung,pins = "gpx2-5";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	dp_hpd_gpio: dp_hpd_gpio {
 		samsung,pins = "gpx2-6";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	max77802_irq: max77802-irq {
 		samsung,pins = "gpx3-1";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	lid_irq: lid-irq {
 		samsung,pins = "gpx3-4";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <1>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pmic_dvs_1: pmic-dvs-1 {
 		samsung,pins = "gpy7-6";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
 &pinctrl_1 {
 	/* Adjust WiFi drive strengths lower for EMI */
 	sd1_clk: sd1-clk {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	sd1_cmd: sd1-cmd {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	sd1_bus1: sd1-bus-width1 {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	sd1_bus4: sd1-bus-width4 {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	sd1_bus8: sd1-bus-width8 {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 };
 
 &pinctrl_2 {
 	pmic_dvs_2: pmic-dvs-2 {
 		samsung,pins = "gpj4-2";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pmic_dvs_3: pmic-dvs-3 {
 		samsung,pins = "gpj4-3";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
 &pinctrl_3 {
 	/* Drive SPI lines at x2 for better integrity */
 	spi2-bus {
-		samsung,pin-drv = <2>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	/* Drive SPI chip select at x2 for better integrity */
 	ec_spi_cs: ec-spi-cs {
 		samsung,pins = "gpb1-2";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 	};
 
 	usb300_vbus_en: usb300-vbus-en {
 		samsung,pins = "gph0-0";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	usb301_vbus_en: usb301-vbus-en {
 		samsung,pins = "gph0-1";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 
 	pmic_selb: pmic-selb {
 		samsung,pins = "gph0-2", "gph0-3", "gph0-4", "gph0-5",
 			       "gph0-6";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
 	};
 };
 
-- 
2.7.4
