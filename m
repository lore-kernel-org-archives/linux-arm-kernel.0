From: marex@denx.de (Marek Vasut)
Date: Sun, 27 May 2012 04:12:15 +0200
Subject: [PATCH] MXS: Add DENX M28 dts file
Message-ID: <1338084735-12083-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missing:
AUART
LCDIF

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
CC: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/boot/dts/imx28-m28.dts |  260 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 260 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-m28.dts

diff --git a/arch/arm/boot/dts/imx28-m28.dts b/arch/arm/boot/dts/imx28-m28.dts
new file mode 100644
index 0000000..7892020
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-m28.dts
@@ -0,0 +1,260 @@
+/*
+ * Copyright (C) 2012 Marek Vasut <marex@denx.de>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx28.dtsi"
+
+/ {
+	model = "DENX M28EVK";
+	compatible = "fsl,imx28-evk", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			pinctrl at 80018000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx28-pinctrl", "simple-bus";
+				reg = <0x80018000 2000>;
+
+				gpmi_pins_data_m28: gpmi1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x0000 0x0010 0x0020
+							  0x0030 0x0040 0x0050
+							  0x0060 0x0070 0x0100
+							  0x0140>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <0>;
+					fsl,pull-up = <0>;
+				};
+
+				gpmi_pins_ctrl_m28: gpmi1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x180 0x0190
+							  0x01a0 0x01b0>;
+					fsl,drive-strength = <3>;
+					fsl,voltage = <0>;
+					fsl,pull-up = <1>;
+				};
+
+				mmc0_pins_data_m28: mmc0-8bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x2000 0x2010 0x2020
+							  0x2030 0x2040 0x2050
+							  0x2060 0x2070 0x2080>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				mmc0_pins_ctrl_m28: mmc0-8bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x2090 0x20a0
+							  0x30a3 0x31c3>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				auart0_pins_m28: auart0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x3000 0x3010>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				auart3_pins_m28: auart3 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x30c0 0x30d0
+							  0x30e0 0x30f0>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				mac_pin_reset: mac at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x30b3>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				flexcan0_pins_m28: flexcan0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x0161 0x0162>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				flexcan1_pins_m28: flexcan1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x0121 0x0122>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
+
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_pins_data_m28
+					     &mmc0_pins_ctrl_m28>;
+				bus-width = <8>;
+				wp-gpios = <&gpio3 10 1>;
+				status = "okay";
+			};
+
+			gpmi at 8000c000 {
+				compatible = "fsl,imx28-gpmi-nand";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x8000c000 2000>, <0x8000a000 2000>;
+				reg-names = "gpmi-nand", "bch";
+				pinctrl-names = "default";
+				pinctrl-0 = <&gpmi_pins_data_m28
+					     &gpmi_pins_ctrl_m28>;
+				interrupts = <88>, <41>;
+				interrupt-names = "gpmi-dma", "bch";
+				fsl,gpmi-dma-channel = <4>;
+				status = "okay";
+
+				partition at 0 {
+					label = "bootloader";
+					reg = <0x00000000 0x00300000>;
+					read-only;
+				};
+
+				partition at 1 {
+					label = "environment";
+					reg = <0x00300000 0x00080000>;
+				};
+
+				partition at 2 {
+					label = "redundant-environment";
+					reg = <0x00380000 0x00080000>;
+				};
+
+				partition at 3 {
+					label = "kernel";
+					reg = <0x00400000 0x00400000>;
+				};
+
+				partition at 4 {
+					label = "filesystem";
+					reg = <0x00800000 0x0f800000>;
+				};
+			};
+
+			can0: can at 80032000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&flexcan0_pins_m28>;
+				status = "okay";
+			};
+
+			can1: can at 80034000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&flexcan1_pins_m28>;
+				status = "okay";
+			};
+		};
+
+		apbx at 80040000 {
+			saif0: saif at 80042000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&saif0_pins_a>;
+				status = "okay";
+			};
+
+			saif1: saif at 80046000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&saif1_pins_a>;
+				fsl,saif-master = <&saif0>;
+				status = "okay";
+			};
+
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+
+				sgtl5000: codec at 0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+					VDDA-supply = <&reg_3p3v>;
+					VDDIO-supply = <&reg_3p3v>;
+
+				};
+
+				eeprom: eeprom at 51 {
+					compatible = "atmel,24c128";
+					reg = <0x51>;
+					pagesize = <32>;
+				};
+
+				rtc: rtc at 68 {
+					compatible = "stm,mt41t62";
+					reg = <0x68>;
+				};
+			};
+
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a &mac_pin_reset>;
+			phy-reset-gpios = <&gpio3 11 0>;
+			status = "okay";
+		};
+
+		mac1: ethernet at 800f4000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac1_pins_a>;
+			phy-reset-gpios = <&gpio3 11 0>;
+			status = "okay";
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
+	};
+
+	sound {
+		compatible = "fsl,imx28-evk-sgtl5000",
+			     "fsl,mxs-audio-sgtl5000";
+		model = "imx28-evk-sgtl5000";
+		saif-controllers = <&saif0 &saif1>;
+		audio-codec = <&sgtl5000>;
+	};
+};
-- 
1.7.10
