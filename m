From: aford173@gmail.com (Adam Ford)
Date: Thu, 26 Apr 2018 21:35:49 -0500
Subject: [RFC] ARM: DTS: da850-evm: Refactor device tree layout
Message-ID: <20180427023549.13678-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many of the items in the device tree are already defined or partially
defined, so let's remove the redundancies and reduce the whitespace.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index a56d43d53ba1..5bffbe74b6e4 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -27,146 +27,6 @@
 		spi0 = &spi1;
 	};
 
-	soc at 1c00000 {
-		pmx_core: pinmux at 14120 {
-			status = "okay";
-
-			mcasp0_pins: pinmux_mcasp0_pins {
-				pinctrl-single,bits = <
-					/*
-					 * AHCLKX, ACLKX, AFSX, AHCLKR, ACLKR,
-					 * AFSR, AMUTE
-					 */
-					0x00 0x11111111 0xffffffff
-					/* AXR11, AXR12 */
-					0x04 0x00011000 0x000ff000
-				>;
-			};
-			nand_pins: nand_pins {
-				pinctrl-single,bits = <
-					/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
-					0x1c 0x10110110  0xf0ff0ff0
-					/*
-					 * EMA_D[0], EMA_D[1], EMA_D[2],
-					 * EMA_D[3], EMA_D[4], EMA_D[5],
-					 * EMA_D[6], EMA_D[7]
-					 */
-					0x24 0x11111111  0xffffffff
-					/* EMA_A[1], EMA_A[2] */
-					0x30 0x01100000  0x0ff00000
-				>;
-			};
-		};
-		serial0: serial at 42000 {
-			status = "okay";
-		};
-		serial1: serial at 10c000 {
-			status = "okay";
-		};
-		serial2: serial at 10d000 {
-			status = "okay";
-		};
-		rtc0: rtc at 23000 {
-			status = "okay";
-		};
-		i2c0: i2c at 22000 {
-			status = "okay";
-			clock-frequency = <100000>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c0_pins>;
-
-			tps: tps at 48 {
-				reg = <0x48>;
-			};
-			tlv320aic3106: tlv320aic3106 at 18 {
-				#sound-dai-cells = <0>;
-				compatible = "ti,tlv320aic3106";
-				reg = <0x18>;
-				status = "okay";
-
-				/* Regulators */
-				IOVDD-supply = <&vdcdc2_reg>;
-				/* Derived from VBAT: Baseboard 3.3V / 1.8V */
-				AVDD-supply = <&vbat>;
-				DRVDD-supply = <&vbat>;
-				DVDD-supply = <&vbat>;
-			};
-			tca6416: gpio at 20 {
-				compatible = "ti,tca6416";
-				reg = <0x20>;
-				gpio-controller;
-				#gpio-cells = <2>;
-			};
-		};
-		wdt: wdt at 21000 {
-			status = "okay";
-		};
-		mmc0: mmc at 40000 {
-			max-frequency = <50000000>;
-			bus-width = <4>;
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&mmc0_pins>;
-			cd-gpios = <&gpio 64 GPIO_ACTIVE_LOW>;
-			wp-gpios = <&gpio 65 GPIO_ACTIVE_HIGH>;
-		};
-		spi1: spi at 30e000 {
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
-			flash: m25p80 at 0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "m25p64";
-				spi-max-frequency = <30000000>;
-				m25p,fast-read;
-				reg = <0>;
-				partition at 0 {
-					label = "U-Boot-SPL";
-					reg = <0x00000000 0x00010000>;
-					read-only;
-				};
-				partition at 1 {
-					label = "U-Boot";
-					reg = <0x00010000 0x00080000>;
-					read-only;
-				};
-				partition at 2 {
-					label = "U-Boot-Env";
-					reg = <0x00090000 0x00010000>;
-					read-only;
-				};
-				partition at 3 {
-					label = "Kernel";
-					reg = <0x000a0000 0x00280000>;
-				};
-				partition at 4 {
-					label = "Filesystem";
-					reg = <0x00320000 0x00400000>;
-				};
-				partition at 5 {
-					label = "MAC-Address";
-					reg = <0x007f0000 0x00010000>;
-					read-only;
-				};
-			};
-		};
-		mdio: mdio at 224000 {
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&mdio_pins>;
-			bus_freq = <2200000>;
-		};
-		eth0: ethernet at 220000 {
-			status = "okay";
-			pinctrl-names = "default";
-			pinctrl-0 = <&mii_pins>;
-		};
-		gpio: gpio at 226000 {
-			status = "okay";
-		};
-	};
-
 	backlight {
 		compatible = "gpio-backlight";
 		enable-gpios = <&gpio 48 GPIO_ACTIVE_HIGH>;
@@ -257,6 +117,142 @@
 	};
 };
 
+
+&pmx_core {
+	status = "okay";
+
+	mcasp0_pins: pinmux_mcasp0_pins {
+		pinctrl-single,bits = <
+			/*
+			 * AHCLKX, ACLKX, AFSX, AHCLKR, ACLKR,
+			 * AFSR, AMUTE
+			 */
+			0x00 0x11111111 0xffffffff
+			/* AXR11, AXR12 */
+			0x04 0x00011000 0x000ff000
+		>;
+	};
+	nand_pins: nand_pins {
+		pinctrl-single,bits = <
+			/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
+			0x1c 0x10110110  0xf0ff0ff0
+			/*
+			 * EMA_D[0], EMA_D[1], EMA_D[2],
+			 * EMA_D[3], EMA_D[4], EMA_D[5],
+			 * EMA_D[6], EMA_D[7]
+			 */
+			0x24 0x11111111  0xffffffff
+			/* EMA_A[1], EMA_A[2] */
+			0x30 0x01100000  0x0ff00000
+		>;
+	};
+};
+&serial0 {
+	status = "okay";
+};
+&serial1 {
+	status = "okay";
+};
+&serial2 {
+	status = "okay";
+};
+&rtc0 {
+	status = "okay";
+};
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+
+	tps: tps at 48 {
+		reg = <0x48>;
+	};
+	tlv320aic3106: tlv320aic3106 at 18 {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x18>;
+		status = "okay";
+
+		/* Regulators */
+		IOVDD-supply = <&vdcdc2_reg>;
+		/* Derived from VBAT: Baseboard 3.3V / 1.8V */
+		AVDD-supply = <&vbat>;
+		DRVDD-supply = <&vbat>;
+		DVDD-supply = <&vbat>;
+	};
+	tca6416: gpio at 20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+&wdt {
+	status = "okay";
+};
+&mmc0 {
+	max-frequency = <50000000>;
+	bus-width = <4>;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	cd-gpios = <&gpio 64 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio 65 GPIO_ACTIVE_HIGH>;
+};
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
+	flash: m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p64";
+		spi-max-frequency = <30000000>;
+		m25p,fast-read;
+		reg = <0>;
+		partition at 0 {
+			label = "U-Boot-SPL";
+			reg = <0x00000000 0x00010000>;
+			read-only;
+		};
+		partition at 1 {
+			label = "U-Boot";
+			reg = <0x00010000 0x00080000>;
+			read-only;
+		};
+		partition at 2 {
+			label = "U-Boot-Env";
+			reg = <0x00090000 0x00010000>;
+			read-only;
+		};
+		partition at 3 {
+			label = "Kernel";
+			reg = <0x000a0000 0x00280000>;
+		};
+		partition at 4 {
+			label = "Filesystem";
+			reg = <0x00320000 0x00400000>;
+		};
+		partition at 5 {
+			label = "MAC-Address";
+			reg = <0x007f0000 0x00010000>;
+			read-only;
+		};
+	};
+};
+&mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+	bus_freq = <2200000>;
+};
+&eth0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mii_pins>;
+};
+
 /include/ "tps6507x.dtsi"
 
 &tps {
-- 
2.17.0
