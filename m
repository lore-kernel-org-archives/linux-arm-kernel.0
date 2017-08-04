From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 4 Aug 2017 11:59:35 +0800
Subject: [PATCH v4 2/2] arm: dts: mt7623: cleanup binding file
In-Reply-To: <1c83eae1944992f7c5a9af946e03bc2c4e62c874.1501819056.git.sean.wang@mediatek.com>
References: <1c83eae1944992f7c5a9af946e03bc2c4e62c874.1501819056.git.sean.wang@mediatek.com>
Message-ID: <4fb39cfab230da6b8bee44b5be984ff0fbfb38c5.1501819056.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

Dummy patch to sort nodes alphabetically and add some blank lines
for consistency.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi                 | 73 ++++++++++++++-------------
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 57 ++++++++++++---------
 arch/arm/boot/dts/mt7623n-rfb-nand.dts        | 64 +++++++++++------------
 arch/arm/boot/dts/mt7623n-rfb.dtsi            | 32 ++++++------
 4 files changed, 120 insertions(+), 106 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 2a877ed..ec8a074 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -91,6 +91,7 @@
 			cooling-max-level = <7>;
 			clock-frequency = <1300000000>;
 		};
+
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
@@ -98,6 +99,7 @@
 			operating-points-v2 = <&cpu_opp_table>;
 			clock-frequency = <1300000000>;
 		};
+
 		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
@@ -105,6 +107,7 @@
 			operating-points-v2 = <&cpu_opp_table>;
 			clock-frequency = <1300000000>;
 		};
+
 		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
@@ -172,10 +175,12 @@
 					trip = <&cpu_passive>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+
 				map1 {
 					trip = <&cpu_active>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
+
 				map2 {
 					trip = <&cpu_hot>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
@@ -481,6 +486,31 @@
 		nvmem-cell-names = "calibration-data";
 	};
 
+	nandc: nfi at 1100d000 {
+		compatible = "mediatek,mt7623-nfc",
+			     "mediatek,mt2701-nfc";
+		reg = <0 0x1100d000 0 0x1000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
+		clocks = <&pericfg CLK_PERI_NFI>,
+			 <&pericfg CLK_PERI_NFI_PAD>;
+		clock-names = "nfi_clk", "pad_clk";
+		status = "disabled";
+		ecc-engine = <&bch>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	bch: ecc at 1100e000 {
+		compatible = "mediatek,mt7623-ecc",
+			     "mediatek,mt2701-ecc";
+		reg = <0 0x1100e000 0 0x1000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_NFI_ECC>;
+		clock-names = "nfiecc_clk";
+		status = "disabled";
+	};
+
 	spi1: spi at 11016000 {
 		compatible = "mediatek,mt7623-spi",
 			     "mediatek,mt2701-spi";
@@ -509,31 +539,6 @@
 		status = "disabled";
 	};
 
-	nandc: nfi at 1100d000 {
-		compatible = "mediatek,mt7623-nfc",
-			     "mediatek,mt2701-nfc";
-		reg = <0 0x1100d000 0 0x1000>;
-		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_LOW>;
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
-		clocks = <&pericfg CLK_PERI_NFI>,
-			 <&pericfg CLK_PERI_NFI_PAD>;
-		clock-names = "nfi_clk", "pad_clk";
-		status = "disabled";
-		ecc-engine = <&bch>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	bch: ecc at 1100e000 {
-		compatible = "mediatek,mt7623-ecc",
-			     "mediatek,mt2701-ecc";
-		reg = <0 0x1100e000 0 0x1000>;
-		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&pericfg CLK_PERI_NFI_ECC>;
-		clock-names = "nfiecc_clk";
-		status = "disabled";
-	};
-
 	afe: audio-controller at 11220000 {
 		compatible = "mediatek,mt7623-audio",
 			     "mediatek,mt2701-audio";
@@ -655,6 +660,15 @@
 		status = "disabled";
 	};
 
+	hifsys: syscon at 1a000000 {
+		compatible = "mediatek,mt7623-hifsys",
+			     "mediatek,mt2701-hifsys",
+			     "syscon";
+		reg = <0 0x1a000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
 	usb1: usb at 1a1c0000 {
 		compatible = "mediatek,mt7623-xhci",
 			     "mediatek,mt8173-xhci";
@@ -733,15 +747,6 @@
 		};
 	};
 
-	hifsys: syscon at 1a000000 {
-		compatible = "mediatek,mt7623-hifsys",
-			     "mediatek,mt2701-hifsys",
-			     "syscon";
-		reg = <0 0x1a000000 0 0x1000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
 	ethsys: syscon at 1b000000 {
 		compatible = "mediatek,mt7623-ethsys",
 			     "mediatek,mt2701-ethsys",
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 444ed93..688a863 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -62,9 +62,9 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins_a>;
 
-		red {
-			label = "bpi-r2:pio:red";
-			gpios = <&pio 239 GPIO_ACTIVE_HIGH>;
+		blue {
+			label = "bpi-r2:pio:blue";
+			gpios = <&pio 241 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
@@ -74,9 +74,9 @@
 			default-state = "off";
 		};
 
-		blue {
-			label = "bpi-r2:pio:blue";
-			gpios = <&pio 241 GPIO_ACTIVE_HIGH>;
+		red {
+			label = "bpi-r2:pio:red";
+			gpios = <&pio 239 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 	};
@@ -98,10 +98,12 @@
 
 &eth {
 	status = "okay";
+
 	gmac0: mac at 0 {
 		compatible = "mediatek,eth-mac";
 		reg = <0>;
 		phy-mode = "trgmii";
+
 		fixed-link {
 			speed = <1000>;
 			full-duplex;
@@ -112,12 +114,12 @@
 	mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+
 		switch at 0 {
 			compatible = "mediatek,mt7530";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
-
 			pinctrl-names = "default";
 			reset-gpios = <&pio 33 0>;
 			core-supply = <&mt6323_vpa_reg>;
@@ -127,6 +129,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0>;
+
 				port at 0 {
 					reg = <0>;
 					label = "wan";
@@ -157,6 +160,7 @@
 					label = "cpu";
 					ethernet = <&gmac0>;
 					phy-mode = "trgmii";
+
 					fixed-link {
 						speed = <1000>;
 						full-duplex;
@@ -372,16 +376,6 @@
 		};
 	};
 
-	spi0_pins_a: spi at 0 {
-		pins_spi {
-			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
-				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
-				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
-				<MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO>;
-			bias-disable;
-		};
-	};
-
 	pwm_pins_a: pwm at 0 {
 		pins_pwm {
 			pinmux = <MT7623_PIN_203_PWM0_FUNC_PWM0>,
@@ -392,6 +386,16 @@
 		};
 	};
 
+	spi0_pins_a: spi at 0 {
+		pins_spi {
+			pinmux = <MT7623_PIN_53_SPI0_CSN_FUNC_SPI0_CS>,
+				<MT7623_PIN_54_SPI0_CK_FUNC_SPI0_CK>,
+				<MT7623_PIN_55_SPI0_MI_FUNC_SPI0_MI>,
+				<MT7623_PIN_56_SPI0_MO_FUNC_SPI0_MO>;
+			bias-disable;
+		};
+	};
+
 	uart0_pins_a: uart at 0 {
 		pins_dat {
 			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
@@ -425,11 +429,13 @@
 				label = "bpi-r2:isink:green";
 				default-state = "off";
 			};
+
 			led at 1 {
 				reg = <1>;
 				label = "bpi-r2:isink:red";
 				default-state = "off";
 			};
+
 			led at 2 {
 				reg = <2>;
 				label = "bpi-r2:isink:blue";
@@ -451,14 +457,6 @@
 	status = "disabled";
 };
 
-&u3phy1 {
-	status = "okay";
-};
-
-&u3phy2 {
-	status = "okay";
-};
-
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins_a>;
@@ -478,3 +476,12 @@
 	vusb33-supply = <&mt6323_vusb_reg>;
 	status = "okay";
 };
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/mt7623n-rfb-nand.dts b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
index 63ffb78..17c578f 100644
--- a/arch/arm/boot/dts/mt7623n-rfb-nand.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-nand.dts
@@ -20,47 +20,22 @@
 	compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
 };
 
-&pio {
-	nand_pins_default: nanddefault {
-		pins_dat {
-			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_NLD7>,
-				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_NLD6>,
-				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_NLD4>,
-				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_NLD3>,
-				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_NLD0>,
-				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_NLD1>,
-				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_NLD5>,
-				 <MT7623_PIN_115_MSDC0_RSTB_FUNC_NLD8>,
-				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_NLD2>;
-			input-enable;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-up;
-		};
-
-		pins_we {
-			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_NWEB>;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
-		};
-
-		pins_ale {
-			pinmux = <MT7623_PIN_116_MSDC0_CMD_FUNC_NALE>;
-			drive-strength = <MTK_DRIVE_8mA>;
-			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
-		};
-	};
+&bch {
+	status = "okay";
 };
 
 &nandc {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_pins_default>;
+
 	nand at 0 {
 		reg = <0>;
 		spare_per_sector = <64>;
 		nand-ecc-mode = "hw";
 		nand-ecc-strength = <12>;
 		nand-ecc-step-size = <1024>;
+
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
@@ -104,6 +79,33 @@
 	};
 };
 
-&bch {
-	status = "okay";
+&pio {
+	nand_pins_default: nanddefault {
+		pins_ale {
+			pinmux = <MT7623_PIN_116_MSDC0_CMD_FUNC_NALE>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_dat {
+			pinmux = <MT7623_PIN_111_MSDC0_DAT7_FUNC_NLD7>,
+				 <MT7623_PIN_112_MSDC0_DAT6_FUNC_NLD6>,
+				 <MT7623_PIN_114_MSDC0_DAT4_FUNC_NLD4>,
+				 <MT7623_PIN_118_MSDC0_DAT3_FUNC_NLD3>,
+				 <MT7623_PIN_121_MSDC0_DAT0_FUNC_NLD0>,
+				 <MT7623_PIN_120_MSDC0_DAT1_FUNC_NLD1>,
+				 <MT7623_PIN_113_MSDC0_DAT5_FUNC_NLD5>,
+				 <MT7623_PIN_115_MSDC0_RSTB_FUNC_NLD8>,
+				 <MT7623_PIN_119_MSDC0_DAT2_FUNC_NLD2>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+
+		pins_we {
+			pinmux = <MT7623_PIN_117_MSDC0_CLK_FUNC_NWEB>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index 1e95790..256c5fd 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -18,6 +18,12 @@
 #include "mt6323.dtsi"
 
 / {
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
@@ -44,12 +50,6 @@
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-	};
-
 	usb_p1_vbus: regulator at 0 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_vbus";
@@ -60,6 +60,16 @@
 	};
 };
 
+&mmc0 {
+	vmmc-supply = <&mt6323_vemc3v3_reg>;
+	vqmmc-supply = <&mt6323_vio18_reg>;
+};
+
+&mmc1 {
+	vmmc-supply = <&mt6323_vmch_reg>;
+	vqmmc-supply = <&mt6323_vmc_reg>;
+};
+
 &uart0 {
 	status = "okay";
 };
@@ -72,16 +82,6 @@
 	status = "okay";
 };
 
-&mmc0 {
-	vmmc-supply = <&mt6323_vemc3v3_reg>;
-	vqmmc-supply = <&mt6323_vio18_reg>;
-};
-
-&mmc1 {
-	vmmc-supply = <&mt6323_vmch_reg>;
-	vqmmc-supply = <&mt6323_vmc_reg>;
-};
-
 &usb1 {
 	vbus-supply = <&usb_p1_vbus>;
 	status = "okay";
-- 
2.7.4
