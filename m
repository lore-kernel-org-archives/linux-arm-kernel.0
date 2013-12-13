From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 12 Dec 2013 18:49:11 -0700
Subject: [PATCH V1 07/11] ARM: dts: imx6qdl-sabrelite: add pwms for backlights
In-Reply-To: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1386899355-17379-8-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add pwm1 for lcd backlight
add pwm4 for lvds backlight
add pwm3 for ov5640 mipi clock

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index fa10ded..ac33d94 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -103,6 +103,24 @@
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
@@ -187,6 +205,24 @@
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
@@ -234,6 +270,24 @@
 	};
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
