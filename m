From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Fri, 15 May 2015 15:44:27 +0200
Subject: [PATCH 1/2] ARM: dts: Armadeus Systems APF6 family support (i.MX6)
Message-ID: <1431697468-19363-1-git-send-email-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to the Armadeus Systems APF6 Solo / Dual / Quad SoM and
the Armadeus Systems APF6Dev carrier board.

For more details see:
http://www.armadeus.com/english/products-processor_boards-apf6.html
http://www.armadeus.com/english/products-development_boards-apf6_dev.html

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/Makefile             |   2 +
 arch/arm/boot/dts/imx6dl-apf6dev.dts   |  60 +++++
 arch/arm/boot/dts/imx6q-apf6dev.dts    |  64 +++++
 arch/arm/boot/dts/imx6qdl-apf6.dtsi    | 158 +++++++++++
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi | 479 +++++++++++++++++++++++++++++++++
 5 files changed, 763 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-apf6dev.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apf6dev.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-apf6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 86217db..d88d8da 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -254,6 +254,7 @@ dtb-$(CONFIG_SOC_IMX53) += \
 	imx53-tx53-x13x.dtb \
 	imx53-voipac-bsb.dtb
 dtb-$(CONFIG_SOC_IMX6Q) += \
+	imx6dl-apf6dev.dtb \
 	imx6dl-aristainetos_4.dtb \
 	imx6dl-aristainetos_7.dtb \
 	imx6dl-cubox-i.dtb \
@@ -277,6 +278,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-udoo.dtb \
 	imx6dl-wandboard.dtb \
 	imx6dl-wandboard-revb1.dtb \
+	imx6q-apf6dev.dtb \
 	imx6q-arm2.dtb \
 	imx6q-cm-fx6.dtb \
 	imx6q-cubox-i.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-apf6dev.dts b/arch/arm/boot/dts/imx6dl-apf6dev.dts
new file mode 100644
index 0000000..df26e54
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-apf6dev.dts
@@ -0,0 +1,60 @@
+/*
+ * Copyright 2015 Armadeus Systems
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6dl.dtsi"
+#include "imx6qdl-apf6.dtsi"
+#include "imx6qdl-apf6dev.dtsi"
+
+/ {
+	model = "Armadeus APF6 Solo Module on APF6Dev Board";
+	compatible = "armadeus,imx6dl-apf6dev", "armadeus,imx6dl-apf6", "fsl,imx6dl";
+
+	memory {
+		reg = <0x10000000 0x20000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-apf6dev.dts b/arch/arm/boot/dts/imx6q-apf6dev.dts
new file mode 100644
index 0000000..4e4de82
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-apf6dev.dts
@@ -0,0 +1,64 @@
+/*
+ * Copyright 2015 Armadeus Systems
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-apf6.dtsi"
+#include "imx6qdl-apf6dev.dtsi"
+
+/ {
+	model = "Armadeus APF6 Quad / Dual Module on APF6Dev Board";
+	compatible = "armadeus,imx6q-apf6dev", "armadeus,imx6q-apf6", "fsl,imx6q";
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+};
+
+&sata {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-apf6.dtsi b/arch/arm/boot/dts/imx6qdl-apf6.dtsi
new file mode 100644
index 0000000..1ebf29f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-apf6.dtsi
@@ -0,0 +1,158 @@
+/*
+ * Copyright 2015 Armadeus Systems
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	phy-reset-duration = <10>;
+	phy-reset-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+/* Bluetooth */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+/* Wi-Fi */
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	non-removable;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore at 2 {
+		compatible = "ti,wl1271";
+		reg = <2>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+		ref-clock-frequency = <38400000>;
+		tcxo-clock-frequency = <38400000>;
+	};
+};
+
+/* eMMC */
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	status = "okay";
+};
+
+&iomuxc {
+	apf6 {
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b8b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+				MX6QDL_PAD_ENET_RX_ER__GPIO1_IO24	0x130b0
+				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x130b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x13030
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x13030
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1f030
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1f030
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x13030
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b0
+				MX6QDL_PAD_SD4_DAT5__UART2_RTS_B	0x1b0b0
+				MX6QDL_PAD_SD4_DAT6__UART2_CTS_B	0x1b0b0
+				MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b0
+				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11		0x130b0 /* BT_EN */
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__SD1_CMD	0x17059
+				MX6QDL_PAD_SD1_CLK__SD1_CLK	0x10059
+				MX6QDL_PAD_SD1_DAT0__SD1_DATA0	0x17059
+				MX6QDL_PAD_SD1_DAT1__SD1_DATA1	0x17059
+				MX6QDL_PAD_SD1_DAT2__SD1_DATA2	0x17059
+				MX6QDL_PAD_SD1_DAT3__SD1_DATA3	0x17059
+				MX6QDL_PAD_SD4_DAT0__GPIO2_IO08	0x1b0b0 /* WL_EN */
+				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10	0x1b0b0 /* WL_IRQ */
+			>;
+		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
+				MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10059
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
+				MX6QDL_PAD_SD3_DAT4__SD3_DATA4	0x17059
+				MX6QDL_PAD_SD3_DAT5__SD3_DATA5	0x17059
+				MX6QDL_PAD_SD3_DAT6__SD3_DATA6	0x17059
+				MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
+			>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
new file mode 100644
index 0000000..e26ebeb
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -0,0 +1,479 @@
+/*
+ * Copyright 2015 Armadeus Systems
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ *     You should have received a copy of the GNU General Public
+ *     License along with this file; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	display at di0 {
+		compatible = "fsl,imx-parallel-display";
+		interface-pix-fmt = "bgr666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_disp1>;
+
+		display-timings {
+			lw700 {
+				clock-frequency = <33000033>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <96>;
+				hfront-porch = <96>;
+				vback-porch = <20>;
+				vfront-porch = <21>;
+				hsync-len = <64>;
+				vsync-len = <4>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+				de-active = <1>;
+				pixelclk-active = <1>;
+			};
+		};
+
+		port {
+			display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		user-button {
+			label = "User button";
+			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_MISC>;
+			gpio-key,wakeup;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		user-led {
+			label = "User LED";
+			gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_usbh1_vbus: usb-h1-vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+
+		reg_usb_otg_vbus: usb-otg-vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx6-armadeus-sgtl5000",
+			     "fsl,imx-audio-sgtl5000";
+		model = "imx6-armadeus-sgtl5000";
+		ssi-controller = <&ssi1>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+		mux-int-port = <1>;
+		mux-ext-port = <3>;
+	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		spdif-controller = <&spdif>;
+		spdif-out;
+	};
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	status = "okay";
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	fsl,spi-num-chipselects = <3>;
+	cs-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>,
+		   <&gpio4 10 GPIO_ACTIVE_LOW>,
+		   <&gpio4 11 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c3>;
+	status = "okay";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	touchscreen at 48 {
+		compatible = "semtech,sx8654";
+		reg = <0x48>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touchscreen>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	codec: sgtl5000 at 0a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+		clocks = <&clks 201>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&display_in>;
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio6 2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+	status = "okay";
+};
+
+/* GPS */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* GSM */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3 &pinctrl_gsm>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+/* console */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usbh1_vbus>;
+	phy_type = "utmi";
+	status = "okay";
+};
+
+&usbotg {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	vbus-supply = <&reg_usb_otg_vbus>;
+	dr_mode = "otg";
+	status = "okay";
+};
+
+/* microSD */
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	cd-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif>;
+	status = "okay";
+};
+
+&ssi1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpios>;
+
+	apf6dev {
+		pinctrl_audmux: audmuxgrp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x1b0b0
+				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x1b0b0
+				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x1b0b0
+				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x1b0b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
+			>;
+		};
+
+		pinctrl_ecspi1: ecspi1grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL1__ECSPI1_MISO 0x100b1
+				MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI 0x100b1
+				MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK 0x100b1
+				MX6QDL_PAD_KEY_ROW1__GPIO4_IO09  0x1b0b0
+				MX6QDL_PAD_KEY_ROW2__GPIO4_IO11  0x1b0b0
+				MX6QDL_PAD_KEY_COL2__GPIO4_IO10  0x1b0b0
+			>;
+		};
+
+		pinctrl_flexcan2: flexcan2grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b0b0
+				MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b0b0
+			>;
+		};
+
+		pinctrl_gpio_keys: gpiokeysgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09 0x1b0b0
+			>;
+		};
+
+		pinctrl_gpio_leds: gpioledsgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x130b0
+			>;
+		};
+
+		pinctrl_gpios: gpiosgrp {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_PIN4__GPIO4_IO20		0x100b1
+				MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12	0x100b1
+				MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13 	0x100b1
+				MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14 	0x100b1
+				MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15 	0x100b1
+				MX6QDL_PAD_DISP0_DAT22__GPIO5_IO16 	0x100b1
+				MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17 	0x100b1
+				MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18 	0x100b1
+				MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21  	0x100b1
+			>;
+		};
+
+		pinctrl_gsm: gsmgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x130b0 /* GSM_POKIN */
+				MX6QDL_PAD_GPIO_18__GPIO7_IO13 0x130b0 /* GSM_PWR_EN */
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
+				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b8b1
+				MX6QDL_PAD_GPIO_5__I2C3_SCL 0x4001b8b1
+			>;
+		};
+
+		pinctrl_ipu1_disp1: ipu1disp1grp {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x100b1
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x100b1
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x100b1
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x100b1
+				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x100b1
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x100b1
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x100b1
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x100b1
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x100b1
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x100b1
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x100b1
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x100b1
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x100b1
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x100b1
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x100b1
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x100b1
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x100b1
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x100b1
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x100b1
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x100b1
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x100b1
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x100b1
+			>;
+		};
+
+		pinctrl_pcie: pciegrp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02 0x130b0
+			>;
+		};
+
+		pinctrl_pwm3: pwm3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b0
+				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b0
+			>;
+		};
+
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D23__UART3_CTS_B   0x1b0b0
+				MX6QDL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b0
+				MX6QDL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b0
+				MX6QDL_PAD_EIM_D31__UART3_RTS_B   0x1b0b0
+			>;
+		};
+
+		pinctrl_uart4: uart4grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b0
+				MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b0
+			>;
+		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x1b0b0
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
+			>;
+		};
+
+		pinctrl_spdif: spdifgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_19__SPDIF_OUT 0x1b0b0
+			>;
+		};
+
+		pinctrl_touchscreen: touchscreengrp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03 0x1b0b0
+			>;
+		};
+	};
+};
-- 
2.0.5
