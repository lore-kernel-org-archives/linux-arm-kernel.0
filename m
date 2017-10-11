From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:50:31 +0200
Subject: [PATCH 08/12] ARM: dts: imx6-tx6: add support for I2C bus recovery
In-Reply-To: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
References: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507722635-30801-9-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the required properties to enable I2C bus recovery supported by
the I2C subsystem.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index e0dbf8b..9b563d4 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -310,8 +310,11 @@
 };
 
 &i2c1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio3 28 GPIO_ACTIVE_HIGH>;
 	clock-frequency = <400000>;
 	status = "okay";
 
@@ -324,8 +327,11 @@
 };
 
 &i2c3 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
 	clock-frequency = <400000>;
 	status = "okay";
 
@@ -551,6 +557,13 @@
 		>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1-gpiogrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D21__GPIO3_IO21		0x4001b8b1
+			MX6QDL_PAD_EIM_D28__GPIO3_IO28		0x4001b8b1
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
@@ -558,6 +571,13 @@
 		>;
 	};
 
+	pinctrl_i2c3_gpio: i2c3-gpiogrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__GPIO1_IO03		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06		0x4001b8b1
+		>;
+	};
+
 	pinctrl_kpp: kppgrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_9__KEY_COL6		0x1b0b1
-- 
2.1.4
