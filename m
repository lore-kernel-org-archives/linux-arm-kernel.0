From: andy.yan@rock-chips.com (Andy Yan)
Date: Sat, 22 Oct 2016 20:54:55 +0800
Subject: [PATCH 1/2] ARM: dts: rockchip: use pin constants to describe gpios
In-Reply-To: <1477140706-6886-1-git-send-email-andy.yan@rock-chips.com>
References: <1477140706-6886-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1477140895-6938-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use macros to describe gpios will make the dts easier to
read and write.

All the modifications done with sed:

sed -i -e 's/ 0  GPIO_ACTIVE_/ RK_PA0 GPIO_ACTIVE_/' arch/arm/boot/dts/rk*
sed -i -e 's/ 1  GPIO_ACTIVE_/ RK_PA1 GPIO_ACTIVE_/' arch/arm/boot/dts/rk*
sed -i -e 's/ 2  GPIO_ACTIVE_/ RK_PA2 GPIO_ACTIVE_/' arch/arm/boot/dts/rk*
.......
.......
sed -i -e 's/ 30 GPIO_ACTIVE_/ RK_PD6 GPIO_ACTIVE_/' arch/arm/boot/dts/rk*
sed -i -e 's/ 31 GPIO_ACTIVE_/ RK_PD7 GPIO_ACTIVE_/' arch/arm/boot/dts/rk*

Tested with:

for i in dts-old/*dtb; do scripts/dtc/dtx_diff $i dts-new/$(basename $i);  done

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

 arch/arm/boot/dts/rk3036-evb.dts                  |  2 +-
 arch/arm/boot/dts/rk3036-kylin.dts                | 10 +++++-----
 arch/arm/boot/dts/rk3066a-bqcurie2.dts            |  6 +++---
 arch/arm/boot/dts/rk3066a-marsboard.dts           |  2 +-
 arch/arm/boot/dts/rk3066a-mk808.dts               | 10 +++++-----
 arch/arm/boot/dts/rk3066a-rayeager.dts            | 12 ++++++------
 arch/arm/boot/dts/rk3188-px3-evb.dts              |  4 ++--
 arch/arm/boot/dts/rk3188-radxarock.dts            | 16 +++++++--------
 arch/arm/boot/dts/rk3229-evb.dts                  |  2 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts          |  4 ++--
 arch/arm/boot/dts/rk3288-evb.dtsi                 | 14 ++++++-------
 arch/arm/boot/dts/rk3288-fennec.dts               |  4 ++--
 arch/arm/boot/dts/rk3288-firefly-beta.dts         |  2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi |  2 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts       | 24 +++++++++++------------
 arch/arm/boot/dts/rk3288-firefly.dts              |  2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi             | 16 +++++++--------
 arch/arm/boot/dts/rk3288-miqi.dts                 |  8 ++++----
 arch/arm/boot/dts/rk3288-popmetal.dts             |  2 +-
 arch/arm/boot/dts/rk3288-r89.dts                  | 12 ++++++------
 arch/arm/boot/dts/rk3288-rock2-som.dtsi           |  4 ++--
 arch/arm/boot/dts/rk3288-rock2-square.dts         | 12 ++++++------
 arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi |  4 ++--
 arch/arm/boot/dts/rk3288-veyron-brain.dts         |  8 ++++----
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi   | 10 +++++-----
 arch/arm/boot/dts/rk3288-veyron-jaq.dts           | 14 ++++++-------
 arch/arm/boot/dts/rk3288-veyron-jerry.dts         | 10 +++++-----
 arch/arm/boot/dts/rk3288-veyron-mickey.dts        |  6 +++---
 arch/arm/boot/dts/rk3288-veyron-minnie.dts        | 16 +++++++--------
 arch/arm/boot/dts/rk3288-veyron-pinky.dts         |  4 ++--
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi        |  2 +-
 arch/arm/boot/dts/rk3288-veyron-speedy.dts        | 10 +++++-----
 arch/arm/boot/dts/rk3288-veyron.dtsi              |  8 ++++----
 33 files changed, 131 insertions(+), 131 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036-evb.dts b/arch/arm/boot/dts/rk3036-evb.dts
index 2f5f155..c095341 100644
--- a/arch/arm/boot/dts/rk3036-evb.dts
+++ b/arch/arm/boot/dts/rk3036-evb.dts
@@ -56,7 +56,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&emac_xfer>, <&emac_mdio>;
 	phy = <&phy0>;
-	phy-reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>; /* PHY_RST */
+	phy-reset-gpios = <&gpio2 RK_PC6 GPIO_ACTIVE_LOW>; /* PHY_RST */
 	phy-reset-duration = <10>; /* millisecond */
 
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
index 3de958e..2518259 100644
--- a/arch/arm/boot/dts/rk3036-kylin.dts
+++ b/arch/arm/boot/dts/rk3036-kylin.dts
@@ -55,7 +55,7 @@
 		compatible = "gpio-leds";
 
 		work {
-			gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
 			label = "kylin:red:led";
 			pinctrl-names = "default";
 			pinctrl-0 = <&led_ctl>;
@@ -74,9 +74,9 @@
 		 * - SDIO_RESET_L_WL_RST
 		 * - SDIO_RESET_L_BT_EN
 		 */
-		reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>, /* WL_REG_ON */
-			      <&gpio0 27 GPIO_ACTIVE_LOW>, /* WL_RST */
-			      <&gpio2 9  GPIO_ACTIVE_LOW>; /* BT_EN */
+		reset-gpios = <&gpio0 RK_PD2 GPIO_ACTIVE_LOW>, /* WL_REG_ON */
+			      <&gpio0 RK_PD3 GPIO_ACTIVE_LOW>, /* WL_RST */
+			      <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>; /* BT_EN */
 	};
 
 	sound {
@@ -121,7 +121,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&emac_xfer>, <&emac_mdio>;
 	phy = <&phy0>;
-	phy-reset-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>; /* PHY_RST */
+	phy-reset-gpios = <&gpio2 RK_PC6 GPIO_ACTIVE_LOW>; /* PHY_RST */
 	phy-reset-duration = <10>; /* millisecond */
 
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index c0d8b54..9e852c6 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -71,7 +71,7 @@
 		regulator-name = "sdmmc-supply";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
-		gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
 		startup-delay-us = <100000>;
 		vin-supply = <&vcc_io>;
 	};
@@ -81,7 +81,7 @@
 		autorepeat;
 
 		power {
-			gpios = <&gpio6 2 GPIO_ACTIVE_LOW>; /* GPIO6_A2 */
+			gpios = <&gpio6 RK_PA2 GPIO_ACTIVE_LOW>; /* GPIO6_A2 */
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
@@ -89,7 +89,7 @@
 			debounce-interval = <100>;
 		};
 		volume-down {
-			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>; /* GPIO4_C5 */
+			gpios = <&gpio4 RK_PC5 GPIO_ACTIVE_LOW>; /* GPIO4_C5 */
 			linux,code = <KEY_VOLUMEDOWN>;
 			label = "GPIO Key Vol-";
 			linux,input-type = <1>;
diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index 0a54c4b..cdf0a88 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -69,7 +69,7 @@
 		regulator-name = "sdmmc-supply";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
-		gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
 		startup-delay-us = <100000>;
 		vin-supply = <&vcc_io>;
 	};
diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 658eb7d..7ca1cf5 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -61,7 +61,7 @@
 
 		blue {
 			label = "mk808:blue:power";
-			gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 			linux,default-trigger = "default-on";
 		};
@@ -77,7 +77,7 @@
 	vcc_host: usb-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&host_drv>;
 		pinctrl-names = "default";
 		regulator-always-on;
@@ -91,7 +91,7 @@
 	vcc_otg: usb-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&otg_drv>;
 		pinctrl-names = "default";
 		regulator-always-on;
@@ -104,7 +104,7 @@
 
 	vcc_sd: sdmmc-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&sdmmc_pwr>;
 		pinctrl-names = "default";
 		regulator-name = "vcc_sd";
@@ -117,7 +117,7 @@
 	vcc_wifi: sdio-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio3 24 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio3 RK_PD0 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&wifi_pwr>;
 		pinctrl-names = "default";
 		regulator-name = "vcc_wifi";
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index 82465b6..7c05e8b 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -55,7 +55,7 @@
 
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio6 1 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio6 RK_PA1 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ir_int>;
 	};
@@ -65,7 +65,7 @@
 
 		power {
 			wakeup-source;
-			gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio6 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
 			pinctrl-names = "default";
@@ -115,7 +115,7 @@
 	vcc_sata: sata-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sata_pwr>;
 		regulator-name = "usb_5v";
@@ -127,7 +127,7 @@
 
 	vcc_sd: sdmmc-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio3 RK_PA7 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_pwr>;
 		regulator-name = "vcc_sd";
@@ -140,7 +140,7 @@
 	vcc_host: usb-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_drv>;
 		regulator-name = "host-pwr";
@@ -153,7 +153,7 @@
 	vcc_otg: usb-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&otg_drv>;
 		regulator-name = "vcc_otg";
diff --git a/arch/arm/boot/dts/rk3188-px3-evb.dts b/arch/arm/boot/dts/rk3188-px3-evb.dts
index df727ba..4afd9d8 100644
--- a/arch/arm/boot/dts/rk3188-px3-evb.dts
+++ b/arch/arm/boot/dts/rk3188-px3-evb.dts
@@ -62,7 +62,7 @@
 		autorepeat;
 
 		power {
-			gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
@@ -248,7 +248,7 @@
 		reg = <0x40>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
-		power-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 		touchscreen-size-x = <800>;
 		touchscreen-size-y = <1280>;
 		silead,max-fingers = <5>;
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 5e8a235..28a2931 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -58,7 +58,7 @@
 		autorepeat;
 
 		power {
-			gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
@@ -72,19 +72,19 @@
 
 		green {
 			label = "rock:green:user1";
-			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
 		blue {
 			label = "rock:blue:user2";
-			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
 		sleep {
 			label = "rock:red:power";
-			gpios = <&gpio0 15 0>;
+			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 	};
@@ -106,7 +106,7 @@
 
 	ir_recv: gpio-ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio0 10 1>;
+		gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ir_recv_pin>;
 	};
@@ -114,7 +114,7 @@
 	vcc_otg: usb-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 RK_PD7 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&otg_vbus_drv>;
 		regulator-name = "otg-vbus";
@@ -129,7 +129,7 @@
 		regulator-name = "sdmmc-supply";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio3 1 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio3 RK_PA1 GPIO_ACTIVE_LOW>;
 		startup-delay-us = <100000>;
 		vin-supply = <&vcc_io>;
 	};
@@ -137,7 +137,7 @@
 	vcc_host: usb-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "host-pwr";
diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
index dcdd0ce..275092a 100644
--- a/arch/arm/boot/dts/rk3229-evb.dts
+++ b/arch/arm/boot/dts/rk3229-evb.dts
@@ -77,7 +77,7 @@
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
-	snps,reset-gpio = <&gpio2 24 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio2 RK_PD0 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
 	tx_delay = <0x30>;
diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index 041dd5d..f4f29fe 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -47,7 +47,7 @@
 	vcc_lcd: vcc-lcd {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio7 3 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio7 RK_PA3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_en>;
 		regulator-name = "vcc_lcd";
@@ -57,7 +57,7 @@
 	vcc_wl: vcc-wl {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio7 9 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio7 RK_PB1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_pwr>;
 		regulator-name = "vcc_wl";
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index bf7ccfa..0dec94c 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -84,7 +84,7 @@
 			240 241 242 243 244 245 246 247
 			248 249 250 251 252 253 254 255>;
 		default-brightness-level = <128>;
-		enable-gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
 		pwms = <&pwm0 0 1000000 PWM_POLARITY_INVERTED>;
@@ -100,7 +100,7 @@
 	panel: panel {
 		compatible ="lg,lp079qx1-sp0v", "simple-panel";
 		backlight = <&backlight>;
-		enable-gpios = <&gpio7 4 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio7 RK_PA4 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&lcd_cs>;
 
 		ports {
@@ -120,7 +120,7 @@
 		pinctrl-0 = <&pwrbtn>;
 
 		power {
-			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
@@ -133,7 +133,7 @@
 	vcc_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "vcc_host";
@@ -144,7 +144,7 @@
 	vcc_phy: vcc-phy-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&eth_phy_pwr>;
 		regulator-name = "vcc_phy";
@@ -170,7 +170,7 @@
 	 */
 	vcc_sd: sdmmc-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_pwr>;
 		regulator-name = "vcc_sd";
@@ -236,7 +236,7 @@
 	phy-supply = <&vcc_phy>;
 	phy-mode = "rgmii";
 	clock_in_out = "input";
-	snps,reset-gpio = <&gpio4 7 0>;
+	snps,reset-gpio = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
 	assigned-clocks = <&cru SCLK_MAC>;
diff --git a/arch/arm/boot/dts/rk3288-fennec.dts b/arch/arm/boot/dts/rk3288-fennec.dts
index 805c0d2..dc00f12 100644
--- a/arch/arm/boot/dts/rk3288-fennec.dts
+++ b/arch/arm/boot/dts/rk3288-fennec.dts
@@ -93,7 +93,7 @@
 	phy-mode = "rgmii";
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
-	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_LOW>;
 	tx_delay = <0x30>;
 	rx_delay = <0x10>;
 	status = "okay";
@@ -345,7 +345,7 @@
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&host_drv>;
-	vbus_drv-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+	vbus_drv-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/rk3288-firefly-beta.dts b/arch/arm/boot/dts/rk3288-firefly-beta.dts
index 75d77e3..0195d97 100644
--- a/arch/arm/boot/dts/rk3288-firefly-beta.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-beta.dts
@@ -49,7 +49,7 @@
 };
 
 &ir {
-	gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
+	gpios = <&gpio7 RK_PA5 GPIO_ACTIVE_LOW>;
 };
 
 &pinctrl {
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
index d242588..8134966 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
@@ -96,7 +96,7 @@
 	phy-mode = "rgmii";
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
-	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_LOW>;
 	tx_delay = <0x30>;
 	rx_delay = <0x10>;
 	status = "ok";
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
index 751bee8..d28c8c3 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -53,7 +53,7 @@
 
 		power {
 			wakeup-source;
-			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
 			pinctrl-names = "default";
@@ -63,14 +63,14 @@
 
 	ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio7 RK_PA0 GPIO_ACTIVE_LOW>;
 	};
 
 	leds {
 		compatible = "gpio-leds";
 
 		power {
-			gpios = <&gpio8 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio8 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "firefly:blue:power";
 			pinctrl-names = "default";
 			pinctrl-0 = <&power_led>;
@@ -78,7 +78,7 @@
 		};
 
 		work {
-			gpios = <&gpio8 1 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio8 RK_PA1 GPIO_ACTIVE_LOW>;
 			label = "firefly:blue:user";
 			linux,default-trigger = "rc-feedback";
 			pinctrl-names = "default";
@@ -92,7 +92,7 @@
 		clock-names = "ext_clock";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_enable>;
-		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
 	};
 
 	sound {
@@ -112,7 +112,7 @@
 	vcc_host_5v: usb-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "vcc_host_5v";
@@ -133,7 +133,7 @@
 
 	vcc_sd: sdmmc-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_pwr>;
 		regulator-name = "vcc_sd";
@@ -146,7 +146,7 @@
 	vcc_otg_5v: usb-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&otg_vbus_drv>;
 		regulator-name = "vcc_otg_5v";
@@ -159,7 +159,7 @@
 	dovdd_1v8: dovdd-1v8-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&dvp_pwr>;
 		regulator-name = "dovdd_1v8";
@@ -171,7 +171,7 @@
 	vcc28_dvp: vcc28-dvp-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&dvp_pwr>;
 		regulator-name = "vcc28_dvp";
@@ -183,7 +183,7 @@
 	af_28: af_28-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&dvp_pwr>;
 		regulator-name = "af_28";
@@ -195,7 +195,7 @@
 	dvdd_1v2: af_28-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&cif_pwr>;
 		regulator-name = "dvdd_1v2";
diff --git a/arch/arm/boot/dts/rk3288-firefly.dts b/arch/arm/boot/dts/rk3288-firefly.dts
index c07fe92..14271be 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dts
+++ b/arch/arm/boot/dts/rk3288-firefly.dts
@@ -49,7 +49,7 @@
 };
 
 &ir {
-	gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+	gpios = <&gpio7 RK_PA0 GPIO_ACTIVE_LOW>;
 };
 
 &pinctrl {
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 44935af..e4dd758 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -75,7 +75,7 @@
 
 		power {
 			wakeup-source;
-			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
 			pinctrl-names = "default";
@@ -87,7 +87,7 @@
 		compatible = "gpio-leds";
 
 		work {
-			gpios = <&gpio8 1 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio8 RK_PA1 GPIO_ACTIVE_LOW>;
 			label = "firefly:blue:user";
 			linux,default-trigger = "rc-feedback";
 			pinctrl-names = "default";
@@ -95,7 +95,7 @@
 		};
 
 		power {
-			gpios = <&gpio8 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio8 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "firefly:green:power";
 			linux,default-trigger = "default-on";
 			pinctrl-names = "default";
@@ -114,7 +114,7 @@
 
 	vcc_sd: sdmmc-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_pwr>;
 		regulator-name = "vcc_sd";
@@ -145,7 +145,7 @@
 	vcc_host_5v: usb-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "vcc_host_5v";
@@ -158,7 +158,7 @@
 	vcc_otg_5v: usb-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&otg_vbus_drv>;
 		regulator-name = "vcc_otg_5v";
@@ -175,7 +175,7 @@
 	vcc28_dvp: vcc28-dvp-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&dvp_pwr>;
 		regulator-name = "vcc28_dvp";
@@ -213,7 +213,7 @@
 	phy-mode = "rgmii";
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
-	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_LOW>;
 	tx_delay = <0x30>;
 	rx_delay = <0x10>;
 	status = "ok";
diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
index 441d450..21326f3 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -68,7 +68,7 @@
 		compatible = "gpio-leds";
 
 		work {
-			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio7 RK_PA4 GPIO_ACTIVE_LOW>;
 			label = "miqi:green:user";
 			linux,default-trigger = "default-on";
 			pinctrl-names = "default";
@@ -87,7 +87,7 @@
 	vcc_host: usb-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "vcc_host";
@@ -99,7 +99,7 @@
 
 	vcc_sd: sdmmc-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_pwr>;
 		regulator-name = "vcc_sd";
@@ -146,7 +146,7 @@
 	phy-mode = "rgmii";
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
-	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_LOW>;
 	tx_delay = <0x30>;
 	rx_delay = <0x10>;
 	status = "ok";
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index bc6d100..e0b5e84 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -180,7 +180,7 @@
 	phy-supply = <&vcc_lan>;
 	phy-mode = "rgmii";
 	clock_in_out = "input";
-	snps,reset-gpio = <&gpio4 RK_PB0 0>;
+	snps,reset-gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
 	assigned-clocks = <&cru SCLK_MAC>;
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index 04faa72..54a0fc0 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -68,7 +68,7 @@
 		pinctrl-0 = <&pwrbtn>;
 
 		power {
-			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
 			linux,input-type = <1>;
@@ -79,7 +79,7 @@
 
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio7 RK_PA0 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ir_int>;
 	};
@@ -87,7 +87,7 @@
 	vcc_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "vcc_host";
@@ -98,7 +98,7 @@
 	vcc_otg: vcc-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&otg_vbus_drv>;
 		regulator-name = "vcc_otg";
@@ -111,7 +111,7 @@
 		regulator-name = "sdmmc-supply";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		startup-delay-us = <100000>;
 		vin-supply = <&vcc_io>;
 	};
@@ -134,7 +134,7 @@
 	phy-supply = <&vcc_lan>;
 	phy-mode = "rgmii";
 	clock_in_out = "input";
-	snps,reset-gpio = <&gpio4 7 0>;
+	snps,reset-gpio = <&gpio4 RK_PA7 GPIO_ACTIVE_HIGH>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
 	assigned-clocks = <&cru SCLK_MAC>;
diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index b25ba80..1c0bbc9 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -51,7 +51,7 @@
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_LOW>;
 	};
 
 	ext_gmac: external-gmac-clock {
@@ -106,7 +106,7 @@
 	phy-supply = <&vccio_pmu>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins &phy_rst>;
-	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio4 RK_PB0 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 30000>;
 	rx_delay = <0x10>;
diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index dd3ad2e..6cc83fe 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -53,13 +53,13 @@
 		compatible = "gpio-leds";
 
 		heartbeat {
-			gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio7 RK_PB7 GPIO_ACTIVE_LOW>;
 			label = "rock2:green:state1";
 			linux,default-trigger = "heartbeat";
 		};
 
 		mmc {
-			gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_LOW>;
 			label = "rock2:blue:state2";
 			linux,default-trigger = "mmc0";
 		};
@@ -67,7 +67,7 @@
 
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio8 1 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio8 RK_PA1 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ir_int>;
 	};
@@ -92,13 +92,13 @@
 		clock-names = "ext_clock";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_enable>;
-		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
 	};
 
 	vcc_usb_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		/* Always on as the rockchip usb phy doesn't have a vbus-supply
@@ -110,7 +110,7 @@
 
 	vcc_sd: sdmmc-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sdmmc_pwr>;
 		regulator-name = "vcc_sd";
diff --git a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
index 6d105914..f8c5a47 100644
--- a/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-analog-audio.dtsi
@@ -17,8 +17,8 @@
 		rockchip,model = "VEYRON-I2S";
 		rockchip,i2s-controller = <&i2s>;
 		rockchip,audio-codec = <&max98090>;
-		rockchip,hp-det-gpios = <&gpio6 5 GPIO_ACTIVE_HIGH>;
-		rockchip,mic-det-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+		rockchip,hp-det-gpios = <&gpio6 RK_PA5 GPIO_ACTIVE_HIGH>;
+		rockchip,mic-det-gpios = <&gpio6 RK_PB3 GPIO_ACTIVE_LOW>;
 		rockchip,headset-codec = <&headsetcodec>;
 	};
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron-brain.dts b/arch/arm/boot/dts/rk3288-veyron-brain.dts
index cf5311d..ed42552 100644
--- a/arch/arm/boot/dts/rk3288-veyron-brain.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-brain.dts
@@ -67,7 +67,7 @@
 	vcc5_host2: vcc5-host2-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb2_pwr_en>;
 		regulator-name = "vcc5_host2";
@@ -103,8 +103,8 @@
 &rk808 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
-	dvs-gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>,
-		    <&gpio7 15 GPIO_ACTIVE_HIGH>;
+	dvs-gpios = <&gpio7 RK_PB3 GPIO_ACTIVE_HIGH>,
+		    <&gpio7 RK_PB7 GPIO_ACTIVE_HIGH>;
 
 	/delete-property/ vcc6-supply;
 
@@ -133,7 +133,7 @@
 
 &vcc50_hdmi {
 	enable-active-high;
-	gpio = <&gpio7 2 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&vcc50_hdmi_en>;
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index ce1f879..9e882f3 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -91,7 +91,7 @@
 			240 241 242 243 244 245 246 247
 			248 249 250 251 252 253 254 255>;
 		default-brightness-level = <128>;
-		enable-gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
 		backlight-boot-off;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
@@ -102,7 +102,7 @@
 	gpio-charger {
 		compatible = "gpio-charger";
 		charger-type = "mains";
-		gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpio0 RK_PB0 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ac_present_ap>;
 	};
@@ -142,7 +142,7 @@
 	vcc5_host1: vcc5-host1-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host1_pwr_en>;
 		regulator-name = "vcc5_host1";
@@ -154,7 +154,7 @@
 	vcc5v_otg: vcc5v-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usbotg_pwren_h>;
 		regulator-name = "vcc5_host2";
@@ -190,7 +190,7 @@
 	pinctrl-0 = <&pwr_key_l &ap_lid_int_l>;
 	lid {
 		label = "Lid";
-		gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
 		wakeup-source;
 		linux,code = <0>; /* SW_LID */
 		linux,input-type = <5>; /* EV_SW */
diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index 3748abf..d33f576 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -57,7 +57,7 @@
 	panel_regulator: panel-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio7 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
@@ -68,7 +68,7 @@
 	vcc18_lcd: vcc18-lcd {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&avdd_1v8_disp_en>;
 		regulator-name = "vcc18_lcd";
@@ -80,7 +80,7 @@
 	backlight_regulator: backlight-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_pwr_en>;
 		regulator-name = "backlight_regulator";
@@ -134,8 +134,8 @@
 &rk808 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
-	dvs-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>,
-		    <&gpio7 15 GPIO_ACTIVE_HIGH>;
+	dvs-gpios = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>,
+		    <&gpio7 RK_PB7 GPIO_ACTIVE_HIGH>;
 
 	regulators {
 		mic_vcc: LDO_REG2 {
@@ -160,14 +160,14 @@
 
 &vcc_5v {
 	enable-active-high;
-	gpio = <&gpio7 21 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&drv_5v>;
 };
 
 &vcc50_hdmi {
 	enable-active-high;
-	gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio5 RK_PC3 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&vcc50_hdmi_en>;
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index f6b2eaa..6107f76 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -56,7 +56,7 @@
 	panel_regulator: panel-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio7 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
@@ -67,7 +67,7 @@
 	vcc18_lcd: vcc18-lcd {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&avdd_1v8_disp_en>;
 		regulator-name = "vcc18_lcd";
@@ -79,7 +79,7 @@
 	backlight_regulator: backlight-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_pwr_en>;
 		regulator-name = "backlight_regulator";
@@ -123,14 +123,14 @@
 
 &vcc_5v {
 	enable-active-high;
-	gpio = <&gpio7 21 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&drv_5v>;
 };
 
 &vcc50_hdmi {
 	enable-active-high;
-	gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio5 RK_PC3 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&vcc50_hdmi_en>;
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index f36f6f4..f0994f0 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -182,8 +182,8 @@
 &rk808 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
-	dvs-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>,
-		    <&gpio7 15 GPIO_ACTIVE_HIGH>;
+	dvs-gpios = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>,
+		    <&gpio7 RK_PB7 GPIO_ACTIVE_HIGH>;
 
 	/delete-property/ vcc6-supply;
 	/delete-property/ vcc12-supply;
@@ -244,7 +244,7 @@
 
 &vcc50_hdmi {
 	enable-active-high;
-	gpio = <&gpio7 11 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio7 RK_PB3 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&power_hdmi_on>;
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index f72d616d..53c7205 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -55,7 +55,7 @@
 	backlight_regulator: backlight-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_pwr_en>;
 		regulator-name = "backlight_regulator";
@@ -66,7 +66,7 @@
 	panel_regulator: panel-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio7 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
@@ -77,7 +77,7 @@
 	vcc18_lcd: vcc18-lcd {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&avdd_1v8_disp_en>;
 		regulator-name = "vcc18_lcd";
@@ -134,14 +134,14 @@
 
 	volum_down {
 		label = "Volum_down";
-		gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio5 RK_PB3 GPIO_ACTIVE_LOW>;
 		linux,code = <KEY_VOLUMEDOWN>;
 		debounce-interval = <100>;
 	};
 
 	volum_up {
 		label = "Volum_up";
-		gpios = <&gpio5 10 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio5 RK_PB2 GPIO_ACTIVE_LOW>;
 		linux,code = <KEY_VOLUMEUP>;
 		debounce-interval = <100>;
 	};
@@ -168,7 +168,7 @@
 		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&touch_int &touch_rst>;
-		reset-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_LOW>;
 		vcc33-supply = <&vcc33_touch>;
 		vccio-supply = <&vcc33_touch>;
 	};
@@ -211,14 +211,14 @@
 
 &vcc_5v {
 	enable-active-high;
-	gpio = <&gpio7 21 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&drv_5v>;
 };
 
 &vcc50_hdmi {
 	enable-active-high;
-	gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio5 RK_PC3 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&vcc50_hdmi_en>;
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
index d44351e..995cff4 100644
--- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
@@ -76,7 +76,7 @@
 	pinctrl-0 = <&pwr_key_h &ap_lid_int_l>;
 
 	power {
-		gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 	};
 };
 
@@ -126,7 +126,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
 		     &sdmmc_wp_gpio &sdmmc_bus4>;
-	wp-gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>;
+	wp-gpios = <&gpio7 RK_PB2 GPIO_ACTIVE_HIGH>;
 };
 
 &tsadc {
diff --git a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
index fec076e..aef0710 100644
--- a/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
@@ -115,7 +115,7 @@
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
-	cd-gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&gpio7 RK_PA5 GPIO_ACTIVE_LOW>;
 	rockchip,default-sample-phase = <90>;
 	num-slots = <1>;
 	sd-uhs-sdr12;
diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index a0d033f..cc0b78c 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -57,7 +57,7 @@
 	panel_regulator: panel-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio7 RK_PB6 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_enable_h>;
 		regulator-name = "panel_regulator";
@@ -68,7 +68,7 @@
 	vcc18_lcd: vcc18-lcd {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&avdd_1v8_disp_en>;
 		regulator-name = "vcc18_lcd";
@@ -80,7 +80,7 @@
 	backlight_regulator: backlight-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_pwr_en>;
 		regulator-name = "backlight_regulator";
@@ -126,14 +126,14 @@
 
 &vcc_5v {
 	enable-active-high;
-	gpio = <&gpio7 21 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&drv_5v>;
 };
 
 &vcc50_hdmi {
 	enable-active-high;
-	gpio = <&gpio5 19 GPIO_ACTIVE_HIGH>;
+	gpio = <&gpio5 RK_PC3 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&vcc50_hdmi_en>;
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 2251d28..e2ecd57 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -61,7 +61,7 @@
 		pinctrl-0 = <&pwr_key_l>;
 		power {
 			label = "Power";
-			gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			debounce-interval = <100>;
 			wakeup-source;
@@ -70,7 +70,7 @@
 
 	gpio-restart {
 		compatible = "gpio-restart";
-		gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
+		gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ap_warm_reset_h>;
 		priority = <200>;
@@ -80,7 +80,7 @@
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_HIGH>;
 	};
 
 	sdio_pwrseq: sdio-pwrseq {
@@ -96,7 +96,7 @@
 		 * - SDIO_RESET_L_WL_REG_ON
 		 * - PDN (power down when low)
 		 */
-		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
 	};
 
 	vcc_5v: vcc-5v {
-- 
2.7.4
