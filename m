From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:03 +0100
Subject: [PATCH 44/52] ARM: dts: r7s72100: sort subnodes of soc node
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <6d230c54736aade8cf668d0d25380342c63f9a1d.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort the subnodes of the soc node to improve maintainability.
The sort key is the address on the bus with instances of the same
IP block grouped together and sorted alphabetically.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r7s72100.dtsi | 570 ++++++++++++++++++++--------------------
 1 file changed, 285 insertions(+), 285 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 0aa74355e24f..0d63dbe11e0d 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -110,187 +110,14 @@
 		#size-cells = <1>;
 		ranges;
 
-		/* Special CPG clocks */
-		cpg_clocks: cpg_clocks at fcfe0000 {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-cpg-clocks",
-				     "renesas,rz-cpg-clocks";
-			reg = <0xfcfe0000 0x18>;
-			clocks = <&extal_clk>, <&usb_x1_clk>;
-			clock-output-names = "pll", "i", "g";
-			#power-domain-cells = <0>;
-		};
-
-		/* MSTP clocks */
-		mstp3_clks: mstp3_clks at fcfe0420 {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0xfcfe0420 4>;
-			clocks = <&p0_clk>;
-			clock-indices = <R7S72100_CLK_MTU2>;
-			clock-output-names = "mtu2";
-		};
-
-		mstp4_clks: mstp4_clks at fcfe0424 {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0xfcfe0424 4>;
-			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>,
-				 <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>;
-			clock-indices = <
-				R7S72100_CLK_SCIF0 R7S72100_CLK_SCIF1 R7S72100_CLK_SCIF2 R7S72100_CLK_SCIF3
-				R7S72100_CLK_SCIF4 R7S72100_CLK_SCIF5 R7S72100_CLK_SCIF6 R7S72100_CLK_SCIF7
-			>;
-			clock-output-names = "scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scif6", "scif7";
-		};
-
-		mstp5_clks: mstp5_clks at fcfe0428 {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0xfcfe0428 4>;
-			clocks = <&p0_clk>, <&p0_clk>;
-			clock-indices = <R7S72100_CLK_OSTM0 R7S72100_CLK_OSTM1>;
-			clock-output-names = "ostm0", "ostm1";
-		};
-
-		mstp6_clks: mstp6_clks at fcfe042c {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0xfcfe042c 4>;
-			clocks = <&p0_clk>;
-			clock-indices = <R7S72100_CLK_RTC>;
-			clock-output-names = "rtc";
-		};
-
-		mstp7_clks: mstp7_clks at fcfe0430 {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0xfcfe0430 4>;
-			clocks = <&b_clk>, <&p1_clk>, <&p1_clk>;
-			clock-indices = <R7S72100_CLK_ETHER R7S72100_CLK_USB0 R7S72100_CLK_USB1>;
-			clock-output-names = "ether", "usb0", "usb1";
-		};
-
-		mstp8_clks: mstp8_clks at fcfe0434 {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0xfcfe0434 4>;
-			clocks = <&p1_clk>;
-			clock-indices = <R7S72100_CLK_MMCIF>;
-			clock-output-names = "mmcif";
-		};
-
-		mstp9_clks: mstp9_clks at fcfe0438 {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0xfcfe0438 4>;
-			clocks = <&p0_clk>, <&p0_clk>, <&p0_clk>, <&p0_clk>;
-			clock-indices = <
-				R7S72100_CLK_I2C0 R7S72100_CLK_I2C1 R7S72100_CLK_I2C2 R7S72100_CLK_I2C3
-			>;
-			clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3";
-		};
-
-		mstp10_clks: mstp10_clks at fcfe043c {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0xfcfe043c 4>;
-			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>,
-				 <&p1_clk>;
-			clock-indices = <
-				R7S72100_CLK_SPI0 R7S72100_CLK_SPI1 R7S72100_CLK_SPI2 R7S72100_CLK_SPI3
-				R7S72100_CLK_SPI4
-			>;
-			clock-output-names = "spi0", "spi1", "spi2", "spi3", "spi4";
-		};
-		mstp12_clks: mstp12_clks at fcfe0444 {
-			#clock-cells = <1>;
-			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
-			reg = <0xfcfe0444 4>;
-			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>;
-			clock-indices = <
-				R7S72100_CLK_SDHI00 R7S72100_CLK_SDHI01
-				R7S72100_CLK_SDHI10 R7S72100_CLK_SDHI11
-			>;
-			clock-output-names = "sdhi00", "sdhi01", "sdhi10", "sdhi11";
-		};
-
-		pinctrl: pin-controller at fcfe3000 {
-			compatible = "renesas,r7s72100-ports";
-
-			reg = <0xfcfe3000 0x4230>;
-
-			port0: gpio-0 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 0 6>;
-			};
-
-			port1: gpio-1 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 16 16>;
-			};
-
-			port2: gpio-2 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 32 16>;
-			};
-
-			port3: gpio-3 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 48 16>;
-			};
-
-			port4: gpio-4 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 64 16>;
-			};
-
-			port5: gpio-5 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 80 11>;
-			};
-
-			port6: gpio-6 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 96 16>;
-			};
-
-			port7: gpio-7 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 112 16>;
-			};
-
-			port8: gpio-8 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 128 16>;
-			};
-
-			port9: gpio-9 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 144 8>;
-			};
-
-			port10: gpio-10 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 160 16>;
-			};
-
-			port11: gpio-11 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				gpio-ranges = <&pinctrl 0 176 16>;
-			};
+		L2: cache-controller at 3ffff000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x3ffff000 0x1000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			arm,early-bresp-disable;
+			arm,full-line-zero-disable;
+			cache-unified;
+			cache-level = <2>;
 		};
 
 		scif0: serial at e8007000 {
@@ -472,6 +299,71 @@
 			status = "disabled";
 		};
 
+		usbhs0: usb at e8010000 {
+			compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
+			reg = <0xe8010000 0x1a0>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R7S72100_CLK_USB0>;
+			renesas,buswait = <4>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		usbhs1: usb at e8207000 {
+			compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
+			reg = <0xe8207000 0x1a0>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R7S72100_CLK_USB1>;
+			renesas,buswait = <4>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		mmcif: mmc at e804c800 {
+			compatible = "renesas,mmcif-r7s72100", "renesas,sh-mmcif";
+			reg = <0xe804c800 0x80>;
+			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp8_clks R7S72100_CLK_MMCIF>;
+			power-domains = <&cpg_clocks>;
+			reg-io-width = <4>;
+			bus-width = <8>;
+			status = "disabled";
+		};
+
+		sdhi0: sd at e804e000 {
+			compatible = "renesas,sdhi-r7s72100";
+			reg = <0xe804e000 0x100>;
+			interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&mstp12_clks R7S72100_CLK_SDHI00>,
+				 <&mstp12_clks R7S72100_CLK_SDHI01>;
+			clock-names = "core", "cd";
+			power-domains = <&cpg_clocks>;
+			cap-sd-highspeed;
+			cap-sdio-irq;
+			status = "disabled";
+		};
+
+		sdhi1: sd at e804e800 {
+			compatible = "renesas,sdhi-r7s72100";
+			reg = <0xe804e800 0x100>;
+			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&mstp12_clks R7S72100_CLK_SDHI10>,
+				 <&mstp12_clks R7S72100_CLK_SDHI11>;
+			clock-names = "core", "cd";
+			power-domains = <&cpg_clocks>;
+			cap-sd-highspeed;
+			cap-sdio-irq;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at e8201000 {
 			compatible = "arm,pl390";
 			#interrupt-cells = <3>;
@@ -481,14 +373,17 @@
 				<0xe8202000 0x1000>;
 		};
 
-		L2: cache-controller at 3ffff000 {
-			compatible = "arm,pl310-cache";
-			reg = <0x3ffff000 0x1000>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			arm,early-bresp-disable;
-			arm,full-line-zero-disable;
-			cache-unified;
-			cache-level = <2>;
+		ether: ethernet at e8203000 {
+			compatible = "renesas,ether-r7s72100";
+			reg = <0xe8203000 0x800>,
+			      <0xe8204800 0x200>;
+			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R7S72100_CLK_ETHER>;
+			power-domains = <&cpg_clocks>;
+			phy-mode = "mii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		wdt: watchdog at fcfe0000 {
@@ -498,6 +393,207 @@
 			clocks = <&p0_clk>;
 		};
 
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks at fcfe0000 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-cpg-clocks",
+				     "renesas,rz-cpg-clocks";
+			reg = <0xfcfe0000 0x18>;
+			clocks = <&extal_clk>, <&usb_x1_clk>;
+			clock-output-names = "pll", "i", "g";
+			#power-domain-cells = <0>;
+		};
+
+		/* MSTP clocks */
+		mstp3_clks: mstp3_clks at fcfe0420 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0420 4>;
+			clocks = <&p0_clk>;
+			clock-indices = <R7S72100_CLK_MTU2>;
+			clock-output-names = "mtu2";
+		};
+
+		mstp4_clks: mstp4_clks at fcfe0424 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0424 4>;
+			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>,
+				 <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>;
+			clock-indices = <
+				R7S72100_CLK_SCIF0 R7S72100_CLK_SCIF1 R7S72100_CLK_SCIF2 R7S72100_CLK_SCIF3
+				R7S72100_CLK_SCIF4 R7S72100_CLK_SCIF5 R7S72100_CLK_SCIF6 R7S72100_CLK_SCIF7
+			>;
+			clock-output-names = "scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scif6", "scif7";
+		};
+
+		mstp5_clks: mstp5_clks at fcfe0428 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0428 4>;
+			clocks = <&p0_clk>, <&p0_clk>;
+			clock-indices = <R7S72100_CLK_OSTM0 R7S72100_CLK_OSTM1>;
+			clock-output-names = "ostm0", "ostm1";
+		};
+
+		mstp6_clks: mstp6_clks at fcfe042c {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe042c 4>;
+			clocks = <&p0_clk>;
+			clock-indices = <R7S72100_CLK_RTC>;
+			clock-output-names = "rtc";
+		};
+
+		mstp7_clks: mstp7_clks at fcfe0430 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0430 4>;
+			clocks = <&b_clk>, <&p1_clk>, <&p1_clk>;
+			clock-indices = <R7S72100_CLK_ETHER R7S72100_CLK_USB0 R7S72100_CLK_USB1>;
+			clock-output-names = "ether", "usb0", "usb1";
+		};
+
+		mstp8_clks: mstp8_clks at fcfe0434 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0434 4>;
+			clocks = <&p1_clk>;
+			clock-indices = <R7S72100_CLK_MMCIF>;
+			clock-output-names = "mmcif";
+		};
+
+		mstp9_clks: mstp9_clks at fcfe0438 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0438 4>;
+			clocks = <&p0_clk>, <&p0_clk>, <&p0_clk>, <&p0_clk>;
+			clock-indices = <
+				R7S72100_CLK_I2C0 R7S72100_CLK_I2C1 R7S72100_CLK_I2C2 R7S72100_CLK_I2C3
+			>;
+			clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3";
+		};
+
+		mstp10_clks: mstp10_clks at fcfe043c {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe043c 4>;
+			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>,
+				 <&p1_clk>;
+			clock-indices = <
+				R7S72100_CLK_SPI0 R7S72100_CLK_SPI1 R7S72100_CLK_SPI2 R7S72100_CLK_SPI3
+				R7S72100_CLK_SPI4
+			>;
+			clock-output-names = "spi0", "spi1", "spi2", "spi3", "spi4";
+		};
+		mstp12_clks: mstp12_clks at fcfe0444 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0444 4>;
+			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>;
+			clock-indices = <
+				R7S72100_CLK_SDHI00 R7S72100_CLK_SDHI01
+				R7S72100_CLK_SDHI10 R7S72100_CLK_SDHI11
+			>;
+			clock-output-names = "sdhi00", "sdhi01", "sdhi10", "sdhi11";
+		};
+
+		pinctrl: pin-controller at fcfe3000 {
+			compatible = "renesas,r7s72100-ports";
+
+			reg = <0xfcfe3000 0x4230>;
+
+			port0: gpio-0 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 0 6>;
+			};
+
+			port1: gpio-1 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 16 16>;
+			};
+
+			port2: gpio-2 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 32 16>;
+			};
+
+			port3: gpio-3 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 48 16>;
+			};
+
+			port4: gpio-4 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 64 16>;
+			};
+
+			port5: gpio-5 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 80 11>;
+			};
+
+			port6: gpio-6 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 96 16>;
+			};
+
+			port7: gpio-7 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 112 16>;
+			};
+
+			port8: gpio-8 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 128 16>;
+			};
+
+			port9: gpio-9 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 144 8>;
+			};
+
+			port10: gpio-10 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 160 16>;
+			};
+
+			port11: gpio-11 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl 0 176 16>;
+			};
+		};
+
+		ostm0: timer at fcfec000 {
+			compatible = "renesas,r7s72100-ostm", "renesas,ostm";
+			reg = <0xfcfec000 0x30>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&mstp5_clks R7S72100_CLK_OSTM0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		ostm1: timer at fcfec400 {
+			compatible = "renesas,r7s72100-ostm", "renesas,ostm";
+			reg = <0xfcfec400 0x30>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&mstp5_clks R7S72100_CLK_OSTM1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at fcfee000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -585,82 +681,6 @@
 			status = "disabled";
 		};
 
-		ether: ethernet at e8203000 {
-			compatible = "renesas,ether-r7s72100";
-			reg = <0xe8203000 0x800>,
-			      <0xe8204800 0x200>;
-			interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R7S72100_CLK_ETHER>;
-			power-domains = <&cpg_clocks>;
-			phy-mode = "mii";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		mmcif: mmc at e804c800 {
-			compatible = "renesas,mmcif-r7s72100", "renesas,sh-mmcif";
-			reg = <0xe804c800 0x80>;
-			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp8_clks R7S72100_CLK_MMCIF>;
-			power-domains = <&cpg_clocks>;
-			reg-io-width = <4>;
-			bus-width = <8>;
-			status = "disabled";
-		};
-
-		sdhi0: sd at e804e000 {
-			compatible = "renesas,sdhi-r7s72100";
-			reg = <0xe804e000 0x100>;
-			interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
-
-			clocks = <&mstp12_clks R7S72100_CLK_SDHI00>,
-				 <&mstp12_clks R7S72100_CLK_SDHI01>;
-			clock-names = "core", "cd";
-			power-domains = <&cpg_clocks>;
-			cap-sd-highspeed;
-			cap-sdio-irq;
-			status = "disabled";
-		};
-
-		sdhi1: sd at e804e800 {
-			compatible = "renesas,sdhi-r7s72100";
-			reg = <0xe804e800 0x100>;
-			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>;
-
-			clocks = <&mstp12_clks R7S72100_CLK_SDHI10>,
-				 <&mstp12_clks R7S72100_CLK_SDHI11>;
-			clock-names = "core", "cd";
-			power-domains = <&cpg_clocks>;
-			cap-sd-highspeed;
-			cap-sdio-irq;
-			status = "disabled";
-		};
-
-		ostm0: timer at fcfec000 {
-			compatible = "renesas,r7s72100-ostm", "renesas,ostm";
-			reg = <0xfcfec000 0x30>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&mstp5_clks R7S72100_CLK_OSTM0>;
-			power-domains = <&cpg_clocks>;
-			status = "disabled";
-		};
-
-		ostm1: timer at fcfec400 {
-			compatible = "renesas,r7s72100-ostm", "renesas,ostm";
-			reg = <0xfcfec400 0x30>;
-			interrupts = <GIC_SPI 103 IRQ_TYPE_EDGE_RISING>;
-			clocks = <&mstp5_clks R7S72100_CLK_OSTM1>;
-			power-domains = <&cpg_clocks>;
-			status = "disabled";
-		};
-
 		rtc: rtc at fcff1000 {
 			compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
 			reg = <0xfcff1000 0x2e>;
@@ -674,25 +694,5 @@
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
-
-		usbhs0: usb at e8010000 {
-			compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
-			reg = <0xe8010000 0x1a0>;
-			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R7S72100_CLK_USB0>;
-			renesas,buswait = <4>;
-			power-domains = <&cpg_clocks>;
-			status = "disabled";
-		};
-
-		usbhs1: usb at e8207000 {
-			compatible = "renesas,usbhs-r7s72100", "renesas,rza1-usbhs";
-			reg = <0xe8207000 0x1a0>;
-			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&mstp7_clks R7S72100_CLK_USB1>;
-			renesas,buswait = <4>;
-			power-domains = <&cpg_clocks>;
-			status = "disabled";
-		};
 	};
 };
-- 
2.11.0
