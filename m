From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:59 +0100
Subject: [PATCH 25/25] arm: ste: dts: Remove leading 0x and 0s from bindings
 notation
Message-ID: <20171215124659.31152-1-malat@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This will solve as a side effect warning:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi          |   2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 130 ++++++++++++++---------------
 arch/arm/boot/dts/ste-u300.dts             |  50 +++++------
 3 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2310a4e97768..cff985f9fb77 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -474,7 +474,7 @@
 			clocks = <&prcc_pclk 5 0>;
 		};
 
-		dma: dma-controller at 801C0000 {
+		dma: dma-controller at 801c0000 {
 			compatible = "stericsson,db8500-dma40", "stericsson,dma40";
 			reg = <0x801C0000 0x1000 0x40010000 0x800>;
 			reg-names = "base", "lcpa";
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 68aab50a73ab..2970719ed22c 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -195,7 +195,7 @@
 		 * MXTAL "Main Chrystal" is a chrystal oscillator @19.2 MHz
 		 * that is parent of TIMCLK, PLL1 and PLL2
 		 */
-		mxtal: mxtal at 19.2M {
+		mxtal: mxtal at 19.2m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <19200000>;
@@ -207,7 +207,7 @@
 		 * divided by 8. This clock is used by the timers and
 		 * watchdog. See page 105 ff.
 		 */
-		timclk: timclk at 2.4M {
+		timclk: timclk at 2.4m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <8>;
@@ -245,21 +245,21 @@
 			pll-id = <2>;
 			clocks = <&mxtal>;
 		};
-		clk216: clk216 at 216M {
+		clk216: clk216 at 216m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <4>;
 			clock-mult = <1>;
 			clocks = <&pll2>;
 		};
-		clk108: clk108 at 108M {
+		clk108: clk108 at 108m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <2>;
 			clock-mult = <1>;
 			clocks = <&clk216>;
 		};
-		clk72: clk72 at 72M {
+		clk72: clk72 at 72m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			/* The data sheet does not say how this is derived */
@@ -267,7 +267,7 @@
 			clock-mult = <1>;
 			clocks = <&pll2>;
 		};
-		clk48: clk48 at 48M {
+		clk48: clk48 at 48m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			/* The data sheet does not say how this is derived */
@@ -275,7 +275,7 @@
 			clock-mult = <1>;
 			clocks = <&pll2>;
 		};
-		clk27: clk27 at 27M {
+		clk27: clk27 at 27m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <4>;
@@ -284,7 +284,7 @@
 		};
 
 		/* This apparently exists as well */
-		ulpiclk: ulpiclk at 60M {
+		ulpiclk: ulpiclk at 60m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <60000000>;
@@ -295,193 +295,193 @@
 		 * peripheral clocking, clock gates.
 		 */
 
-		hclkdma0: hclkdma0 at 48M {
+		hclkdma0: hclkdma0 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <0>;
 			clocks = <&hclk>;
 		};
-		hclksmc: hclksmc at 48M {
+		hclksmc: hclksmc at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <1>;
 			clocks = <&hclk>;
 		};
-		hclksdram: hclksdram at 48M {
+		hclksdram: hclksdram at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <2>;
 			clocks = <&hclk>;
 		};
-		hclkdma1: hclkdma1 at 48M {
+		hclkdma1: hclkdma1 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <3>;
 			clocks = <&hclk>;
 		};
-		hclkclcd: hclkclcd at 48M {
+		hclkclcd: hclkclcd at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <4>;
 			clocks = <&hclk>;
 		};
-		pclkirda: pclkirda at 48M {
+		pclkirda: pclkirda at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <5>;
 			clocks = <&pclk>;
 		};
-		pclkssp: pclkssp at 48M {
+		pclkssp: pclkssp at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <6>;
 			clocks = <&pclk>;
 		};
-		pclkuart0: pclkuart0 at 48M {
+		pclkuart0: pclkuart0 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <7>;
 			clocks = <&pclk>;
 		};
-		pclksdi: pclksdi at 48M {
+		pclksdi: pclksdi at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <8>;
 			clocks = <&pclk>;
 		};
-		pclki2c0: pclki2c0 at 48M {
+		pclki2c0: pclki2c0 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <9>;
 			clocks = <&pclk>;
 		};
-		pclki2c1: pclki2c1 at 48M {
+		pclki2c1: pclki2c1 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <10>;
 			clocks = <&pclk>;
 		};
-		pclkuart1: pclkuart1 at 48M {
+		pclkuart1: pclkuart1 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <11>;
 			clocks = <&pclk>;
 		};
-		pclkmsp0: pclkmsp0 at 48M {
+		pclkmsp0: pclkmsp0 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <12>;
 			clocks = <&pclk>;
 		};
-		hclkusb: hclkusb at 48M {
+		hclkusb: hclkusb at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <13>;
 			clocks = <&hclk>;
 		};
-		hclkdif: hclkdif at 48M {
+		hclkdif: hclkdif at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <14>;
 			clocks = <&hclk>;
 		};
-		hclksaa: hclksaa at 48M {
+		hclksaa: hclksaa at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <15>;
 			clocks = <&hclk>;
 		};
-		hclksva: hclksva at 48M {
+		hclksva: hclksva at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <16>;
 			clocks = <&hclk>;
 		};
-		pclkhsi: pclkhsi at 48M {
+		pclkhsi: pclkhsi at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <17>;
 			clocks = <&pclk>;
 		};
-		pclkxti: pclkxti at 48M {
+		pclkxti: pclkxti at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <18>;
 			clocks = <&pclk>;
 		};
-		pclkuart2: pclkuart2 at 48M {
+		pclkuart2: pclkuart2 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <19>;
 			clocks = <&pclk>;
 		};
-		pclkmsp1: pclkmsp1 at 48M {
+		pclkmsp1: pclkmsp1 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <20>;
 			clocks = <&pclk>;
 		};
-		pclkmsp2: pclkmsp2 at 48M {
+		pclkmsp2: pclkmsp2 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <21>;
 			clocks = <&pclk>;
 		};
-		pclkowm: pclkowm at 48M {
+		pclkowm: pclkowm at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <22>;
 			clocks = <&pclk>;
 		};
-		hclkhpi: hclkhpi at 48M {
+		hclkhpi: hclkhpi at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <23>;
 			clocks = <&hclk>;
 		};
-		pclkske: pclkske at 48M {
+		pclkske: pclkske at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <24>;
 			clocks = <&pclk>;
 		};
-		pclkhsem: pclkhsem at 48M {
+		pclkhsem: pclkhsem at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <25>;
 			clocks = <&pclk>;
 		};
-		hclk3d: hclk3d at 48M {
+		hclk3d: hclk3d at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <26>;
 			clocks = <&hclk>;
 		};
-		hclkhash: hclkhash at 48M {
+		hclkhash: hclkhash at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <27>;
 			clocks = <&hclk>;
 		};
-		hclkcryp: hclkcryp at 48M {
+		hclkcryp: hclkcryp at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <28>;
 			clocks = <&hclk>;
 		};
-		pclkmshc: pclkmshc at 48M {
+		pclkmshc: pclkmshc at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <29>;
 			clocks = <&pclk>;
 		};
-		hclkusbm: hclkusbm at 48M {
+		hclkusbm: hclkusbm at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <30>;
 			clocks = <&hclk>;
 		};
-		hclkrng: hclkrng at 48M {
+		hclkrng: hclkrng at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <31>;
@@ -495,153 +495,153 @@
 			clock-id = <36>;
 			clocks = <&clk72 &clk48>;
 		};
-		irdaclk: irdaclk at 48M {
+		irdaclk: irdaclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <37>;
 			clocks = <&clk48>;
 		};
-		sspiclk: sspiclk at 48M {
+		sspiclk: sspiclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <38>;
 			clocks = <&clk48>;
 		};
-		uart0clk: uart0clk at 48M {
+		uart0clk: uart0clk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <39>;
 			clocks = <&clk48>;
 		};
-		sdiclk: sdiclk at 48M {
+		sdiclk: sdiclk at 48m {
 			/* Also called MCCLK in some documents */
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <40>;
 			clocks = <&clk48>;
 		};
-		i2c0clk: i2c0clk at 48M {
+		i2c0clk: i2c0clk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <41>;
 			clocks = <&clk48>;
 		};
-		i2c1clk: i2c1clk at 48M {
+		i2c1clk: i2c1clk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <42>;
 			clocks = <&clk48>;
 		};
-		uart1clk: uart1clk at 48M {
+		uart1clk: uart1clk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <43>;
 			clocks = <&clk48>;
 		};
-		mspclk0: mspclk0 at 48M {
+		mspclk0: mspclk0 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <44>;
 			clocks = <&clk48>;
 		};
-		usbclk: usbclk at 48M {
+		usbclk: usbclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <45>;
 			clocks = <&clk48>; /* 48 MHz not ULPI */
 		};
-		difclk: difclk at 72M {
+		difclk: difclk at 72m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <46>;
 			clocks = <&clk72>;
 		};
-		ipi2cclk: ipi2cclk at 48M {
+		ipi2cclk: ipi2cclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <47>;
 			clocks = <&clk48>; /* Guess */
 		};
-		ipbmcclk: ipbmcclk at 48M {
+		ipbmcclk: ipbmcclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <48>;
 			clocks = <&clk48>; /* Guess */
 		};
-		hsiclkrx: hsiclkrx at 216M {
+		hsiclkrx: hsiclkrx at 216m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <49>;
 			clocks = <&clk216>;
 		};
-		hsiclktx: hsiclktx at 108M {
+		hsiclktx: hsiclktx at 108m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <50>;
 			clocks = <&clk108>;
 		};
-		uart2clk: uart2clk at 48M {
+		uart2clk: uart2clk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <51>;
 			clocks = <&clk48>;
 		};
-		mspclk1: mspclk1 at 48M {
+		mspclk1: mspclk1 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <52>;
 			clocks = <&clk48>;
 		};
-		mspclk2: mspclk2 at 48M {
+		mspclk2: mspclk2 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <53>;
 			clocks = <&clk48>;
 		};
-		owmclk: owmclk at 48M {
+		owmclk: owmclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <54>;
 			clocks = <&clk48>; /* Guess */
 		};
-		skeclk: skeclk at 48M {
+		skeclk: skeclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <56>;
 			clocks = <&clk48>; /* Guess */
 		};
-		x3dclk: x3dclk at 48M {
+		x3dclk: x3dclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <58>;
 			clocks = <&clk48>; /* Guess */
 		};
-		pclkmsp3: pclkmsp3 at 48M {
+		pclkmsp3: pclkmsp3 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <59>;
 			clocks = <&pclk>;
 		};
-		mspclk3: mspclk3 at 48M {
+		mspclk3: mspclk3 at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <60>;
 			clocks = <&clk48>;
 		};
-		mshcclk: mshcclk at 48M {
+		mshcclk: mshcclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <61>;
 			clocks = <&clk48>; /* Guess */
 		};
-		usbmclk: usbmclk at 48M {
+		usbmclk: usbmclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <62>;
 			/* Stated as "48 MHz not ULPI clock" */
 			clocks = <&clk48>;
 		};
-		rngcclk: rngcclk at 48M {
+		rngcclk: rngcclk at 48m {
 			#clock-cells = <0>;
 			compatible = "st,nomadik-src-clock";
 			clock-id = <63>;
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 62ecb6a2fa39..08edee80f022 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -39,88 +39,88 @@
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
 		};
-		pll13: pll13 at 13M {
+		pll13: pll13 at 13m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <13000000>;
 		};
 		/* Slow bridge clocks under PLL13 */
-		slow_clk: slow_clk at 13M {
+		slow_clk: slow_clk at 13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <0>;
 			clocks = <&pll13>;
 		};
-		uart0_clk: uart0_clk at 13M {
+		uart0_clk: uart0_clk at 13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <1>;
 			clocks = <&slow_clk>;
 		};
-		gpio_clk: gpio_clk at 13M {
+		gpio_clk: gpio_clk at 13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <4>;
 			clocks = <&slow_clk>;
 		};
-		rtc_clk: rtc_clk at 13M {
+		rtc_clk: rtc_clk at 13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <6>;
 			clocks = <&slow_clk>;
 		};
-		apptimer_clk: app_tmr_clk at 13M {
+		apptimer_clk: app_tmr_clk at 13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <7>;
 			clocks = <&slow_clk>;
 		};
-		acc_tmr_clk at 13M {
+		acc_tmr_clk at 13m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <0>; /* Slow */
 			clock-id = <8>;
 			clocks = <&slow_clk>;
 		};
-		pll208: pll208 at 208M {
+		pll208: pll208 at 208m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <208000000>;
 		};
-		app208: app_208_clk at 208M {
+		app208: app_208_clk at 208m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <1>;
 			clock-mult = <1>;
 			clocks = <&pll208>;
 		};
-		cpu_clk at 208M {
+		cpu_clk at 208m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <3>;
 			clocks = <&app208>;
 		};
-		app104: app_104_clk at 104M {
+		app104: app_104_clk at 104m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <2>;
 			clock-mult = <1>;
 			clocks = <&pll208>;
 		};
-		semi_clk at 104M {
+		semi_clk at 104m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <9>;
 			clocks = <&app104>;
 		};
-		app52: app_52_clk at 52M {
+		app52: app_52_clk at 52m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <4>;
@@ -128,49 +128,49 @@
 			clocks = <&pll208>;
 		};
 		/* AHB subsystem clocks */
-		ahb_clk: ahb_subsys_clk at 52M {
+		ahb_clk: ahb_subsys_clk at 52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <10>;
 			clocks = <&app52>;
 		};
-		intcon_clk at 52M {
+		intcon_clk at 52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <12>;
 			clocks = <&ahb_clk>;
 		};
-		emif_clk at 52M {
+		emif_clk at 52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <5>;
 			clocks = <&ahb_clk>;
 		};
-		dmac_clk: dmac_clk at 52M {
+		dmac_clk: dmac_clk at 52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <4>;
 			clocks = <&app52>;
 		};
-		fsmc_clk: fsmc_clk at 52M {
+		fsmc_clk: fsmc_clk at 52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <6>;
 			clocks = <&app52>;
 		};
-		xgam_clk: xgam_clk at 52M {
+		xgam_clk: xgam_clk at 52m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <2>; /* Rest */
 			clock-id = <8>;
 			clocks = <&app52>;
 		};
-		app26: app_26_clk at 26M {
+		app26: app_26_clk at 26m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <2>;
@@ -178,28 +178,28 @@
 			clocks = <&app52>;
 		};
 		/* Fast bridge  clocks */
-		fast_clk: fast_clk at 26M {
+		fast_clk: fast_clk at 26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
 			clock-id = <0>;
 			clocks = <&app26>;
 		};
-		i2c0_clk: i2c0_clk at 26M {
+		i2c0_clk: i2c0_clk at 26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
 			clock-id = <1>;
 			clocks = <&fast_clk>;
 		};
-		i2c1_clk: i2c1_clk at 26M {
+		i2c1_clk: i2c1_clk at 26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
 			clock-id = <2>;
 			clocks = <&fast_clk>;
 		};
-		mmc_pclk: mmc_p_clk at 26M {
+		mmc_pclk: mmc_p_clk at 26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
@@ -211,7 +211,7 @@
 			compatible = "stericsson,u300-syscon-mclk";
 			clocks = <&mmc_pclk>;
 		};
-		spi_clk: spi_p_clk at 26M {
+		spi_clk: spi_p_clk at 26m {
 			#clock-cells = <0>;
 			compatible = "stericsson,u300-syscon-clk";
 			clock-type = <1>; /* Fast */
-- 
2.11.0
