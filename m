From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 30 Apr 2014 23:32:30 -0700
Subject: [PATCH 1/2] ARM: dts: imx: add LVDS backlight for Ventana
In-Reply-To: <20140429060106.GG16451@dragon>
References: <20140429060106.GG16451@dragon>
Message-ID: <1398925950-26081-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW54xx/GW53xx/GW52xx all support LVDS with a PWM controlled backlight.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 19 +++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 19 +++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 1022197..62f533a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -27,6 +27,13 @@
 		bootargs = "console=ttymxc1,115200";
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm4 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -399,6 +406,12 @@
 			>;
 		};
 
+		pinctrl_pwm4: pwm4grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
@@ -448,6 +461,12 @@
 	status = "okay";
 };
 
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
 &ssi1 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index ef7bd99..c2284c8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -30,6 +30,13 @@
 		bootargs = "console=ttymxc1,115200";
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm4 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -439,6 +446,12 @@
 			>;
 		};
 
+		pinctrl_pwm4: pwm4grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
@@ -513,6 +526,12 @@
 	};
 };
 
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
 &ssi1 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 4ce8f68..9aa95c8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -30,6 +30,13 @@
 		bootargs = "console=ttymxc1,115200";
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm4 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -461,6 +468,12 @@
 			>;
 		};
 
+		pinctrl_pwm4: pwm4grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
@@ -535,6 +548,12 @@
 	};
 };
 
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
 &ssi1 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
-- 
1.8.3.2
