From: andy.yan@rock-chips.com (Andy Yan)
Date: Sat, 22 Oct 2016 20:59:04 +0800
Subject: [PATCH 2/2] ARM64: dts: rockchip: use pin constants to describe gpios
In-Reply-To: <1477140706-6886-1-git-send-email-andy.yan@rock-chips.com>
References: <1477140706-6886-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1477141144-6989-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use macros to describe gpios will make the dts easier to
read and write.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi           | 10 +++++-----
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts        |  8 ++++----
 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts | 14 +++++++-------
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts        |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts            | 16 ++++++++--------
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts            |  6 +++---
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index fff8b19..4772917 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -90,7 +90,7 @@
 			240 241 242 243 244 245 246 247
 			248 249 250 251 252 253 254 255>;
 		default-brightness-level = <128>;
-		enable-gpios = <&gpio0 20 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bl_en>;
 		pwms = <&pwm0 0 1000000 PWM_POLARITY_INVERTED>;
@@ -101,7 +101,7 @@
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
 	};
 
 	keys: gpio-keys {
@@ -111,7 +111,7 @@
 
 		power {
 			wakeup-source;
-			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
 		};
@@ -121,7 +121,7 @@
 	vcc_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "vcc_host";
@@ -166,7 +166,7 @@
 	phy-supply = <&vcc_lan>;
 	phy-mode = "rmii";
 	clock_in_out = "output";
-	snps,reset-gpio = <&gpio3 12 0>;
+	snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
index e5eeca2..e5b92d2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
@@ -66,7 +66,7 @@
 
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio3 RK_PD6 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ir_int>;
 	};
@@ -77,7 +77,7 @@
 		pinctrl-0 = <&pwr_key>;
 
 		power {
-			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
 			wakeup-source;
@@ -88,13 +88,13 @@
 		compatible = "gpio-leds";
 
 		blue {
-			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
 			label = "geekbox:blue:led";
 			default-state = "on";
 		};
 
 		red {
-			gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
 			label = "geekbox:red:led";
 			default-state = "off";
 		};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
index ea0a8ec..2e431f13 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
@@ -61,7 +61,7 @@
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
 	};
 
 	ext_gmac: external-gmac-clock {
@@ -78,7 +78,7 @@
 
 		power {
 			wakeup-source;
-			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
 		};
@@ -88,7 +88,7 @@
 		compatible = "gpio-leds";
 
 		red {
-			gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
 			label = "orion:red:led";
 			pinctrl-names = "default";
 			pinctrl-0 = <&led_ctl>;
@@ -96,7 +96,7 @@
 		};
 
 		blue {
-			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
 			label = "orion:blue:led";
 			pinctrl-names = "default";
 			pinctrl-0 = <&stby_pwren>;
@@ -117,7 +117,7 @@
 	/* supplies both host and otg */
 	vcc_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
-		gpio = <&gpio0 4 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "vcc_host";
@@ -149,7 +149,7 @@
 	vcc_sd: vcc-sd-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sd";
-		gpio = <&gpio3 11 GPIO_ACTIVE_LOW>;
+		gpio = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>;
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_io>;
@@ -217,7 +217,7 @@
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
-	snps,reset-gpio = <&gpio3 12 0>;
+	snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
 	tx_delay = <0x30>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
index 85f7a24..62919c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
@@ -63,7 +63,7 @@
 		pinctrl-0 = <&pwr_key>;
 
 		power {
-			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
 			wakeup-source;
@@ -248,7 +248,7 @@
 		reg = <0x40>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
-		power-gpios = <&gpio3 15 GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
 		touchscreen-size-x = <800>;
 		touchscreen-size-y = <1280>;
 		silead,max-fingers = <5>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index eed1ef6..7134181 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -61,7 +61,7 @@
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio2 3 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
 	};
 
 	keys: gpio-keys {
@@ -71,7 +71,7 @@
 
 		power {
 			wakeup-source;
-			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
 		};
@@ -81,7 +81,7 @@
 		compatible = "gpio-leds";
 
 		work {
-			gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
 			label = "r88:green:led";
 			pinctrl-names = "default";
 			pinctrl-0 = <&led_ctl>;
@@ -90,7 +90,7 @@
 
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
-		gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
+		gpios = <&gpio3 RK_PD6 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&ir_int>;
 	};
@@ -104,10 +104,10 @@
 
 		reset-gpios =
 			/* BT_RST_N */
-			<&gpio3 5 GPIO_ACTIVE_LOW>,
+			<&gpio3 RK_PA5 GPIO_ACTIVE_LOW>,
 
 			/* WL_REG_ON */
-			<&gpio3 4 GPIO_ACTIVE_LOW>;
+			<&gpio3 RK_PA4 GPIO_ACTIVE_LOW>;
 	};
 
 	vcc_18: vcc18-regulator {
@@ -124,7 +124,7 @@
 	vcc_host: vcc-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&host_vbus_drv>;
 		regulator-name = "vcc_host";
@@ -199,7 +199,7 @@
 	phy-supply = <&vcc_lan>;
 	phy-mode = "rmii";
 	clock_in_out = "output";
-	snps,reset-gpio = <&gpio3 12 0>;
+	snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 1000000>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
index 8e82497..f00e0d5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-evb.dts
@@ -88,7 +88,7 @@
 	vcc5v0_host: vcc5v0-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&vcc5v0_host_en>;
 		regulator-name = "vcc5v0_host";
@@ -123,7 +123,7 @@
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
-	snps,reset-gpio = <&gpio3 15 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x28>;
@@ -156,7 +156,7 @@
 };
 
 &pcie0 {
-	ep-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	ep-gpios = <&gpio3 RK_PB5 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_clkreqn>;
-- 
2.7.4
