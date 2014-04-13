From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 Apr 2014 09:19:11 +0400
Subject: [PATCH 08/10] ARM: dts: imx51-babbage: Sort nodes by name
In-Reply-To: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
References: <1397366353-29395-1-git-send-email-shc_work@mail.ru>
Message-ID: <1397366353-29395-8-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sorts nodes by name and moves "iomux" configuration at
the end of file.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-babbage.dts | 274 ++++++++++++++++++------------------
 1 file changed, 137 insertions(+), 137 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index bd375fe..ff7d2fa 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -21,6 +21,22 @@
 		reg = <0x90000000 0x20000000>;
 	};
 
+	clocks {
+		ckih1 {
+			clock-frequency = <22579200>;
+		};
+
+		clk_26M: codec_clock {
+			compatible = "fixed-clock";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_clkcodec>;
+			reg=<0>;
+			#clock-cells = <0>;
+			clock-frequency = <26000000>;
+			gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	display0: display at di0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "rgb24";
@@ -104,36 +120,6 @@
 		};
 	};
 
-	sound {
-		compatible = "fsl,imx51-babbage-sgtl5000",
-			     "fsl,imx-audio-sgtl5000";
-		model = "imx51-babbage-sgtl5000";
-		ssi-controller = <&ssi2>;
-		audio-codec = <&sgtl5000>;
-		audio-routing =
-			"MIC_IN", "Mic Jack",
-			"Mic Jack", "Mic Bias",
-			"Headphone Jack", "HP_OUT";
-		mux-int-port = <2>;
-		mux-ext-port = <3>;
-	};
-
-	clocks {
-		ckih1 {
-			clock-frequency = <22579200>;
-		};
-
-		clk_26M: codec_clock {
-			compatible = "fixed-clock";
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_clkcodec>;
-			reg=<0>;
-			#clock-cells = <0>;
-			clock-frequency = <26000000>;
-			gpios = <&gpio4 26 GPIO_ACTIVE_LOW>;
-		};
-	};
-
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -164,6 +150,20 @@
 		};
 	};
 
+	sound {
+		compatible = "fsl,imx51-babbage-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx51-babbage-sgtl5000";
+		ssi-controller = <&ssi2>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <2>;
+		mux-ext-port = <3>;
+	};
+
 	usbphy {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -178,29 +178,6 @@
 	};
 };
 
-&esdhc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc1>;
-	fsl,cd-controller;
-	fsl,wp-controller;
-	status = "okay";
-};
-
-&esdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_esdhc2>;
-	cd-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
-	wp-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
-	status = "okay";
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart3>;
-	fsl,uart-has-rtscts;
-	status = "okay";
-};
-
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
@@ -329,6 +306,51 @@
 	};
 };
 
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	fsl,cd-controller;
+	fsl,wp-controller;
+	status = "okay";
+};
+
+&esdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc2>;
+	cd-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+	wp-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+	phy-mode = "mii";
+	phy-reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <1>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	sgtl5000: codec at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clk_26M>;
+		VDDA-supply = <&vdig_reg>;
+		VDDIO-supply = <&vvideo_reg>;
+	};
+};
+
 &ipu_di0_disp0 {
 	remote-endpoint = <&display0_in>;
 };
@@ -337,11 +359,72 @@
 	remote-endpoint = <&display1_in>;
 };
 
+&kpp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_kpp>;
+	linux,keymap = <
+		MATRIX_KEY(0, 0, KEY_UP)
+		MATRIX_KEY(0, 1, KEY_DOWN)
+		MATRIX_KEY(0, 2, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0, 3, KEY_HOME)
+		MATRIX_KEY(1, 0, KEY_RIGHT)
+		MATRIX_KEY(1, 1, KEY_LEFT)
+		MATRIX_KEY(1, 2, KEY_ENTER)
+		MATRIX_KEY(1, 3, KEY_VOLUMEUP)
+		MATRIX_KEY(2, 0, KEY_F6)
+		MATRIX_KEY(2, 1, KEY_F8)
+		MATRIX_KEY(2, 2, KEY_F9)
+		MATRIX_KEY(2, 3, KEY_F10)
+		MATRIX_KEY(3, 0, KEY_F1)
+		MATRIX_KEY(3, 1, KEY_F2)
+		MATRIX_KEY(3, 2, KEY_F3)
+		MATRIX_KEY(3, 3, KEY_POWER)
+	>;
+	status = "okay";
+};
+
 &ssi2 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&usbh1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	vbus-supply = <&reg_usbh1_vbus>;
+	fsl,usbphy = <&usbh1phy>;
+	phy_type = "ulpi";
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "otg";
+	disable-over-current;
+	phy_type = "utmi_wide";
+	vbus-supply = <&reg_usbotg_vbus>;
+	status = "okay";
+};
+
 &iomuxc {
 	imx51-babbage {
 		pinctrl_audmux: audmuxgrp {
@@ -414,7 +497,7 @@
 				MX51_PAD_NANDF_CS6__FEC_TDATA3		0x80000000
 				MX51_PAD_NANDF_CS7__FEC_TX_EN		0x80000000
 				MX51_PAD_NANDF_RDY_INT__FEC_TX_CLK	0x80000000
-				MX51_PAD_EIM_A20__GPIO2_14 0x85 /* Reset */
+				MX51_PAD_EIM_A20__GPIO2_14		0x85 /* Reset */
 			>;
 		};
 
@@ -566,86 +649,3 @@
 		};
 	};
 };
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-	fsl,uart-has-rtscts;
-	status = "okay";
-};
-
-&uart2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart2>;
-	status = "okay";
-};
-
-&i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
-	sgtl5000: codec at 0a {
-		compatible = "fsl,sgtl5000";
-		reg = <0x0a>;
-		clocks = <&clk_26M>;
-		VDDA-supply = <&vdig_reg>;
-		VDDIO-supply = <&vvideo_reg>;
-	};
-};
-
-&audmux {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_audmux>;
-	status = "okay";
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fec>;
-	phy-mode = "mii";
-	phy-reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
-	phy-reset-duration = <1>;
-	status = "okay";
-};
-
-&kpp {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_kpp>;
-	linux,keymap = <
-		MATRIX_KEY(0, 0, KEY_UP)
-		MATRIX_KEY(0, 1, KEY_DOWN)
-		MATRIX_KEY(0, 2, KEY_VOLUMEDOWN)
-		MATRIX_KEY(0, 3, KEY_HOME)
-		MATRIX_KEY(1, 0, KEY_RIGHT)
-		MATRIX_KEY(1, 1, KEY_LEFT)
-		MATRIX_KEY(1, 2, KEY_ENTER)
-		MATRIX_KEY(1, 3, KEY_VOLUMEUP)
-		MATRIX_KEY(2, 0, KEY_F6)
-		MATRIX_KEY(2, 1, KEY_F8)
-		MATRIX_KEY(2, 2, KEY_F9)
-		MATRIX_KEY(2, 3, KEY_F10)
-		MATRIX_KEY(3, 0, KEY_F1)
-		MATRIX_KEY(3, 1, KEY_F2)
-		MATRIX_KEY(3, 2, KEY_F3)
-		MATRIX_KEY(3, 3, KEY_POWER)
-		>;
-	status = "okay";
-};
-
-&usbh1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbh1>;
-	vbus-supply = <&reg_usbh1_vbus>;
-	fsl,usbphy = <&usbh1phy>;
-	phy_type = "ulpi";
-	status = "okay";
-};
-
-&usbotg {
-	dr_mode = "otg";
-	disable-over-current;
-	phy_type = "utmi_wide";
-	vbus-supply = <&reg_usbotg_vbus>;
-	status = "okay";
-};
-- 
1.8.3.2
