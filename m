From: tharvey@gateworks.com (Tim Harvey)
Date: Mon,  8 Sep 2014 23:07:26 -0700
Subject: [PATCH 1/6] ARM: dts: imx: ventana: remove unsupported dt nodes
In-Reply-To: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
References: <1410242851-30765-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1410242851-30765-2-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The general device-tree rule is to not include nodes that do not have a driver
or bindings in a dts/dtsi. Remove the place-holder nodes from the Gateworks
Ventana boards until a time that a driver with proper bindings exists.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6q-gw5400-a.dts  | 30 -----------
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 57 ---------------------
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 74 ---------------------------
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 96 -----------------------------------
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 35 -------------
 5 files changed, 292 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 22e6f8e..d1ab780 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -199,11 +199,6 @@
 		#gpio-cells = <2>;
 	};
 
-	hwmon: gsc at 29 {
-		compatible = "gw,gsp";
-		reg = <0x29>;
-	};
-
 	rtc: ds1672 at 68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -314,16 +309,6 @@
 			};
 		};
 	};
-
-	pciswitch: pex8609 at 3f {
-		compatible = "plx,pex8609";
-		reg = <0x3f>;
-	};
-
-	pciclkgen: si52147 at 6b {
-		compatible = "sil,si52147";
-		reg = <0x6b>;
-	};
 };
 
 &i2c3 {
@@ -345,11 +330,6 @@
 		VDDIO-supply = <&reg_3p3v>;
 	};
 
-	hdmiin: adv7611 at 4c {
-		compatible = "adi,adv7611";
-		reg = <0x4c>;
-	};
-
 	touchscreen: egalax_ts at 04 {
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
@@ -357,16 +337,6 @@
 		interrupts = <12 2>; /* gpio7_12 active low */
 		wakeup-gpios = <&gpio7 12 0>;
 	};
-
-	videoout: adv7393 at 2a {
-		compatible = "adi,adv7393";
-		reg = <0x2a>;
-	};
-
-	videoin: adv7180 at 20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-	};
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 0db15af..f36492c 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -143,11 +143,6 @@
 		#gpio-cells = <2>;
 	};
 
-	hwmon: gsc at 29 {
-		compatible = "gw,gsp";
-		reg = <0x29>;
-	};
-
 	rtc: ds1672 at 68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -159,53 +154,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
-
-	pmic: ltc3676 at 3c {
-		compatible = "lltc,ltc3676";
-		reg = <0x3c>;
-
-		regulators {
-			sw1_reg: ltc3676__sw1 {
-				regulator-min-microvolt = <1175000>;
-				regulator-max-microvolt = <1175000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw2_reg: ltc3676__sw2 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3_reg: ltc3676__sw3 {
-				regulator-min-microvolt = <1175000>;
-				regulator-max-microvolt = <1175000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw4_reg: ltc3676__sw4 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2_reg: ltc3676__ldo2 {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: ltc3676__ldo4 {
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-			};
-		};
-	};
 };
 
 &i2c3 {
@@ -213,11 +161,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
-
-	videoin: adv7180 at 20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-	};
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 234e7b7..0b65c7d 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -197,11 +197,6 @@
 		#gpio-cells = <2>;
 	};
 
-	hwmon: gsc at 29 {
-		compatible = "gw,gsp";
-		reg = <0x29>;
-	};
-
 	rtc: ds1672 at 68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -213,65 +208,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
-
-	pciswitch: pex8609 at 3f {
-		compatible = "plx,pex8609";
-		reg = <0x3f>;
-	};
-
-	pmic: ltc3676 at 3c {
-		compatible = "lltc,ltc3676";
-		reg = <0x3c>;
-
-		regulators {
-			sw1_reg: ltc3676__sw1 {
-				regulator-min-microvolt = <1175000>;
-				regulator-max-microvolt = <1175000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw2_reg: ltc3676__sw2 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw3_reg: ltc3676__sw3 {
-				regulator-min-microvolt = <1175000>;
-				regulator-max-microvolt = <1175000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			sw4_reg: ltc3676__sw4 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo2_reg: ltc3676__ldo2 {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo3_reg: ltc3676__ldo3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4_reg: ltc3676__ldo4 {
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-			};
-		};
-	};
 };
 
 &i2c3 {
@@ -280,11 +216,6 @@
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
-	accelerometer: fxos8700 at 1e {
-		compatible = "fsl,fxos8700";
-		reg = <0x13>;
-	};
-
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
@@ -300,11 +231,6 @@
 		interrupts = <12 2>; /* gpio7_12 active low */
 		wakeup-gpios = <&gpio7 12 0>;
 	};
-
-	videoin: adv7180 at 20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-	};
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 143f84f..0488cd1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -206,11 +206,6 @@
 		#gpio-cells = <2>;
 	};
 
-	hwmon: gsc at 29 {
-		compatible = "gw,gsp";
-		reg = <0x29>;
-	};
-
 	rtc: ds1672 at 68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -222,77 +217,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
-
-	pciclkgen: si53156 at 6b {
-		compatible = "sil,si53156";
-		reg = <0x6b>;
-	};
-
-	pciswitch: pex8606 at 3f {
-		compatible = "plx,pex8606";
-		reg = <0x3f>;
-	};
-
-	pmic: ltc3676 at 3c {
-		compatible = "lltc,ltc3676";
-		reg = <0x3c>;
-
-		regulators {
-			/* VDD_SOC */
-			sw1_reg: ltc3676__sw1 {
-				regulator-min-microvolt = <1175000>;
-				regulator-max-microvolt = <1175000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* VDD_1P8 */
-			sw2_reg: ltc3676__sw2 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* VDD_ARM */
-			sw3_reg: ltc3676__sw3 {
-				regulator-min-microvolt = <1175000>;
-				regulator-max-microvolt = <1175000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* VDD_DDR */
-			sw4_reg: ltc3676__sw4 {
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* VDD_2P5 */
-			ldo2_reg: ltc3676__ldo2 {
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2500000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* VDD_1P8 */
-			ldo3_reg: ltc3676__ldo3 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			/* VDD_HIGH */
-			ldo4_reg: ltc3676__ldo4 {
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-			};
-		};
-	};
 };
 
 &i2c3 {
@@ -301,11 +225,6 @@
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
-	accelerometer: fxos8700 at 1e {
-		compatible = "fsl,fxos8700";
-		reg = <0x1e>;
-	};
-
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
@@ -314,11 +233,6 @@
 		VDDIO-supply = <&reg_3p3v>;
 	};
 
-	hdmiin: adv7611 at 4c {
-		compatible = "adi,adv7611";
-		reg = <0x4c>;
-	};
-
 	touchscreen: egalax_ts at 04 {
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
@@ -326,16 +240,6 @@
 		interrupts = <11 2>; /* gpio1_11 active low */
 		wakeup-gpios = <&gpio1 11 0>;
 	};
-
-	videoout: adv7393 at 2a {
-		compatible = "adi,adv7393";
-		reg = <0x2a>;
-	};
-
-	videoin: adv7180 at 20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-	};
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 16e7ad3..620e4cf 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -196,11 +196,6 @@
 		#gpio-cells = <2>;
 	};
 
-	hwmon: gsc at 29 {
-		compatible = "gw,gsp";
-		reg = <0x29>;
-	};
-
 	rtc: ds1672 at 68 {
 		compatible = "dallas,ds1672";
 		reg = <0x68>;
@@ -311,16 +306,6 @@
 			};
 		};
 	};
-
-	pciswitch: pex8609 at 3f {
-		compatible = "plx,pex8609";
-		reg = <0x3f>;
-	};
-
-	pciclkgen: si52147 at 6b {
-		compatible = "sil,si52147";
-		reg = <0x6b>;
-	};
 };
 
 &i2c3 {
@@ -329,11 +314,6 @@
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
-	accelerometer: fxos8700 at 1e {
-		compatible = "fsl,fxos8700";
-		reg = <0x1e>;
-	};
-
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
@@ -342,11 +322,6 @@
 		VDDIO-supply = <&reg_3p3v>;
 	};
 
-	hdmiin: adv7611 at 4c {
-		compatible = "adi,adv7611";
-		reg = <0x4c>;
-	};
-
 	touchscreen: egalax_ts at 04 {
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
@@ -354,16 +329,6 @@
 		interrupts = <12 2>; /* gpio7_12 active low */
 		wakeup-gpios = <&gpio7 12 0>;
 	};
-
-	videoout: adv7393 at 2a {
-		compatible = "adi,adv7393";
-		reg = <0x2a>;
-	};
-
-	videoin: adv7180 at 20 {
-		compatible = "adi,adv7180";
-		reg = <0x20>;
-	};
 };
 
 &iomuxc {
-- 
1.8.3.2
