From: david@lechnology.com (David Lechner)
Date: Thu, 24 Mar 2016 18:51:26 -0500
Subject: [PATCH v3 01/16] dt: davinci: use proper address after @
In-Reply-To: <1458863503-31121-1-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
Message-ID: <1458863503-31121-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TI has been using the physical address in DT after the @ in device nodes.
The device tree convention is to use the same address that is used for
the reg property. This updates all davinci DT files to use the proper
convention.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes: This is a new patch.


 arch/arm/boot/dts/da850-enbw-cmc.dts |  8 +++---
 arch/arm/boot/dts/da850-evm.dts      | 26 +++++++++---------
 arch/arm/boot/dts/da850.dtsi         | 52 ++++++++++++++++++------------------
 3 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/da850-enbw-cmc.dts b/arch/arm/boot/dts/da850-enbw-cmc.dts
index 645549e..101d1a1 100644
--- a/arch/arm/boot/dts/da850-enbw-cmc.dts
+++ b/arch/arm/boot/dts/da850-enbw-cmc.dts
@@ -16,14 +16,14 @@
 	compatible = "enbw,cmc", "ti,da850";
 	model = "EnBW CMC";
 
-	soc {
-		serial0: serial at 1c42000 {
+	soc at 1c00000 {
+		serial0: serial at 42000 {
 			status = "okay";
 		};
-		serial1: serial at 1d0c000 {
+		serial1: serial at 10c000 {
 			status = "okay";
 		};
-		serial2: serial at 1d0d000 {
+		serial2: serial at 10d000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index ef061e9..1a15db8 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -14,8 +14,8 @@
 	compatible = "ti,da850-evm", "ti,da850";
 	model = "DA850/AM1808/OMAP-L138 EVM";
 
-	soc {
-		pmx_core: pinmux at 1c14120 {
+	soc at 1c00000 {
+		pmx_core: pinmux at 14120 {
 			status = "okay";
 
 			mcasp0_pins: pinmux_mcasp0_pins {
@@ -30,19 +30,19 @@
 				>;
 			};
 		};
-		serial0: serial at 1c42000 {
+		serial0: serial at 42000 {
 			status = "okay";
 		};
-		serial1: serial at 1d0c000 {
+		serial1: serial at 10c000 {
 			status = "okay";
 		};
-		serial2: serial at 1d0d000 {
+		serial2: serial at 10d000 {
 			status = "okay";
 		};
-		rtc0: rtc at 1c23000 {
+		rtc0: rtc at 23000 {
 			status = "okay";
 		};
-		i2c0: i2c at 1c22000 {
+		i2c0: i2c at 22000 {
 			status = "okay";
 			clock-frequency = <100000>;
 			pinctrl-names = "default";
@@ -66,17 +66,17 @@
 			};
 
 		};
-		wdt: wdt at 1c21000 {
+		wdt: wdt at 21000 {
 			status = "okay";
 		};
-		mmc0: mmc at 1c40000 {
+		mmc0: mmc at 40000 {
 			max-frequency = <50000000>;
 			bus-width = <4>;
 			status = "okay";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins>;
 		};
-		spi1: spi at 1f0e000 {
+		spi1: spi at 30e000 {
 			status = "okay";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi1_pins &spi1_cs0_pin>;
@@ -116,18 +116,18 @@
 				};
 			};
 		};
-		mdio: mdio at 1e24000 {
+		mdio: mdio at 224000 {
 			status = "okay";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mdio_pins>;
 			bus_freq = <2200000>;
 		};
-		eth0: ethernet at 1e20000 {
+		eth0: ethernet at 220000 {
 			status = "okay";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mii_pins>;
 		};
-		gpio: gpio at 1e26000 {
+		gpio: gpio at 226000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 226cda7..4294849 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -15,7 +15,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-		intc: interrupt-controller {
+		intc: interrupt-controller at fffee000 {
 			compatible = "ti,cp-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
@@ -23,7 +23,7 @@
 			reg = <0xfffee000 0x2000>;
 		};
 	};
-	soc {
+	soc at 1c00000 {
 		compatible = "simple-bus";
 		model = "da850";
 		#address-cells = <1>;
@@ -31,7 +31,7 @@
 		ranges = <0x0 0x01c00000 0x400000>;
 		interrupt-parent = <&intc>;
 
-		pmx_core: pinmux at 1c14120 {
+		pmx_core: pinmux at 14120 {
 			compatible = "pinctrl-single";
 			reg = <0x14120 0x50>;
 			#address-cells = <1>;
@@ -150,7 +150,7 @@
 			};
 
 		};
-		edma0: edma at 01c00000 {
+		edma0: edma at 0 {
 			compatible = "ti,edma3-tpcc";
 			/* eDMA3 CC0: 0x01c0 0000 - 0x01c0 7fff */
 			reg =	<0x0 0x8000>;
@@ -161,19 +161,19 @@
 
 			ti,tptcs = <&edma0_tptc0 7>, <&edma0_tptc1 0>;
 		};
-		edma0_tptc0: tptc at 01c08000 {
+		edma0_tptc0: tptc at 8000 {
 			compatible = "ti,edma3-tptc";
 			reg =	<0x8000 0x400>;
 			interrupts = <13>;
 			interrupt-names = "edm3_tcerrint";
 		};
-		edma0_tptc1: tptc at 01c08400 {
+		edma0_tptc1: tptc at 8400 {
 			compatible = "ti,edma3-tptc";
 			reg =	<0x8400 0x400>;
 			interrupts = <32>;
 			interrupt-names = "edm3_tcerrint";
 		};
-		edma1: edma at 01e30000 {
+		edma1: edma at 230000 {
 			compatible = "ti,edma3-tpcc";
 			/* eDMA3 CC1: 0x01e3 0000 - 0x01e3 7fff */
 			reg =	<0x230000 0x8000>;
@@ -184,41 +184,41 @@
 
 			ti,tptcs = <&edma1_tptc0 7>;
 		};
-		edma1_tptc0: tptc at 01e38000 {
+		edma1_tptc0: tptc at 238000 {
 			compatible = "ti,edma3-tptc";
 			reg =	<0x238000 0x400>;
 			interrupts = <95>;
 			interrupt-names = "edm3_tcerrint";
 		};
-		serial0: serial at 1c42000 {
+		serial0: serial at 42000 {
 			compatible = "ns16550a";
 			reg = <0x42000 0x100>;
 			reg-shift = <2>;
 			interrupts = <25>;
 			status = "disabled";
 		};
-		serial1: serial at 1d0c000 {
+		serial1: serial at 10c000 {
 			compatible = "ns16550a";
 			reg = <0x10c000 0x100>;
 			reg-shift = <2>;
 			interrupts = <53>;
 			status = "disabled";
 		};
-		serial2: serial at 1d0d000 {
+		serial2: serial at 10d000 {
 			compatible = "ns16550a";
 			reg = <0x10d000 0x100>;
 			reg-shift = <2>;
 			interrupts = <61>;
 			status = "disabled";
 		};
-		rtc0: rtc at 1c23000 {
+		rtc0: rtc at 23000 {
 			compatible = "ti,da830-rtc";
 			reg = <0x23000 0x1000>;
 			interrupts = <19
 				      19>;
 			status = "disabled";
 		};
-		i2c0: i2c at 1c22000 {
+		i2c0: i2c at 22000 {
 			compatible = "ti,davinci-i2c";
 			reg = <0x22000 0x1000>;
 			interrupts = <15>;
@@ -226,12 +226,12 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
-		wdt: wdt at 1c21000 {
+		wdt: wdt at 21000 {
 			compatible = "ti,davinci-wdt";
 			reg = <0x21000 0x1000>;
 			status = "disabled";
 		};
-		mmc0: mmc at 1c40000 {
+		mmc0: mmc at 40000 {
 			compatible = "ti,da830-mmc";
 			reg = <0x40000 0x1000>;
 			interrupts = <16>;
@@ -239,7 +239,7 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
-		mmc1: mmc at 1e1b000 {
+		mmc1: mmc at 21b000 {
 			compatible = "ti,da830-mmc";
 			reg = <0x21b000 0x1000>;
 			interrupts = <72>;
@@ -247,37 +247,37 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
-		ehrpwm0: ehrpwm at 01f00000 {
+		ehrpwm0: ehrpwm at 300000 {
 			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x300000 0x2000>;
 			status = "disabled";
 		};
-		ehrpwm1: ehrpwm at 01f02000 {
+		ehrpwm1: ehrpwm at 302000 {
 			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
 			status = "disabled";
 		};
-		ecap0: ecap at 01f06000 {
+		ecap0: ecap at 306000 {
 			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x306000 0x80>;
 			status = "disabled";
 		};
-		ecap1: ecap at 01f07000 {
+		ecap1: ecap at 307000 {
 			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x307000 0x80>;
 			status = "disabled";
 		};
-		ecap2: ecap at 01f08000 {
+		ecap2: ecap at 308000 {
 			compatible = "ti,da850-ecap", "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x308000 0x80>;
 			status = "disabled";
 		};
-		spi1: spi at 1f0e000 {
+		spi1: spi at 30e000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "ti,da830-spi";
@@ -289,13 +289,13 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
-		mdio: mdio at 1e24000 {
+		mdio: mdio at 224000 {
 			compatible = "ti,davinci_mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x224000 0x1000>;
 		};
-		eth0: ethernet at 1e20000 {
+		eth0: ethernet at 220000 {
 			compatible = "ti,davinci-dm6467-emac";
 			reg = <0x220000 0x4000>;
 			ti,davinci-ctrl-reg-offset = <0x3000>;
@@ -309,7 +309,7 @@
 					36
 					>;
 		};
-		gpio: gpio at 1e26000 {
+		gpio: gpio at 226000 {
 			compatible = "ti,dm6441-gpio";
 			gpio-controller;
 			reg = <0x226000 0x1000>;
@@ -323,7 +323,7 @@
 			status = "disabled";
 		};
 
-		mcasp0: mcasp at 01d00000 {
+		mcasp0: mcasp at 100000 {
 			compatible = "ti,da830-mcasp-audio";
 			reg = <0x100000 0x2000>,
 			      <0x102000 0x400000>;
-- 
1.9.1
