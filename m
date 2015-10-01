From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:47 +0200
Subject: [PATCH 10/16] ARM: dts: lpc18xx: add resets entry to device nodes
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-11-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the peripherals on LPC18xx/43xx devices have their reset
lines hooked up to internal reset controller (RGU). Add reset
entries to the device nodes so a driver can use the reset line.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 19c6f2951129..52591d83e8cd 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -115,6 +115,7 @@
 			num-slots = <1>;
 			clocks = <&ccu2 CLK_SDIO>, <&ccu1 CLK_CPU_SDIO>;
 			clock-names = "ciu", "biu";
+			resets = <&rgu 20>;
 			status = "disabled";
 		};
 
@@ -123,6 +124,7 @@
 			reg = <0x40006100 0x100>;
 			interrupts = <8>;
 			clocks = <&ccu1 CLK_CPU_USB0>;
+			resets = <&rgu 17>;
 			phys = <&usb0_otg_phy>;
 			phy-names = "usb";
 			has-transaction-translator;
@@ -134,6 +136,7 @@
 			reg = <0x40007100 0x100>;
 			interrupts = <9>;
 			clocks = <&ccu1 CLK_CPU_USB1>;
+			resets = <&rgu 18>;
 			status = "disabled";
 		};
 
@@ -142,6 +145,7 @@
 			reg = <0x40005000 0x1000>;
 			clocks = <&ccu1 CLK_CPU_EMCDIV>, <&ccu1 CLK_CPU_EMC>;
 			clock-names = "mpmcclk", "apb_pclk";
+			resets = <&rgu 21>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 			ranges = <0 0 0x1c000000 0x1000000
@@ -158,6 +162,7 @@
 			interrupt-names = "combined";
 			clocks = <&cgu BASE_LCD_CLK>, <&ccu1 CLK_CPU_LCD>;
 			clock-names = "clcdclk", "apb_pclk";
+			resets = <&rgu 16>;
 			status = "disabled";
 		};
 
@@ -168,6 +173,8 @@
 			interrupt-names	= "macirq";
 			clocks = <&ccu1 CLK_CPU_ETHERNET>;
 			clock-names = "stmmaceth";
+			resets = <&rgu 22>;
+			reset-names = "stmmaceth";
 			status = "disabled";
 		};
 
@@ -175,6 +182,7 @@
 			compatible = "nxp,lpc1850-creg", "syscon", "simple-mfd";
 			reg = <0x40043000 0x1000>;
 			clocks = <&ccu1 CLK_CPU_CREG>;
+			resets = <&rgu 5>;
 
 			usb0_otg_phy: phy at 004 {
 				compatible = "nxp,lpc1850-usb-otg-phy";
@@ -248,6 +256,7 @@
 			interrupts = <24>;
 			clocks = <&ccu2 CLK_APB0_UART0>, <&ccu1 CLK_CPU_UART0>;
 			clock-names = "uartclk", "reg";
+			resets = <&rgu 44>;
 			dmas = <&dmamux  1 1 2
 				&dmamux  2 1 2
 				&dmamux 11 2 2
@@ -263,6 +272,7 @@
 			interrupts = <25>;
 			clocks = <&ccu2 CLK_APB0_UART1>, <&ccu1 CLK_CPU_UART1>;
 			clock-names = "uartclk", "reg";
+			resets = <&rgu 45>;
 			dmas = <&dmamux 3 1 2
 				&dmamux 4 1 2>;
 			dma-names = "tx", "rx";
@@ -275,6 +285,7 @@
 			interrupts = <22>;
 			clocks = <&ccu2 CLK_APB0_SSP0>, <&ccu1 CLK_CPU_SSP0>;
 			clock-names = "sspclk", "apb_pclk";
+			resets = <&rgu 50>;
 			dmas = <&dmamux  9 0 2
 				&dmamux 10 0 2>;
 			dma-names = "rx", "tx";
@@ -289,6 +300,7 @@
 			interrupts = <12>;
 			clocks = <&ccu1 CLK_CPU_TIMER0>;
 			clock-names = "timerclk";
+			resets = <&rgu 32>;
 		};
 
 		timer1: timer at 40085000 {
@@ -297,6 +309,7 @@
 			interrupts = <13>;
 			clocks = <&ccu1 CLK_CPU_TIMER1>;
 			clock-names = "timerclk";
+			resets = <&rgu 33>;
 		};
 
 		pinctrl: pinctrl at 40086000 {
@@ -321,6 +334,7 @@
 			reg = <0x400a4000 0x1000>;
 			interrupts = <43>;
 			clocks = <&ccu1 CLK_APB1_CAN1>;
+			resets = <&rgu 54>;
 			status = "disabled";
 		};
 
@@ -331,6 +345,7 @@
 			interrupts = <26>;
 			clocks = <&ccu2 CLK_APB2_UART2>, <&ccu1 CLK_CPU_UART2>;
 			clock-names = "uartclk", "reg";
+			resets = <&rgu 46>;
 			dmas = <&dmamux 5 1 2
 				&dmamux 6 1 2>;
 			dma-names = "tx", "rx";
@@ -344,6 +359,7 @@
 			interrupts = <27>;
 			clocks = <&ccu2 CLK_APB2_UART3>, <&ccu1 CLK_CPU_UART3>;
 			clock-names = "uartclk", "reg";
+			resets = <&rgu 47>;
 			dmas = <&dmamux  7 1 2
 				&dmamux  8 1 2
 				&dmamux 13 3 2
@@ -358,6 +374,7 @@
 			interrupts = <14>;
 			clocks = <&ccu1 CLK_CPU_TIMER2>;
 			clock-names = "timerclk";
+			resets = <&rgu 34>;
 		};
 
 		timer3: timer at 400c4000 {
@@ -366,6 +383,7 @@
 			interrupts = <15>;
 			clocks = <&ccu1 CLK_CPU_TIMER3>;
 			clock-names = "timerclk";
+			resets = <&rgu 35>;
 		};
 
 		ssp1: spi at 400c5000 {
@@ -374,6 +392,7 @@
 			interrupts = <23>;
 			clocks = <&ccu2 CLK_APB2_SSP1>, <&ccu1 CLK_CPU_SSP1>;
 			clock-names = "sspclk", "apb_pclk";
+			resets = <&rgu 51>;
 			dmas = <&dmamux 11 2 2
 				&dmamux 12 2 2
 				&dmamux  3 3 2
@@ -405,6 +424,7 @@
 			reg = <0x400e2000 0x1000>;
 			interrupts = <51>;
 			clocks = <&ccu1 CLK_APB3_CAN0>;
+			resets = <&rgu 55>;
 			status = "disabled";
 		};
 
-- 
1.8.0
