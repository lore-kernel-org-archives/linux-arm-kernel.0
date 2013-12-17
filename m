From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:12:59 -0700
Subject: [PATCH V2 09/13] ARM: dts: imx6qdl-sabrelite: add pwms for backlights
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-10-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add pwm1 for lcd backlight
add pwm4 for lvds backlight
add pwm3 for ov5640 mipi clock

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v2: no change
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 36ffbb2..723259f 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -104,6 +104,24 @@
 		mux-int-port = <1>;
 		mux-ext-port = <4>;
 	};
+
+	backlight_lcd {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		power-supply = <&reg_3p3v>;
+		status = "okay";
+	};
+
+	backlight_lvds {
+		compatible = "pwm-backlight";
+		pwms = <&pwm4 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		power-supply = <&reg_3p3v>;
+		status = "okay";
+	};
 };
 
 &audmux {
@@ -196,6 +214,24 @@
 			fsl,pins = <MX6QDL_I2C1_PINGRP1>;
 		};
 
+		pinctrl_pwm1: pwm1grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT3__PWM1_OUT 0x1b0b1
+			>;
+		};
+
+		pinctrl_pwm3: pwm3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT1__PWM3_OUT 0x1b0b1
+			>;
+		};
+
+		pinctrl_pwm4: pwm4grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__PWM4_OUT 0x1b0b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <MX6QDL_UART1_PINGRP2>;
 		};
@@ -258,6 +294,24 @@
 	status = "okay";
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
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
1.8.1.2
