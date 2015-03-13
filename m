From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 13 Mar 2015 14:21:42 +0800
Subject: [PATCH v2 1/3] ARM: imx6qdl-sabreauto.dtsi: add max7310 support
In-Reply-To: <1426227704-26294-1-git-send-email-peter.chen@freescale.com>
References: <1426227704-26294-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1426227704-26294-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

max7310 is an i2c interface gpio expander

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 009abd6..46b2fed 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -182,6 +182,34 @@
 	};
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-assert-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	max7310_a: gpio at 30 {
+		compatible = "maxim,max7310";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	max7310_b: gpio at 32 {
+		compatible = "maxim,max7310";
+		reg = <0x32>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	max7310_c: gpio at 34 {
+		compatible = "maxim,max7310";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -265,6 +293,13 @@
 			>;
 		};
 
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_3__I2C3_SCL  0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+			>;
+		};
+
 		pinctrl_pwm3: pwm1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
-- 
1.9.1
