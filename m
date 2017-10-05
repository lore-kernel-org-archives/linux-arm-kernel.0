From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:36 +0200
Subject: [PATCH 01/20] ARM: dts: sunxi: Remove leading zeros from
 unit-addresses
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b59c0d69a9210cc9b0b537a4ccc00655db1a8e07.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of our device trees have had leading zeros for padding as part of
the nodes unit-addresses.

Remove all these useless zeros that generate warnings

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi     | 110 ++++++++++++-------------
 arch/arm/boot/dts/sun5i-a10s.dtsi    |   6 +-
 arch/arm/boot/dts/sun5i-a13.dtsi     |   4 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi     |   8 +-
 arch/arm/boot/dts/sun5i.dtsi         |  82 +++++++++----------
 arch/arm/boot/dts/sun6i-a31.dtsi     | 112 +++++++++++++-------------
 arch/arm/boot/dts/sun7i-a20.dtsi     | 122 ++++++++++++++--------------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi |  62 +++++++-------
 arch/arm/boot/dts/sun8i-a23.dtsi     |   4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi     |  18 ++--
 arch/arm/boot/dts/sun8i-v3s.dtsi     |  32 +++----
 arch/arm/boot/dts/sun9i-a80.dtsi     |  86 ++++++++++----------
 12 files changed, 323 insertions(+), 323 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 9899ecddeb78..82d4ab6fbbcd 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -169,7 +169,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: clk at 01c20050 {
+		osc24M: clk at 1c20050 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -184,20 +184,20 @@
 		};
 	};
 
-	soc at 01c00000 {
+	soc at 1c00000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
-		sram-controller at 01c00000 {
+		sram-controller at 1c00000 {
 			compatible = "allwinner,sun4i-a10-sram-controller";
 			reg = <0x01c00000 0x30>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
 
-			sram_a: sram at 00000000 {
+			sram_a: sram at 0 {
 				compatible = "mmio-sram";
 				reg = <0x00000000 0xc000>;
 				#address-cells = <1>;
@@ -211,14 +211,14 @@
 				};
 			};
 
-			sram_d: sram at 00010000 {
+			sram_d: sram at 10000 {
 				compatible = "mmio-sram";
 				reg = <0x00010000 0x1000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				ranges = <0 0x00010000 0x1000>;
 
-				otg_sram: sram-section at 0000 {
+				otg_sram: sram-section at 0 {
 					compatible = "allwinner,sun4i-a10-sram-d";
 					reg = <0x0000 0x1000>;
 					status = "disabled";
@@ -226,7 +226,7 @@
 			};
 		};
 
-		dma: dma-controller at 01c02000 {
+		dma: dma-controller at 1c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <27>;
@@ -234,7 +234,7 @@
 			#dma-cells = <2>;
 		};
 
-		nfc: nand at 01c03000 {
+		nfc: nand at 1c03000 {
 			compatible = "allwinner,sun4i-a10-nand";
 			reg = <0x01c03000 0x1000>;
 			interrupts = <37>;
@@ -247,7 +247,7 @@
 			#size-cells = <0>;
 		};
 
-		spi0: spi at 01c05000 {
+		spi0: spi at 1c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
 			interrupts = <10>;
@@ -261,7 +261,7 @@
 			#size-cells = <0>;
 		};
 
-		spi1: spi at 01c06000 {
+		spi1: spi at 1c06000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c06000 0x1000>;
 			interrupts = <11>;
@@ -275,7 +275,7 @@
 			#size-cells = <0>;
 		};
 
-		emac: ethernet at 01c0b000 {
+		emac: ethernet at 1c0b000 {
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
 			interrupts = <55>;
@@ -284,7 +284,7 @@
 			status = "disabled";
 		};
 
-		mdio: mdio at 01c0b080 {
+		mdio: mdio at 1c0b080 {
 			compatible = "allwinner,sun4i-a10-mdio";
 			reg = <0x01c0b080 0x14>;
 			status = "disabled";
@@ -292,7 +292,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc0: mmc at 01c0f000 {
+		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC0>, <&ccu CLK_MMC0>;
@@ -303,7 +303,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc1: mmc at 01c10000 {
+		mmc1: mmc at 1c10000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC1>, <&ccu CLK_MMC1>;
@@ -314,7 +314,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc2: mmc at 01c11000 {
+		mmc2: mmc at 1c11000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC2>, <&ccu CLK_MMC2>;
@@ -325,7 +325,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc3: mmc at 01c12000 {
+		mmc3: mmc at 1c12000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c12000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC3>, <&ccu CLK_MMC3>;
@@ -336,7 +336,7 @@
 			#size-cells = <0>;
 		};
 
-		usb_otg: usb at 01c13000 {
+		usb_otg: usb at 1c13000 {
 			compatible = "allwinner,sun4i-a10-musb";
 			reg = <0x01c13000 0x0400>;
 			clocks = <&ccu CLK_AHB_OTG>;
@@ -349,7 +349,7 @@
 			status = "disabled";
 		};
 
-		usbphy: phy at 01c13400 {
+		usbphy: phy at 1c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun4i-a10-usb-phy";
 			reg = <0x01c13400 0x10 0x01c14800 0x4 0x01c1c800 0x4>;
@@ -363,7 +363,7 @@
 			status = "disabled";
 		};
 
-		ehci0: usb at 01c14000 {
+		ehci0: usb at 1c14000 {
 			compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
 			reg = <0x01c14000 0x100>;
 			interrupts = <39>;
@@ -373,7 +373,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at 01c14400 {
+		ohci0: usb at 1c14400 {
 			compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
 			reg = <0x01c14400 0x100>;
 			interrupts = <64>;
@@ -383,7 +383,7 @@
 			status = "disabled";
 		};
 
-		crypto: crypto-engine at 01c15000 {
+		crypto: crypto-engine at 1c15000 {
 			compatible = "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
 			interrupts = <86>;
@@ -391,7 +391,7 @@
 			clock-names = "ahb", "mod";
 		};
 
-		spi2: spi at 01c17000 {
+		spi2: spi at 1c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
 			interrupts = <12>;
@@ -405,7 +405,7 @@
 			#size-cells = <0>;
 		};
 
-		ahci: sata at 01c18000 {
+		ahci: sata at 1c18000 {
 			compatible = "allwinner,sun4i-a10-ahci";
 			reg = <0x01c18000 0x1000>;
 			interrupts = <56>;
@@ -413,7 +413,7 @@
 			status = "disabled";
 		};
 
-		ehci1: usb at 01c1c000 {
+		ehci1: usb at 1c1c000 {
 			compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
 			reg = <0x01c1c000 0x100>;
 			interrupts = <40>;
@@ -423,7 +423,7 @@
 			status = "disabled";
 		};
 
-		ohci1: usb at 01c1c400 {
+		ohci1: usb at 1c1c400 {
 			compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <65>;
@@ -433,7 +433,7 @@
 			status = "disabled";
 		};
 
-		spi3: spi at 01c1f000 {
+		spi3: spi at 1c1f000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
 			interrupts = <50>;
@@ -447,7 +447,7 @@
 			#size-cells = <0>;
 		};
 
-		ccu: clock at 01c20000 {
+		ccu: clock at 1c20000 {
 			compatible = "allwinner,sun4i-a10-ccu";
 			reg = <0x01c20000 0x400>;
 			clocks = <&osc24M>, <&osc32k>;
@@ -456,14 +456,14 @@
 			#reset-cells = <1>;
 		};
 
-		intc: interrupt-controller at 01c20400 {
+		intc: interrupt-controller at 1c20400 {
 			compatible = "allwinner,sun4i-a10-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
 		};
 
-		pio: pinctrl at 01c20800 {
+		pio: pinctrl at 1c20800 {
 			compatible = "allwinner,sun4i-a10-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <28>;
@@ -613,25 +613,25 @@
 			};
 		};
 
-		timer at 01c20c00 {
+		timer at 1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
 			clocks = <&osc24M>;
 		};
 
-		wdt: watchdog at 01c20c90 {
+		wdt: watchdog at 1c20c90 {
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
-		rtc: rtc at 01c20d00 {
+		rtc: rtc at 1c20d00 {
 			compatible = "allwinner,sun4i-a10-rtc";
 			reg = <0x01c20d00 0x20>;
 			interrupts = <24>;
 		};
 
-		pwm: pwm at 01c20e00 {
+		pwm: pwm at 1c20e00 {
 			compatible = "allwinner,sun4i-a10-pwm";
 			reg = <0x01c20e00 0xc>;
 			clocks = <&osc24M>;
@@ -639,7 +639,7 @@
 			status = "disabled";
 		};
 
-		spdif: spdif at 01c21000 {
+		spdif: spdif at 1c21000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-spdif";
 			reg = <0x01c21000 0x400>;
@@ -652,7 +652,7 @@
 			status = "disabled";
 		};
 
-		ir0: ir at 01c21800 {
+		ir0: ir at 1c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&ccu CLK_APB0_IR0>, <&ccu CLK_IR0>;
 			clock-names = "apb", "ir";
@@ -661,7 +661,7 @@
 			status = "disabled";
 		};
 
-		ir1: ir at 01c21c00 {
+		ir1: ir at 1c21c00 {
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&ccu CLK_APB0_IR1>, <&ccu CLK_IR1>;
 			clock-names = "apb", "ir";
@@ -670,7 +670,7 @@
 			status = "disabled";
 		};
 
-		i2s0: i2s at 01c22400 {
+		i2s0: i2s at 1c22400 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-i2s";
 			reg = <0x01c22400 0x400>;
@@ -683,14 +683,14 @@
 			status = "disabled";
 		};
 
-		lradc: lradc at 01c22800 {
+		lradc: lradc at 1c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
 			interrupts = <31>;
 			status = "disabled";
 		};
 
-		codec: codec at 01c22c00 {
+		codec: codec at 1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-codec";
 			reg = <0x01c22c00 0x40>;
@@ -703,19 +703,19 @@
 			status = "disabled";
 		};
 
-		sid: eeprom at 01c23800 {
+		sid: eeprom at 1c23800 {
 			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
 		};
 
-		rtp: rtp at 01c25000 {
+		rtp: rtp at 1c25000 {
 			compatible = "allwinner,sun4i-a10-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 			#thermal-sensor-cells = <0>;
 		};
 
-		uart0: serial at 01c28000 {
+		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <1>;
@@ -725,7 +725,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 01c28400 {
+		uart1: serial at 1c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
 			interrupts = <2>;
@@ -735,7 +735,7 @@
 			status = "disabled";
 		};
 
-		uart2: serial at 01c28800 {
+		uart2: serial at 1c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
 			interrupts = <3>;
@@ -745,7 +745,7 @@
 			status = "disabled";
 		};
 
-		uart3: serial at 01c28c00 {
+		uart3: serial at 1c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
 			interrupts = <4>;
@@ -755,7 +755,7 @@
 			status = "disabled";
 		};
 
-		uart4: serial at 01c29000 {
+		uart4: serial at 1c29000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29000 0x400>;
 			interrupts = <17>;
@@ -765,7 +765,7 @@
 			status = "disabled";
 		};
 
-		uart5: serial at 01c29400 {
+		uart5: serial at 1c29400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29400 0x400>;
 			interrupts = <18>;
@@ -775,7 +775,7 @@
 			status = "disabled";
 		};
 
-		uart6: serial at 01c29800 {
+		uart6: serial at 1c29800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29800 0x400>;
 			interrupts = <19>;
@@ -785,7 +785,7 @@
 			status = "disabled";
 		};
 
-		uart7: serial at 01c29c00 {
+		uart7: serial at 1c29c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29c00 0x400>;
 			interrupts = <20>;
@@ -795,7 +795,7 @@
 			status = "disabled";
 		};
 
-		ps20: ps2 at 01c2a000 {
+		ps20: ps2 at 1c2a000 {
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a000 0x400>;
 			interrupts = <62>;
@@ -803,7 +803,7 @@
 			status = "disabled";
 		};
 
-		ps21: ps2 at 01c2a400 {
+		ps21: ps2 at 1c2a400 {
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a400 0x400>;
 			interrupts = <63>;
@@ -811,7 +811,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 01c2ac00 {
+		i2c0: i2c at 1c2ac00 {
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
@@ -821,7 +821,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c1: i2c at 01c2b000 {
+		i2c1: i2c at 1c2b000 {
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
@@ -831,7 +831,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c2: i2c at 01c2b400 {
+		i2c2: i2c at 1c2b400 {
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
@@ -841,7 +841,7 @@
 			#size-cells = <0>;
 		};
 
-		can0: can at 01c2bc00 {
+		can0: can at 1c2bc00 {
 			compatible = "allwinner,sun4i-a10-can";
 			reg = <0x01c2bc00 0x400>;
 			interrupts = <26>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 18f25c5e75ae..6ae4d95e230e 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -76,8 +76,8 @@
 		allwinner,pipelines = <&fe0>;
 	};
 
-	soc at 01c00000 {
-		hdmi: hdmi at 01c16000 {
+	soc at 1c00000 {
+		hdmi: hdmi at 1c16000 {
 			compatible = "allwinner,sun5i-a10s-hdmi";
 			reg = <0x01c16000 0x1000>;
 			interrupts = <58>;
@@ -111,7 +111,7 @@
 			};
 		};
 
-		pwm: pwm at 01c20e00 {
+		pwm: pwm at 1c20e00 {
 			compatible = "allwinner,sun5i-a10s-pwm";
 			reg = <0x01c20e00 0xc>;
 			clocks = <&ccu CLK_HOSC>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 6436bad94404..4e830f5cb7f1 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -88,8 +88,8 @@
 		allwinner,pipelines = <&fe0>;
 	};
 
-	soc at 01c00000 {
-		pwm: pwm at 01c20e00 {
+	soc at 1c00000 {
+		pwm: pwm at 1c20e00 {
 			compatible = "allwinner,sun5i-a13-pwm";
 			reg = <0x01c20e00 0xc>;
 			clocks = <&ccu CLK_HOSC>;
diff --git a/arch/arm/boot/dts/sun5i-gr8.dtsi b/arch/arm/boot/dts/sun5i-gr8.dtsi
index 3eb56cad0cea..ef0b7446a99d 100644
--- a/arch/arm/boot/dts/sun5i-gr8.dtsi
+++ b/arch/arm/boot/dts/sun5i-gr8.dtsi
@@ -54,8 +54,8 @@
 		allwinner,pipelines = <&fe0>;
 	};
 
-	soc at 01c00000 {
-		pwm: pwm at 01c20e00 {
+	soc at 1c00000 {
+		pwm: pwm at 1c20e00 {
 			compatible = "allwinner,sun5i-a10s-pwm";
 			reg = <0x01c20e00 0xc>;
 			clocks = <&ccu CLK_HOSC>;
@@ -63,7 +63,7 @@
 			status = "disabled";
 		};
 
-		spdif: spdif at 01c21000 {
+		spdif: spdif at 1c21000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-spdif";
 			reg = <0x01c21000 0x400>;
@@ -76,7 +76,7 @@
 			status = "disabled";
 		};
 
-		i2s0: i2s at 01c22400 {
+		i2s0: i2s at 1c22400 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-i2s";
 			reg = <0x01c22400 0x400>;
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 98cc00341b00..88fb70701093 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -93,7 +93,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: clk at 01c20050 {
+		osc24M: clk at 1c20050 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -108,13 +108,13 @@
 		};
 	};
 
-	soc at 01c00000 {
+	soc at 1c00000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
-		sram-controller at 01c00000 {
+		sram-controller at 1c00000 {
 			compatible = "allwinner,sun4i-a10-sram-controller";
 			reg = <0x01c00000 0x30>;
 			#address-cells = <1>;
@@ -135,7 +135,7 @@
 				status = "disabled";
 			};
 
-			sram_d: sram at 00010000 {
+			sram_d: sram at 10000 {
 				compatible = "mmio-sram";
 				reg = <0x00010000 0x1000>;
 				#address-cells = <1>;
@@ -150,7 +150,7 @@
 			};
 		};
 
-		dma: dma-controller at 01c02000 {
+		dma: dma-controller at 1c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <27>;
@@ -158,7 +158,7 @@
 			#dma-cells = <2>;
 		};
 
-		nfc: nand at 01c03000 {
+		nfc: nand at 1c03000 {
 			compatible = "allwinner,sun4i-a10-nand";
 			reg = <0x01c03000 0x1000>;
 			interrupts = <37>;
@@ -171,7 +171,7 @@
 			#size-cells = <0>;
 		};
 
-		spi0: spi at 01c05000 {
+		spi0: spi at 1c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
 			interrupts = <10>;
@@ -185,7 +185,7 @@
 			#size-cells = <0>;
 		};
 
-		spi1: spi at 01c06000 {
+		spi1: spi at 1c06000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c06000 0x1000>;
 			interrupts = <11>;
@@ -199,7 +199,7 @@
 			#size-cells = <0>;
 		};
 
-		tve0: tv-encoder at 01c0a000 {
+		tve0: tv-encoder at 1c0a000 {
 			compatible = "allwinner,sun4i-a10-tv-encoder";
 			reg = <0x01c0a000 0x1000>;
 			clocks = <&ccu CLK_AHB_TVE>;
@@ -217,7 +217,7 @@
 			};
 		};
 
-		emac: ethernet at 01c0b000 {
+		emac: ethernet at 1c0b000 {
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
 			interrupts = <55>;
@@ -226,7 +226,7 @@
 			status = "disabled";
 		};
 
-		mdio: mdio at 01c0b080 {
+		mdio: mdio at 1c0b080 {
 			compatible = "allwinner,sun4i-a10-mdio";
 			reg = <0x01c0b080 0x14>;
 			status = "disabled";
@@ -234,7 +234,7 @@
 			#size-cells = <0>;
 		};
 
-		tcon0: lcd-controller at 01c0c000 {
+		tcon0: lcd-controller at 1c0c000 {
 			compatible = "allwinner,sun5i-a13-tcon";
 			reg = <0x01c0c000 0x1000>;
 			interrupts = <44>;
@@ -278,7 +278,7 @@
 			};
 		};
 
-		mmc0: mmc at 01c0f000 {
+		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC0>, <&ccu CLK_MMC0>;
@@ -289,7 +289,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc1: mmc at 01c10000 {
+		mmc1: mmc at 1c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC1>, <&ccu CLK_MMC1>;
@@ -300,7 +300,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc2: mmc at 01c11000 {
+		mmc2: mmc at 1c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC2>, <&ccu CLK_MMC2>;
@@ -311,7 +311,7 @@
 			#size-cells = <0>;
 		};
 
-		usb_otg: usb at 01c13000 {
+		usb_otg: usb at 1c13000 {
 			compatible = "allwinner,sun4i-a10-musb";
 			reg = <0x01c13000 0x0400>;
 			clocks = <&ccu CLK_AHB_OTG>;
@@ -324,7 +324,7 @@
 			status = "disabled";
 		};
 
-		usbphy: phy at 01c13400 {
+		usbphy: phy at 1c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun5i-a13-usb-phy";
 			reg = <0x01c13400 0x10 0x01c14800 0x4>;
@@ -336,7 +336,7 @@
 			status = "disabled";
 		};
 
-		ehci0: usb at 01c14000 {
+		ehci0: usb at 1c14000 {
 			compatible = "allwinner,sun5i-a13-ehci", "generic-ehci";
 			reg = <0x01c14000 0x100>;
 			interrupts = <39>;
@@ -346,7 +346,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at 01c14400 {
+		ohci0: usb at 1c14400 {
 			compatible = "allwinner,sun5i-a13-ohci", "generic-ohci";
 			reg = <0x01c14400 0x100>;
 			interrupts = <40>;
@@ -356,7 +356,7 @@
 			status = "disabled";
 		};
 
-		crypto: crypto-engine at 01c15000 {
+		crypto: crypto-engine at 1c15000 {
 			compatible = "allwinner,sun5i-a13-crypto",
 				     "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
@@ -365,7 +365,7 @@
 			clock-names = "ahb", "mod";
 		};
 
-		spi2: spi at 01c17000 {
+		spi2: spi at 1c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
 			interrupts = <12>;
@@ -379,7 +379,7 @@
 			#size-cells = <0>;
 		};
 
-		ccu: clock at 01c20000 {
+		ccu: clock at 1c20000 {
 			reg = <0x01c20000 0x400>;
 			clocks = <&osc24M>, <&osc32k>;
 			clock-names = "hosc", "losc";
@@ -387,14 +387,14 @@
 			#reset-cells = <1>;
 		};
 
-		intc: interrupt-controller at 01c20400 {
+		intc: interrupt-controller at 1c20400 {
 			compatible = "allwinner,sun4i-a10-ic";
 			reg = <0x01c20400 0x400>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
 		};
 
-		pio: pinctrl at 01c20800 {
+		pio: pinctrl at 1c20800 {
 			reg = <0x01c20800 0x400>;
 			interrupts = <28>;
 			clocks = <&ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
@@ -538,19 +538,19 @@
 			};
 		};
 
-		timer at 01c20c00 {
+		timer at 1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
 			clocks = <&ccu CLK_HOSC>;
 		};
 
-		wdt: watchdog at 01c20c90 {
+		wdt: watchdog at 1c20c90 {
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
-		ir0: ir at 01c21800 {
+		ir0: ir at 1c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&ccu CLK_APB0_IR>, <&ccu CLK_IR>;
 			clock-names = "apb", "ir";
@@ -559,14 +559,14 @@
 			status = "disabled";
 		};
 
-		lradc: lradc at 01c22800 {
+		lradc: lradc at 1c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
 			interrupts = <31>;
 			status = "disabled";
 		};
 
-		codec: codec at 01c22c00 {
+		codec: codec at 1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-codec";
 			reg = <0x01c22c00 0x40>;
@@ -579,19 +579,19 @@
 			status = "disabled";
 		};
 
-		sid: eeprom at 01c23800 {
+		sid: eeprom at 1c23800 {
 			compatible = "allwinner,sun4i-a10-sid";
 			reg = <0x01c23800 0x10>;
 		};
 
-		rtp: rtp at 01c25000 {
+		rtp: rtp at 1c25000 {
 			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <29>;
 			#thermal-sensor-cells = <0>;
 		};
 
-		uart0: serial at 01c28000 {
+		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <1>;
@@ -601,7 +601,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 01c28400 {
+		uart1: serial at 1c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
 			interrupts = <2>;
@@ -611,7 +611,7 @@
 			status = "disabled";
 		};
 
-		uart2: serial at 01c28800 {
+		uart2: serial at 1c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
 			interrupts = <3>;
@@ -621,7 +621,7 @@
 			status = "disabled";
 		};
 
-		uart3: serial at 01c28c00 {
+		uart3: serial at 1c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
 			interrupts = <4>;
@@ -631,7 +631,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 01c2ac00 {
+		i2c0: i2c at 1c2ac00 {
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
@@ -641,7 +641,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c1: i2c at 01c2b000 {
+		i2c1: i2c at 1c2b000 {
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
@@ -651,7 +651,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c2: i2c at 01c2b400 {
+		i2c2: i2c at 1c2b400 {
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
@@ -661,14 +661,14 @@
 			#size-cells = <0>;
 		};
 
-		timer at 01c60000 {
+		timer at 1c60000 {
 			compatible = "allwinner,sun5i-a13-hstimer";
 			reg = <0x01c60000 0x1000>;
 			interrupts = <82>, <83>;
 			clocks = <&ccu CLK_AHB_HSTIMER>;
 		};
 
-		fe0: display-frontend at 01e00000 {
+		fe0: display-frontend at 1e00000 {
 			compatible = "allwinner,sun5i-a13-display-frontend";
 			reg = <0x01e00000 0x20000>;
 			interrupts = <47>;
@@ -696,7 +696,7 @@
 			};
 		};
 
-		be0: display-backend at 01e60000 {
+		be0: display-backend at 1e60000 {
 			compatible = "allwinner,sun5i-a13-display-backend";
 			reg = <0x01e60000 0x10000>;
 			interrupts = <47>;
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 93209cda28db..ded5cf14a4af 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -221,7 +221,7 @@
 			clock-output-names = "gmac_int_tx";
 		};
 
-		gmac_tx_clk: clk at 01c200d0 {
+		gmac_tx_clk: clk at 1c200d0 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun7i-a20-gmac-clk";
 			reg = <0x01c200d0 0x4>;
@@ -236,13 +236,13 @@
 		status = "disabled";
 	};
 
-	soc at 01c00000 {
+	soc at 1c00000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
-		dma: dma-controller at 01c02000 {
+		dma: dma-controller at 1c02000 {
 			compatible = "allwinner,sun6i-a31-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
@@ -251,7 +251,7 @@
 			#dma-cells = <1>;
 		};
 
-		tcon0: lcd-controller at 01c0c000 {
+		tcon0: lcd-controller at 1c0c000 {
 			compatible = "allwinner,sun6i-a31-tcon";
 			reg = <0x01c0c000 0x1000>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
@@ -293,7 +293,7 @@
 			};
 		};
 
-		tcon1: lcd-controller at 01c0d000 {
+		tcon1: lcd-controller at 1c0d000 {
 			compatible = "allwinner,sun6i-a31-tcon";
 			reg = <0x01c0d000 0x1000>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
@@ -335,7 +335,7 @@
 			};
 		};
 
-		mmc0: mmc at 01c0f000 {
+		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ccu CLK_AHB1_MMC0>,
@@ -354,7 +354,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc1: mmc at 01c10000 {
+		mmc1: mmc at 1c10000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ccu CLK_AHB1_MMC1>,
@@ -373,7 +373,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc2: mmc at 01c11000 {
+		mmc2: mmc at 1c11000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ccu CLK_AHB1_MMC2>,
@@ -392,7 +392,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc3: mmc at 01c12000 {
+		mmc3: mmc at 1c12000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c12000 0x1000>;
 			clocks = <&ccu CLK_AHB1_MMC3>,
@@ -411,7 +411,7 @@
 			#size-cells = <0>;
 		};
 
-		usb_otg: usb at 01c19000 {
+		usb_otg: usb at 1c19000 {
 			compatible = "allwinner,sun6i-a31-musb";
 			reg = <0x01c19000 0x0400>;
 			clocks = <&ccu CLK_AHB1_OTG>;
@@ -424,7 +424,7 @@
 			status = "disabled";
 		};
 
-		usbphy: phy at 01c19400 {
+		usbphy: phy at 1c19400 {
 			compatible = "allwinner,sun6i-a31-usb-phy";
 			reg = <0x01c19400 0x10>,
 			      <0x01c1a800 0x4>,
@@ -448,7 +448,7 @@
 			#phy-cells = <1>;
 		};
 
-		ehci0: usb at 01c1a000 {
+		ehci0: usb at 1c1a000 {
 			compatible = "allwinner,sun6i-a31-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
@@ -459,7 +459,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at 01c1a400 {
+		ohci0: usb at 1c1a400 {
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1a400 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
@@ -470,7 +470,7 @@
 			status = "disabled";
 		};
 
-		ehci1: usb at 01c1b000 {
+		ehci1: usb at 1c1b000 {
 			compatible = "allwinner,sun6i-a31-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -481,7 +481,7 @@
 			status = "disabled";
 		};
 
-		ohci1: usb at 01c1b400 {
+		ohci1: usb at 1c1b400 {
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1b400 0x100>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -492,7 +492,7 @@
 			status = "disabled";
 		};
 
-		ohci2: usb at 01c1c400 {
+		ohci2: usb at 1c1c400 {
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
@@ -501,7 +501,7 @@
 			status = "disabled";
 		};
 
-		ccu: clock at 01c20000 {
+		ccu: clock at 1c20000 {
 			compatible = "allwinner,sun6i-a31-ccu";
 			reg = <0x01c20000 0x400>;
 			clocks = <&osc24M>, <&osc32k>;
@@ -510,7 +510,7 @@
 			#reset-cells = <1>;
 		};
 
-		pio: pinctrl at 01c20800 {
+		pio: pinctrl at 1c20800 {
 			compatible = "allwinner,sun6i-a31-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
@@ -643,7 +643,7 @@
 			};
 		};
 
-		timer at 01c20c00 {
+		timer at 1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
@@ -654,12 +654,12 @@
 			clocks = <&osc24M>;
 		};
 
-		wdt1: watchdog at 01c20ca0 {
+		wdt1: watchdog at 1c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 		};
 
-		spdif: spdif at 01c21000 {
+		spdif: spdif at 1c21000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun6i-a31-spdif";
 			reg = <0x01c21000 0x400>;
@@ -672,7 +672,7 @@
 			status = "disabled";
 		};
 
-		i2s0: i2s at 01c22000 {
+		i2s0: i2s at 1c22000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun6i-a31-i2s";
 			reg = <0x01c22000 0x400>;
@@ -685,7 +685,7 @@
 			status = "disabled";
 		};
 
-		i2s1: i2s at 01c22400 {
+		i2s1: i2s at 1c22400 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun6i-a31-i2s";
 			reg = <0x01c22400 0x400>;
@@ -698,21 +698,21 @@
 			status = "disabled";
 		};
 
-		lradc: lradc at 01c22800 {
+		lradc: lradc at 1c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
-		rtp: rtp at 01c25000 {
+		rtp: rtp at 1c25000 {
 			compatible = "allwinner,sun6i-a31-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			#thermal-sensor-cells = <0>;
 		};
 
-		uart0: serial at 01c28000 {
+		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
@@ -725,7 +725,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 01c28400 {
+		uart1: serial at 1c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
@@ -738,7 +738,7 @@
 			status = "disabled";
 		};
 
-		uart2: serial at 01c28800 {
+		uart2: serial at 1c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -751,7 +751,7 @@
 			status = "disabled";
 		};
 
-		uart3: serial at 01c28c00 {
+		uart3: serial at 1c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
@@ -764,7 +764,7 @@
 			status = "disabled";
 		};
 
-		uart4: serial at 01c29000 {
+		uart4: serial at 1c29000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29000 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
@@ -777,7 +777,7 @@
 			status = "disabled";
 		};
 
-		uart5: serial at 01c29400 {
+		uart5: serial at 1c29400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29400 0x400>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
@@ -790,7 +790,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 01c2ac00 {
+		i2c0: i2c at 1c2ac00 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
@@ -801,7 +801,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c1: i2c at 01c2b000 {
+		i2c1: i2c at 1c2b000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
@@ -812,7 +812,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c2: i2c at 01c2b400 {
+		i2c2: i2c at 1c2b400 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -823,7 +823,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c3: i2c at 01c2b800 {
+		i2c3: i2c at 1c2b800 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b800 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
@@ -834,7 +834,7 @@
 			#size-cells = <0>;
 		};
 
-		gmac: ethernet at 01c30000 {
+		gmac: ethernet at 1c30000 {
 			compatible = "allwinner,sun7i-a20-gmac";
 			reg = <0x01c30000 0x1054>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
@@ -851,7 +851,7 @@
 			#size-cells = <0>;
 		};
 
-		crypto: crypto-engine at 01c15000 {
+		crypto: crypto-engine at 1c15000 {
 			compatible = "allwinner,sun6i-a31-crypto",
 				     "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
@@ -862,7 +862,7 @@
 			reset-names = "ahb";
 		};
 
-		codec: codec at 01c22c00 {
+		codec: codec at 1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun6i-a31-codec";
 			reg = <0x01c22c00 0x400>;
@@ -875,7 +875,7 @@
 			status = "disabled";
 		};
 
-		timer at 01c60000 {
+		timer at 1c60000 {
 			compatible = "allwinner,sun6i-a31-hstimer",
 				     "allwinner,sun7i-a20-hstimer";
 			reg = <0x01c60000 0x1000>;
@@ -887,7 +887,7 @@
 			resets = <&ccu RST_AHB1_HSTIMER>;
 		};
 
-		spi0: spi at 01c68000 {
+		spi0: spi at 1c68000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c68000 0x1000>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
@@ -899,7 +899,7 @@
 			status = "disabled";
 		};
 
-		spi1: spi at 01c69000 {
+		spi1: spi at 1c69000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c69000 0x1000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
@@ -911,7 +911,7 @@
 			status = "disabled";
 		};
 
-		spi2: spi at 01c6a000 {
+		spi2: spi at 1c6a000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c6a000 0x1000>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
@@ -923,7 +923,7 @@
 			status = "disabled";
 		};
 
-		spi3: spi at 01c6b000 {
+		spi3: spi at 1c6b000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c6b000 0x1000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
@@ -935,7 +935,7 @@
 			status = "disabled";
 		};
 
-		gic: interrupt-controller at 01c81000 {
+		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
 			      <0x01c82000 0x2000>,
@@ -946,7 +946,7 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		fe0: display-frontend at 01e00000 {
+		fe0: display-frontend at 1e00000 {
 			compatible = "allwinner,sun6i-a31-display-frontend";
 			reg = <0x01e00000 0x20000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
@@ -978,7 +978,7 @@
 			};
 		};
 
-		fe1: display-frontend at 01e20000 {
+		fe1: display-frontend at 1e20000 {
 			compatible = "allwinner,sun6i-a31-display-frontend";
 			reg = <0x01e20000 0x20000>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
@@ -1010,7 +1010,7 @@
 			};
 		};
 
-		be1: display-backend at 01e40000 {
+		be1: display-backend at 1e40000 {
 			compatible = "allwinner,sun6i-a31-display-backend";
 			reg = <0x01e40000 0x10000>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
@@ -1056,7 +1056,7 @@
 			};
 		};
 
-		drc1: drc at 01e50000 {
+		drc1: drc at 1e50000 {
 			compatible = "allwinner,sun6i-a31-drc";
 			reg = <0x01e50000 0x10000>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
@@ -1102,7 +1102,7 @@
 			};
 		};
 
-		be0: display-backend at 01e60000 {
+		be0: display-backend at 1e60000 {
 			compatible = "allwinner,sun6i-a31-display-backend";
 			reg = <0x01e60000 0x10000>;
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
@@ -1148,7 +1148,7 @@
 			};
 		};
 
-		drc0: drc at 01e70000 {
+		drc0: drc at 1e70000 {
 			compatible = "allwinner,sun6i-a31-drc";
 			reg = <0x01e70000 0x10000>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
@@ -1194,7 +1194,7 @@
 			};
 		};
 
-		rtc: rtc at 01f00000 {
+		rtc: rtc at 1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
@@ -1209,7 +1209,7 @@
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		prcm at 01f01400 {
+		prcm at 1f01400 {
 			compatible = "allwinner,sun6i-a31-prcm";
 			reg = <0x01f01400 0x200>;
 
@@ -1261,12 +1261,12 @@
 			};
 		};
 
-		cpucfg at 01f01c00 {
+		cpucfg at 1f01c00 {
 			compatible = "allwinner,sun6i-a31-cpuconfig";
 			reg = <0x01f01c00 0x300>;
 		};
 
-		ir: ir at 01f02000 {
+		ir: ir at 1f02000 {
 			compatible = "allwinner,sun5i-a13-ir";
 			clocks = <&apb0_gates 1>, <&ir_clk>;
 			clock-names = "apb", "ir";
@@ -1276,7 +1276,7 @@
 			status = "disabled";
 		};
 
-		r_pio: pinctrl at 01f02c00 {
+		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun6i-a31-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
@@ -1301,7 +1301,7 @@
 			};
 		};
 
-		p2wi: i2c at 01f03400 {
+		p2wi: i2c at 1f03400 {
 			compatible = "allwinner,sun6i-a31-p2wi";
 			reg = <0x01f03400 0x400>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 39d0727bd9c3..2f63ae861e68 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -182,7 +182,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		osc24M: clk at 01c20050 {
+		osc24M: clk at 1c20050 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
@@ -219,7 +219,7 @@
 			clock-output-names = "gmac_int_tx";
 		};
 
-		gmac_tx_clk: clk at 01c20164 {
+		gmac_tx_clk: clk at 1c20164 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun7i-a20-gmac-clk";
 			reg = <0x01c20164 0x4>;
@@ -228,13 +228,13 @@
 		};
 	};
 
-	soc at 01c00000 {
+	soc at 1c00000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
-		sram-controller at 01c00000 {
+		sram-controller at 1c00000 {
 			compatible = "allwinner,sun4i-a10-sram-controller";
 			reg = <0x01c00000 0x30>;
 			#address-cells = <1>;
@@ -255,7 +255,7 @@
 				};
 			};
 
-			sram_d: sram at 00010000 {
+			sram_d: sram at 10000 {
 				compatible = "mmio-sram";
 				reg = <0x00010000 0x1000>;
 				#address-cells = <1>;
@@ -270,7 +270,7 @@
 			};
 		};
 
-		nmi_intc: interrupt-controller at 01c00030 {
+		nmi_intc: interrupt-controller at 1c00030 {
 			compatible = "allwinner,sun7i-a20-sc-nmi";
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -278,7 +278,7 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		dma: dma-controller at 01c02000 {
+		dma: dma-controller at 1c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
@@ -286,7 +286,7 @@
 			#dma-cells = <2>;
 		};
 
-		nfc: nand at 01c03000 {
+		nfc: nand at 1c03000 {
 			compatible = "allwinner,sun4i-a10-nand";
 			reg = <0x01c03000 0x1000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
@@ -299,7 +299,7 @@
 			#size-cells = <0>;
 		};
 
-		spi0: spi at 01c05000 {
+		spi0: spi at 1c05000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
@@ -314,7 +314,7 @@
 			num-cs = <4>;
 		};
 
-		spi1: spi at 01c06000 {
+		spi1: spi at 1c06000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c06000 0x1000>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
@@ -329,7 +329,7 @@
 			num-cs = <1>;
 		};
 
-		emac: ethernet at 01c0b000 {
+		emac: ethernet at 1c0b000 {
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
@@ -338,7 +338,7 @@
 			status = "disabled";
 		};
 
-		mdio: mdio at 01c0b080 {
+		mdio: mdio at 1c0b080 {
 			compatible = "allwinner,sun4i-a10-mdio";
 			reg = <0x01c0b080 0x14>;
 			status = "disabled";
@@ -346,7 +346,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc0: mmc at 01c0f000 {
+		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC0>,
@@ -363,7 +363,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc1: mmc at 01c10000 {
+		mmc1: mmc at 1c10000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC1>,
@@ -380,7 +380,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc2: mmc at 01c11000 {
+		mmc2: mmc at 1c11000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC2>,
@@ -397,7 +397,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc3: mmc at 01c12000 {
+		mmc3: mmc at 1c12000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c12000 0x1000>;
 			clocks = <&ccu CLK_AHB_MMC3>,
@@ -414,7 +414,7 @@
 			#size-cells = <0>;
 		};
 
-		usb_otg: usb at 01c13000 {
+		usb_otg: usb at 1c13000 {
 			compatible = "allwinner,sun4i-a10-musb";
 			reg = <0x01c13000 0x0400>;
 			clocks = <&ccu CLK_AHB_OTG>;
@@ -427,7 +427,7 @@
 			status = "disabled";
 		};
 
-		usbphy: phy at 01c13400 {
+		usbphy: phy at 1c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun7i-a20-usb-phy";
 			reg = <0x01c13400 0x10 0x01c14800 0x4 0x01c1c800 0x4>;
@@ -441,7 +441,7 @@
 			status = "disabled";
 		};
 
-		ehci0: usb at 01c14000 {
+		ehci0: usb at 1c14000 {
 			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
 			reg = <0x01c14000 0x100>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
@@ -451,7 +451,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at 01c14400 {
+		ohci0: usb at 1c14400 {
 			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
 			reg = <0x01c14400 0x100>;
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
@@ -461,7 +461,7 @@
 			status = "disabled";
 		};
 
-		crypto: crypto-engine at 01c15000 {
+		crypto: crypto-engine at 1c15000 {
 			compatible = "allwinner,sun7i-a20-crypto",
 				     "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
@@ -470,7 +470,7 @@
 			clock-names = "ahb", "mod";
 		};
 
-		spi2: spi at 01c17000 {
+		spi2: spi at 1c17000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
@@ -485,7 +485,7 @@
 			num-cs = <1>;
 		};
 
-		ahci: sata at 01c18000 {
+		ahci: sata at 1c18000 {
 			compatible = "allwinner,sun4i-a10-ahci";
 			reg = <0x01c18000 0x1000>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
@@ -493,7 +493,7 @@
 			status = "disabled";
 		};
 
-		ehci1: usb at 01c1c000 {
+		ehci1: usb at 1c1c000 {
 			compatible = "allwinner,sun7i-a20-ehci", "generic-ehci";
 			reg = <0x01c1c000 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
@@ -503,7 +503,7 @@
 			status = "disabled";
 		};
 
-		ohci1: usb at 01c1c400 {
+		ohci1: usb at 1c1c400 {
 			compatible = "allwinner,sun7i-a20-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
@@ -513,7 +513,7 @@
 			status = "disabled";
 		};
 
-		spi3: spi at 01c1f000 {
+		spi3: spi at 1c1f000 {
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
@@ -528,7 +528,7 @@
 			num-cs = <1>;
 		};
 
-		ccu: clock at 01c20000 {
+		ccu: clock at 1c20000 {
 			compatible = "allwinner,sun7i-a20-ccu";
 			reg = <0x01c20000 0x400>;
 			clocks = <&osc24M>, <&osc32k>;
@@ -537,7 +537,7 @@
 			#reset-cells = <1>;
 		};
 
-		pio: pinctrl at 01c20800 {
+		pio: pinctrl at 1c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
@@ -776,7 +776,7 @@
 			};
 		};
 
-		timer at 01c20c00 {
+		timer at 1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
@@ -788,18 +788,18 @@
 			clocks = <&osc24M>;
 		};
 
-		wdt: watchdog at 01c20c90 {
+		wdt: watchdog at 1c20c90 {
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 		};
 
-		rtc: rtc at 01c20d00 {
+		rtc: rtc at 1c20d00 {
 			compatible = "allwinner,sun7i-a20-rtc";
 			reg = <0x01c20d00 0x20>;
 			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pwm: pwm at 01c20e00 {
+		pwm: pwm at 1c20e00 {
 			compatible = "allwinner,sun7i-a20-pwm";
 			reg = <0x01c20e00 0xc>;
 			clocks = <&osc24M>;
@@ -807,7 +807,7 @@
 			status = "disabled";
 		};
 
-		spdif: spdif at 01c21000 {
+		spdif: spdif at 1c21000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-spdif";
 			reg = <0x01c21000 0x400>;
@@ -820,7 +820,7 @@
 			status = "disabled";
 		};
 
-		ir0: ir at 01c21800 {
+		ir0: ir at 1c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&ccu CLK_APB0_IR0>, <&ccu CLK_IR0>;
 			clock-names = "apb", "ir";
@@ -829,7 +829,7 @@
 			status = "disabled";
 		};
 
-		ir1: ir at 01c21c00 {
+		ir1: ir at 1c21c00 {
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&ccu CLK_APB0_IR1>, <&ccu CLK_IR1>;
 			clock-names = "apb", "ir";
@@ -838,7 +838,7 @@
 			status = "disabled";
 		};
 
-		i2s1: i2s at 01c22000 {
+		i2s1: i2s at 1c22000 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-i2s";
 			reg = <0x01c22000 0x400>;
@@ -851,7 +851,7 @@
 			status = "disabled";
 		};
 
-		i2s0: i2s at 01c22400 {
+		i2s0: i2s at 1c22400 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-i2s";
 			reg = <0x01c22400 0x400>;
@@ -864,14 +864,14 @@
 			status = "disabled";
 		};
 
-		lradc: lradc at 01c22800 {
+		lradc: lradc at 1c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
-		codec: codec at 01c22c00 {
+		codec: codec at 1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun7i-a20-codec";
 			reg = <0x01c22c00 0x40>;
@@ -884,12 +884,12 @@
 			status = "disabled";
 		};
 
-		sid: eeprom at 01c23800 {
+		sid: eeprom at 1c23800 {
 			compatible = "allwinner,sun7i-a20-sid";
 			reg = <0x01c23800 0x200>;
 		};
 
-		i2s2: i2s at 01c24400 {
+		i2s2: i2s at 1c24400 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun4i-a10-i2s";
 			reg = <0x01c24400 0x400>;
@@ -902,14 +902,14 @@
 			status = "disabled";
 		};
 
-		rtp: rtp at 01c25000 {
+		rtp: rtp at 1c25000 {
 			compatible = "allwinner,sun5i-a13-ts";
 			reg = <0x01c25000 0x100>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			#thermal-sensor-cells = <0>;
 		};
 
-		uart0: serial at 01c28000 {
+		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
@@ -919,7 +919,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 01c28400 {
+		uart1: serial at 1c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -929,7 +929,7 @@
 			status = "disabled";
 		};
 
-		uart2: serial at 01c28800 {
+		uart2: serial at 1c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
@@ -939,7 +939,7 @@
 			status = "disabled";
 		};
 
-		uart3: serial at 01c28c00 {
+		uart3: serial at 1c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
@@ -949,7 +949,7 @@
 			status = "disabled";
 		};
 
-		uart4: serial at 01c29000 {
+		uart4: serial at 1c29000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29000 0x400>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
@@ -959,7 +959,7 @@
 			status = "disabled";
 		};
 
-		uart5: serial at 01c29400 {
+		uart5: serial at 1c29400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29400 0x400>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
@@ -969,7 +969,7 @@
 			status = "disabled";
 		};
 
-		uart6: serial at 01c29800 {
+		uart6: serial at 1c29800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29800 0x400>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -979,7 +979,7 @@
 			status = "disabled";
 		};
 
-		uart7: serial at 01c29c00 {
+		uart7: serial at 1c29c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29c00 0x400>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -989,7 +989,7 @@
 			status = "disabled";
 		};
 
-		ps20: ps2 at 01c2a000 {
+		ps20: ps2 at 1c2a000 {
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a000 0x400>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
@@ -997,7 +997,7 @@
 			status = "disabled";
 		};
 
-		ps21: ps2 at 01c2a400 {
+		ps21: ps2 at 1c2a400 {
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a400 0x400>;
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
@@ -1005,7 +1005,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 01c2ac00 {
+		i2c0: i2c at 1c2ac00 {
 			compatible = "allwinner,sun7i-a20-i2c",
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
@@ -1016,7 +1016,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c1: i2c at 01c2b000 {
+		i2c1: i2c at 1c2b000 {
 			compatible = "allwinner,sun7i-a20-i2c",
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
@@ -1027,7 +1027,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c2: i2c at 01c2b400 {
+		i2c2: i2c at 1c2b400 {
 			compatible = "allwinner,sun7i-a20-i2c",
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
@@ -1038,7 +1038,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c3: i2c at 01c2b800 {
+		i2c3: i2c at 1c2b800 {
 			compatible = "allwinner,sun7i-a20-i2c",
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b800 0x400>;
@@ -1049,7 +1049,7 @@
 			#size-cells = <0>;
 		};
 
-		can0: can at 01c2bc00 {
+		can0: can at 1c2bc00 {
 			compatible = "allwinner,sun7i-a20-can",
 				     "allwinner,sun4i-a10-can";
 			reg = <0x01c2bc00 0x400>;
@@ -1058,7 +1058,7 @@
 			status = "disabled";
 		};
 
-		i2c4: i2c at 01c2c000 {
+		i2c4: i2c at 1c2c000 {
 			compatible = "allwinner,sun7i-a20-i2c",
 				     "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2c000 0x400>;
@@ -1069,7 +1069,7 @@
 			#size-cells = <0>;
 		};
 
-		gmac: ethernet at 01c50000 {
+		gmac: ethernet at 1c50000 {
 			compatible = "allwinner,sun7i-a20-gmac";
 			reg = <0x01c50000 0x10000>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -1084,7 +1084,7 @@
 			#size-cells = <0>;
 		};
 
-		hstimer at 01c60000 {
+		hstimer at 1c60000 {
 			compatible = "allwinner,sun7i-a20-hstimer";
 			reg = <0x01c60000 0x1000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
@@ -1094,7 +1094,7 @@
 			clocks = <&ccu CLK_AHB_HSTIMER>;
 		};
 
-		gic: interrupt-controller at 01c81000 {
+		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,gic-400", "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
 			      <0x01c82000 0x2000>,
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index ea50dda75adc..971f9be699a7 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -118,13 +118,13 @@
 		};
 	};
 
-	soc at 01c00000 {
+	soc at 1c00000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
-		dma: dma-controller at 01c02000 {
+		dma: dma-controller at 1c02000 {
 			compatible = "allwinner,sun8i-a23-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
@@ -133,7 +133,7 @@
 			#dma-cells = <1>;
 		};
 
-		mmc0: mmc at 01c0f000 {
+		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ccu CLK_BUS_MMC0>,
@@ -152,7 +152,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc1: mmc at 01c10000 {
+		mmc1: mmc at 1c10000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ccu CLK_BUS_MMC1>,
@@ -171,7 +171,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc2: mmc at 01c11000 {
+		mmc2: mmc at 1c11000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ccu CLK_BUS_MMC2>,
@@ -190,7 +190,7 @@
 			#size-cells = <0>;
 		};
 
-		nfc: nand at 01c03000 {
+		nfc: nand at 1c03000 {
 			compatible = "allwinner,sun4i-a10-nand";
 			reg = <0x01c03000 0x1000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
@@ -203,7 +203,7 @@
 			#size-cells = <0>;
 		};
 
-		usb_otg: usb at 01c19000 {
+		usb_otg: usb at 1c19000 {
 			/* compatible gets set in SoC specific dtsi file */
 			reg = <0x01c19000 0x0400>;
 			clocks = <&ccu CLK_BUS_OTG>;
@@ -216,7 +216,7 @@
 			status = "disabled";
 		};
 
-		usbphy: phy at 01c19400 {
+		usbphy: phy at 1c19400 {
 			/*
 			 * compatible and address regions get set in
 			 * SoC specific dtsi file
@@ -233,7 +233,7 @@
 			#phy-cells = <1>;
 		};
 
-		ehci0: usb at 01c1a000 {
+		ehci0: usb at 1c1a000 {
 			compatible = "allwinner,sun8i-a23-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
@@ -244,7 +244,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at 01c1a400 {
+		ohci0: usb at 1c1a400 {
 			compatible = "allwinner,sun8i-a23-ohci", "generic-ohci";
 			reg = <0x01c1a400 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
@@ -255,7 +255,7 @@
 			status = "disabled";
 		};
 
-		ccu: clock at 01c20000 {
+		ccu: clock at 1c20000 {
 			reg = <0x01c20000 0x400>;
 			clocks = <&osc24M>, <&rtc 0>;
 			clock-names = "hosc", "losc";
@@ -263,7 +263,7 @@
 			#reset-cells = <1>;
 		};
 
-		pio: pinctrl at 01c20800 {
+		pio: pinctrl at 1c20800 {
 			/* compatible gets set in SoC specific dtsi file */
 			reg = <0x01c20800 0x400>;
 			/* interrupts get set in SoC specific dtsi file */
@@ -344,7 +344,7 @@
 			};
 		};
 
-		timer at 01c20c00 {
+		timer at 1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
@@ -352,13 +352,13 @@
 			clocks = <&osc24M>;
 		};
 
-		wdt0: watchdog at 01c20ca0 {
+		wdt0: watchdog at 1c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pwm: pwm at 01c21400 {
+		pwm: pwm at 1c21400 {
 			compatible = "allwinner,sun7i-a20-pwm";
 			reg = <0x01c21400 0xc>;
 			clocks = <&osc24M>;
@@ -366,14 +366,14 @@
 			status = "disabled";
 		};
 
-		lradc: lradc at 01c22800 {
+		lradc: lradc at 1c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
-		uart0: serial at 01c28000 {
+		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
@@ -386,7 +386,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 01c28400 {
+		uart1: serial at 1c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
@@ -399,7 +399,7 @@
 			status = "disabled";
 		};
 
-		uart2: serial at 01c28800 {
+		uart2: serial at 1c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -412,7 +412,7 @@
 			status = "disabled";
 		};
 
-		uart3: serial at 01c28c00 {
+		uart3: serial at 1c28c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28c00 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
@@ -425,7 +425,7 @@
 			status = "disabled";
 		};
 
-		uart4: serial at 01c29000 {
+		uart4: serial at 1c29000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c29000 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
@@ -438,7 +438,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 01c2ac00 {
+		i2c0: i2c at 1c2ac00 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
@@ -449,7 +449,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c1: i2c at 01c2b000 {
+		i2c1: i2c at 1c2b000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
@@ -460,7 +460,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c2: i2c at 01c2b400 {
+		i2c2: i2c at 1c2b400 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -498,7 +498,7 @@
 			assigned-clock-rates = <384000000>;
 		};
 
-		gic: interrupt-controller at 01c81000 {
+		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
 			      <0x01c82000 0x2000>,
@@ -509,7 +509,7 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		rtc: rtc at 01f00000 {
+		rtc: rtc at 1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
@@ -527,7 +527,7 @@
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		prcm at 01f01400 {
+		prcm at 1f01400 {
 			compatible = "allwinner,sun8i-a23-prcm";
 			reg = <0x01f01400 0x200>;
 
@@ -575,12 +575,12 @@
 			};
 		};
 
-		cpucfg at 01f01c00 {
+		cpucfg at 1f01c00 {
 			compatible = "allwinner,sun8i-a23-cpuconfig";
 			reg = <0x01f01c00 0x300>;
 		};
 
-		r_uart: serial at 01f02800 {
+		r_uart: serial at 1f02800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01f02800 0x400>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -591,7 +591,7 @@
 			status = "disabled";
 		};
 
-		r_pio: pinctrl at 01f02c00 {
+		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun8i-a23-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
@@ -618,7 +618,7 @@
 			};
 		};
 
-		r_rsb: rsb at 01f03400 {
+		r_rsb: rsb at 1f03400 {
 			compatible = "allwinner,sun8i-a23-rsb";
 			reg = <0x01f03400 0x400>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 4d1f929780a8..58e6585b504b 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -49,8 +49,8 @@
 		reg = <0x40000000 0x40000000>;
 	};
 
-	soc at 01c00000 {
-		codec: codec at 01c22c00 {
+	soc at 1c00000 {
+		codec: codec at 1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-a23-codec";
 			reg = <0x01c22c00 0x400>;
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 22660919bd08..50eb84fa246a 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -203,8 +203,8 @@
 		};
 	};
 
-	soc at 01c00000 {
-		tcon0: lcd-controller at 01c0c000 {
+	soc at 1c00000 {
+		tcon0: lcd-controller at 1c0c000 {
 			compatible = "allwinner,sun8i-a33-tcon";
 			reg = <0x01c0c000 0x1000>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
@@ -240,7 +240,7 @@
 			};
 		};
 
-		crypto: crypto-engine at 01c15000 {
+		crypto: crypto-engine at 1c15000 {
 			compatible = "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
@@ -250,7 +250,7 @@
 			reset-names = "ahb";
 		};
 
-		dai: dai at 01c22c00 {
+		dai: dai at 1c22c00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun6i-a31-i2s";
 			reg = <0x01c22c00 0x200>;
@@ -263,7 +263,7 @@
 			status = "disabled";
 		};
 
-		codec: codec at 01c22e00 {
+		codec: codec at 1c22e00 {
 			#sound-dai-cells = <0>;
 			compatible = "allwinner,sun8i-a33-codec";
 			reg = <0x01c22e00 0x400>;
@@ -273,14 +273,14 @@
 			status = "disabled";
 		};
 
-		ths: ths at 01c25000 {
+		ths: ths at 1c25000 {
 			compatible = "allwinner,sun8i-a33-ths";
 			reg = <0x01c25000 0x100>;
 			#thermal-sensor-cells = <0>;
 			#io-channel-cells = <0>;
 		};
 
-		fe0: display-frontend at 01e00000 {
+		fe0: display-frontend at 1e00000 {
 			compatible = "allwinner,sun8i-a33-display-frontend";
 			reg = <0x01e00000 0x20000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
@@ -308,7 +308,7 @@
 			};
 		};
 
-		be0: display-backend at 01e60000 {
+		be0: display-backend at 1e60000 {
 			compatible = "allwinner,sun8i-a33-display-backend";
 			reg = <0x01e60000 0x10000>, <0x01e80000 0x1000>;
 			reg-names = "be", "sat";
@@ -350,7 +350,7 @@
 			};
 		};
 
-		drc0: drc at 01e70000 {
+		drc0: drc at 1e70000 {
 			compatible = "allwinner,sun8i-a33-drc";
 			reg = <0x01e70000 0x10000>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 3a06dc5b3746..443b083c6adc 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -178,7 +178,7 @@
 		};
 
 
-		mmc0: mmc at 01c0f000 {
+		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ccu CLK_BUS_MMC0>,
@@ -197,7 +197,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc1: mmc at 01c10000 {
+		mmc1: mmc at 1c10000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ccu CLK_BUS_MMC1>,
@@ -218,7 +218,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc2: mmc at 01c11000 {
+		mmc2: mmc at 1c11000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ccu CLK_BUS_MMC2>,
@@ -237,7 +237,7 @@
 			#size-cells = <0>;
 		};
 
-		usb_otg: usb at 01c19000 {
+		usb_otg: usb at 1c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x0400>;
 			clocks = <&ccu CLK_BUS_OTG>;
@@ -250,7 +250,7 @@
 			status = "disabled";
 		};
 
-		usbphy: phy at 01c19400 {
+		usbphy: phy at 1c19400 {
 			compatible = "allwinner,sun8i-v3s-usb-phy";
 			reg = <0x01c19400 0x2c>,
 			      <0x01c1a800 0x4>;
@@ -264,7 +264,7 @@
 			#phy-cells = <1>;
 		};
 
-		ccu: clock at 01c20000 {
+		ccu: clock at 1c20000 {
 			compatible = "allwinner,sun8i-v3s-ccu";
 			reg = <0x01c20000 0x400>;
 			clocks = <&osc24M>, <&osc32k>;
@@ -273,14 +273,14 @@
 			#reset-cells = <1>;
 		};
 
-		rtc: rtc at 01c20400 {
+		rtc: rtc at 1c20400 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01c20400 0x54>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pio: pinctrl at 01c20800 {
+		pio: pinctrl at 1c20800 {
 			compatible = "allwinner,sun8i-v3s-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
@@ -324,7 +324,7 @@
 			};
 		};
 
-		timer at 01c20c00 {
+		timer at 1c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
@@ -332,7 +332,7 @@
 			clocks = <&osc24M>;
 		};
 
-		wdt0: watchdog at 01c20ca0 {
+		wdt0: watchdog at 1c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
@@ -345,7 +345,7 @@
 			status = "disabled";
 		};
 
-		uart0: serial at 01c28000 {
+		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
@@ -356,7 +356,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 01c28400 {
+		uart1: serial at 1c28400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28400 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
@@ -367,7 +367,7 @@
 			status = "disabled";
 		};
 
-		uart2: serial at 01c28800 {
+		uart2: serial at 1c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -378,7 +378,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 01c2ac00 {
+		i2c0: i2c at 1c2ac00 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
@@ -391,7 +391,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c1: i2c at 01c2b000 {
+		i2c1: i2c at 1c2b000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
@@ -416,7 +416,7 @@
 			#size-cells = <0>;
 		};
 
-		gic: interrupt-controller at 01c81000 {
+		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
 			      <0x01c82000 0x1000>,
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 759a72317eb8..19b01d0bdc37 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -164,7 +164,7 @@
 			clock-output-names = "osc32k";
 		};
 
-		cpus_clk: clk at 08001410 {
+		cpus_clk: clk at 8001410 {
 			compatible = "allwinner,sun9i-a80-cpus-clk";
 			reg = <0x08001410 0x4>;
 			#clock-cells = <0>;
@@ -183,7 +183,7 @@
 			clock-output-names = "ahbs";
 		};
 
-		apbs: clk at 0800141c {
+		apbs: clk at 800141c {
 			compatible = "allwinner,sun8i-a23-apb0-clk";
 			reg = <0x0800141c 0x4>;
 			#clock-cells = <0>;
@@ -191,7 +191,7 @@
 			clock-output-names = "apbs";
 		};
 
-		apbs_gates: clk at 08001428 {
+		apbs_gates: clk at 8001428 {
 			compatible = "allwinner,sun9i-a80-apbs-gates-clk";
 			reg = <0x08001428 0x4>;
 			#clock-cells = <1>;
@@ -212,7 +212,7 @@
 					"apbs_i2s1", "apbs_twd";
 		};
 
-		r_1wire_clk: clk at 08001450 {
+		r_1wire_clk: clk at 8001450 {
 			reg = <0x08001450 0x4>;
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -220,7 +220,7 @@
 			clock-output-names = "r_1wire";
 		};
 
-		r_ir_clk: clk at 08001454 {
+		r_ir_clk: clk at 8001454 {
 			reg = <0x08001454 0x4>;
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -239,7 +239,7 @@
 		 */
 		ranges = <0 0 0 0x20000000>;
 
-		ehci0: usb at 00a00000 {
+		ehci0: usb at a00000 {
 			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
 			reg = <0x00a00000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
@@ -250,7 +250,7 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at 00a00400 {
+		ohci0: usb at a00400 {
 			compatible = "allwinner,sun9i-a80-ohci", "generic-ohci";
 			reg = <0x00a00400 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
@@ -262,7 +262,7 @@
 			status = "disabled";
 		};
 
-		usbphy1: phy at 00a00800 {
+		usbphy1: phy at a00800 {
 			compatible = "allwinner,sun9i-a80-usb-phy";
 			reg = <0x00a00800 0x4>;
 			clocks = <&usb_clocks CLK_USB0_PHY>;
@@ -273,7 +273,7 @@
 			#phy-cells = <0>;
 		};
 
-		ehci1: usb at 00a01000 {
+		ehci1: usb at a01000 {
 			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
 			reg = <0x00a01000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -284,7 +284,7 @@
 			status = "disabled";
 		};
 
-		usbphy2: phy at 00a01800 {
+		usbphy2: phy at a01800 {
 			compatible = "allwinner,sun9i-a80-usb-phy";
 			reg = <0x00a01800 0x4>;
 			clocks = <&usb_clocks CLK_USB1_HSIC>,
@@ -303,7 +303,7 @@
 			phy_type = "hsic";
 		};
 
-		ehci2: usb at 00a02000 {
+		ehci2: usb at a02000 {
 			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
 			reg = <0x00a02000 0x100>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
@@ -314,7 +314,7 @@
 			status = "disabled";
 		};
 
-		ohci2: usb at 00a02400 {
+		ohci2: usb at a02400 {
 			compatible = "allwinner,sun9i-a80-ohci", "generic-ohci";
 			reg = <0x00a02400 0x100>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
@@ -326,7 +326,7 @@
 			status = "disabled";
 		};
 
-		usbphy3: phy at 00a02800 {
+		usbphy3: phy at a02800 {
 			compatible = "allwinner,sun9i-a80-usb-phy";
 			reg = <0x00a02800 0x4>;
 			clocks = <&usb_clocks CLK_USB2_HSIC>,
@@ -343,7 +343,7 @@
 			#phy-cells = <0>;
 		};
 
-		usb_clocks: clock at 00a08000 {
+		usb_clocks: clock at a08000 {
 			compatible = "allwinner,sun9i-a80-usb-clks";
 			reg = <0x00a08000 0x8>;
 			clocks = <&ccu CLK_BUS_USB>, <&osc24M>;
@@ -352,7 +352,7 @@
 			#reset-cells = <1>;
 		};
 
-		mmc0: mmc at 01c0f000 {
+		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&mmc_config_clk 0>, <&ccu CLK_MMC0>,
@@ -367,7 +367,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc1: mmc at 01c10000 {
+		mmc1: mmc at 1c10000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&mmc_config_clk 1>, <&ccu CLK_MMC1>,
@@ -382,7 +382,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc2: mmc at 01c11000 {
+		mmc2: mmc at 1c11000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&mmc_config_clk 2>, <&ccu CLK_MMC2>,
@@ -397,7 +397,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc3: mmc at 01c12000 {
+		mmc3: mmc at 1c12000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c12000 0x1000>;
 			clocks = <&mmc_config_clk 3>, <&ccu CLK_MMC3>,
@@ -412,7 +412,7 @@
 			#size-cells = <0>;
 		};
 
-		mmc_config_clk: clk at 01c13000 {
+		mmc_config_clk: clk at 1c13000 {
 			compatible = "allwinner,sun9i-a80-mmc-config-clk";
 			reg = <0x01c13000 0x10>;
 			clocks = <&ccu CLK_BUS_MMC>;
@@ -425,7 +425,7 @@
 					     "mmc2_config", "mmc3_config";
 		};
 
-		gic: interrupt-controller at 01c41000 {
+		gic: interrupt-controller at 1c41000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c41000 0x1000>,
 			      <0x01c42000 0x2000>,
@@ -436,7 +436,7 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		de_clocks: clock at 03000000 {
+		de_clocks: clock at 3000000 {
 			compatible = "allwinner,sun9i-a80-de-clks";
 			reg = <0x03000000 0x30>;
 			clocks = <&ccu CLK_DE>,
@@ -450,7 +450,7 @@
 			#reset-cells = <1>;
 		};
 
-		ccu: clock at 06000000 {
+		ccu: clock at 6000000 {
 			compatible = "allwinner,sun9i-a80-ccu";
 			reg = <0x06000000 0x800>;
 			clocks = <&osc24M>, <&osc32k>;
@@ -459,7 +459,7 @@
 			#reset-cells = <1>;
 		};
 
-		timer at 06000c00 {
+		timer at 6000c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x06000c00 0xa0>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
@@ -472,13 +472,13 @@
 			clocks = <&osc24M>;
 		};
 
-		wdt: watchdog at 06000ca0 {
+		wdt: watchdog at 6000ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x06000ca0 0x20>;
 			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pio: pinctrl at 06000800 {
+		pio: pinctrl at 6000800 {
 			compatible = "allwinner,sun9i-a80-pinctrl";
 			reg = <0x06000800 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
@@ -536,7 +536,7 @@
 			};
 		};
 
-		uart0: serial at 07000000 {
+		uart0: serial at 7000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07000000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
@@ -547,7 +547,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 07000400 {
+		uart1: serial at 7000400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07000400 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
@@ -558,7 +558,7 @@
 			status = "disabled";
 		};
 
-		uart2: serial at 07000800 {
+		uart2: serial at 7000800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07000800 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -569,7 +569,7 @@
 			status = "disabled";
 		};
 
-		uart3: serial at 07000c00 {
+		uart3: serial at 7000c00 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07000c00 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
@@ -580,7 +580,7 @@
 			status = "disabled";
 		};
 
-		uart4: serial at 07001000 {
+		uart4: serial at 7001000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07001000 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
@@ -591,7 +591,7 @@
 			status = "disabled";
 		};
 
-		uart5: serial at 07001400 {
+		uart5: serial at 7001400 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07001400 0x400>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
@@ -602,7 +602,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 07002800 {
+		i2c0: i2c at 7002800 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07002800 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
@@ -613,7 +613,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c1: i2c at 07002c00 {
+		i2c1: i2c at 7002c00 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07002c00 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
@@ -624,7 +624,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c2: i2c at 07003000 {
+		i2c2: i2c at 7003000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07003000 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -635,7 +635,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c3: i2c at 07003400 {
+		i2c3: i2c at 7003400 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07003400 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
@@ -646,7 +646,7 @@
 			#size-cells = <0>;
 		};
 
-		i2c4: i2c at 07003800 {
+		i2c4: i2c at 7003800 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07003800 0x400>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
@@ -657,19 +657,19 @@
 			#size-cells = <0>;
 		};
 
-		r_wdt: watchdog at 08001000 {
+		r_wdt: watchdog at 8001000 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x08001000 0x20>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		apbs_rst: reset at 080014b0 {
+		apbs_rst: reset at 80014b0 {
 			reg = <0x080014b0 0x4>;
 			compatible = "allwinner,sun6i-a31-clock-reset";
 			#reset-cells = <1>;
 		};
 
-		nmi_intc: interrupt-controller at 080015a0 {
+		nmi_intc: interrupt-controller at 80015a0 {
 			compatible = "allwinner,sun9i-a80-nmi";
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -677,7 +677,7 @@
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		r_ir: ir at 08002000 {
+		r_ir: ir at 8002000 {
 			compatible = "allwinner,sun5i-a13-ir";
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
@@ -689,7 +689,7 @@
 			status = "disabled";
 		};
 
-		r_uart: serial at 08002800 {
+		r_uart: serial at 8002800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x08002800 0x400>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -700,7 +700,7 @@
 			status = "disabled";
 		};
 
-		r_pio: pinctrl at 08002c00 {
+		r_pio: pinctrl at 8002c00 {
 			compatible = "allwinner,sun9i-a80-r-pinctrl";
 			reg = <0x08002c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
@@ -726,7 +726,7 @@
 			};
 		};
 
-		r_rsb: i2c at 08003400 {
+		r_rsb: i2c at 8003400 {
 			compatible = "allwinner,sun8i-a23-rsb";
 			reg = <0x08003400 0x400>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-- 
git-series 0.9.1
