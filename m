From: pbrobinson@gmail.com (Peter Robinson)
Date: Fri, 13 Jul 2018 18:11:51 +0100
Subject: [PATCH] ARM: dts: imx6sx-udoo-neo: enable i2c-2 and i2c-4 for onboard
 sensors
Message-ID: <20180713171151.24699-1-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c2 bus has a external plug which enables the easy connection of external
"bricks" with sensors of various kinds, while i2c4 on the Extended/Full boards
has a pair of on board motion sensors, accelerometer and magnetometer on one chip
and gyroscope on another so it makes sense to enable these i2c buses for use.
Tested on UDOO Neo Full.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 .../arm/boot/dts/imx6sx-udoo-neo-extended.dts |  7 +++++++
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts    |  7 +++++++
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi        | 19 +++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
index 42bfc8f8f7f6b..9ef424f48c523 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
@@ -52,3 +52,10 @@
 		reg = <0x80000000 0x40000000>;
 	};
 };
+
+&i2c4 { /* Onboard Motion sensors */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
index c84c877f09d49..a3d3b731ac9ed 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
@@ -67,3 +67,10 @@
 		};
 	};
 };
+
+&i2c4 { /* Onboard Motion sensors */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index 53b3eac94f0de..dad8611cc2851 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -225,6 +225,13 @@
 	};
 };
 
+&i2c2 { /* Brick snap in sensors connector */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_bt_reg: btreggrp {
 		fsl,pins =
@@ -256,6 +263,18 @@
 			<MX6SX_PAD_GPIO1_IO01__I2C1_SDA		0x4001b8b1>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins =
+			<MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1>,
+			<MX6SX_PAD_GPIO1_IO02__I2C2_SCL          0x4001b8b1>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins =
+			<MX6SX_PAD_USB_H_DATA__I2C4_SDA		0x4001b8b1>,
+			<MX6SX_PAD_USB_H_STROBE__I2C4_SCL	0x4001b8b1>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins =
 			<MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1>,
-- 
2.17.1
