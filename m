From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Sep 2014 09:37:52 +0200
Subject: [PATCH 4/4] ARM: nomadik: add DMA support
Message-ID: <1410507472-32530-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds DMA controller entries for the two PL08x blocks on the
Nomadik, assigns the fixed signal names, and defines channels
for UART and MMC/SD. Tested on the S8815 USB dongle.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 296 +++++++++++++++++++++++++++++
 1 file changed, 296 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index dbcf521b017f..8ffe68d9f670 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -794,6 +794,10 @@
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_default_mux>;
+			dmas = <&dmac0 14>,
+			       <&dmac0 15>;
+			dma-names = "rx", "tx";
+
 		};
 
 		uart1: uart at 101fb000 {
@@ -805,6 +809,9 @@
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_default_mux>;
+			dmas = <&dmac1 22>,
+			       <&dmac1 23>;
+			dma-names = "rx", "tx";
 		};
 
 		uart2: uart at 101f2000 {
@@ -848,6 +855,295 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmcsd_default_mux>, <&mmcsd_default_mode>;
 			vmmc-supply = <&vmmc_regulator>;
+			dmas = <&dmac1 21>;
+			dma-names = "rx";
+		};
+
+		dmac0: dma-controller at 10130000 {
+			compatible = "arm,pl080", "arm,primecell";
+			reg = <0x10130000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <15>;
+			clocks = <&hclkdma0>;
+			clock-names = "apb_pclk";
+			lli-bus-interface-ahb1;
+			lli-bus-interface-ahb2;
+			mem-bus-interface-ahb2;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+			#dma-cells = <1>;
+			/* Assignments for the 32 channels */
+			saa0 at dmac0 {
+				signal = "saa0";
+				bus-interface-ahb1;
+			};
+			saa1 at dmac0 {
+				signal = "saa1";
+				bus-interface-ahb1;
+			};
+			saa2 at dmac0 {
+				signal = "saa2";
+				bus-interface-ahb1;
+			};
+			saa3 at dmac0 {
+				signal = "saa3";
+				bus-interface-ahb1;
+			};
+			saa4 at dmac0 {
+				signal = "saa4";
+				bus-interface-ahb1;
+			};
+			saa5 at dmac0 {
+				signal = "saa5";
+				bus-interface-ahb1;
+			};
+			saa6 at dmac0 {
+				signal = "saa6";
+				bus-interface-ahb1;
+			};
+			saa7 at dmac0 {
+				signal = "saa7";
+				bus-interface-ahb1;
+			};
+			unused at dmac0 {
+				signal = "unused";
+				bus-interface-ahb1;
+			};
+			fir at dmac0 {
+				signal = "firdatxrx";
+				bus-interface-ahb1;
+			};
+			msp0rx at dmac0 {
+				signal = "msp0rx";
+				bus-interface-ahb1;
+			};
+			msp0tx at dmac0 {
+				signal = "msp0tx";
+				bus-interface-ahb1;
+			};
+			ssprx at dmac0 {
+				signal = "ssprx";
+				bus-interface-ahb1;
+			};
+			ssptx at dmac0 {
+				signal = "ssptx";
+				bus-interface-ahb1;
+			};
+			uart0rx at dmac0 {
+				signal = "uart0rx";
+				bus-interface-ahb1;
+			};
+			uart0tx at dmac0 {
+				signal = "uart0tx";
+				bus-interface-ahb1;
+			};
+			hsirxch0 at dmac0 {
+				signal = "hsirxch0";
+				bus-interface-ahb1;
+			};
+			hsirxch1 at dmac0 {
+				signal = "hsirxch1";
+				bus-interface-ahb1;
+			};
+			hsirxch2 at dmac0 {
+				signal = "hsirxch2";
+				bus-interface-ahb1;
+			};
+			hsirxch3 at dmac0 {
+				signal = "hsirxch3";
+				bus-interface-ahb1;
+			};
+			hsirxch4 at dmac0 {
+				signal = "hsirxch4";
+				bus-interface-ahb1;
+			};
+			hsirxch5 at dmac0 {
+				signal = "hsirxch5";
+				bus-interface-ahb1;
+			};
+			hsirxch6 at dmac0 {
+				signal = "hsirxch6";
+				bus-interface-ahb1;
+			};
+			hsirxch7 at dmac0 {
+				signal = "hsirxch7";
+				bus-interface-ahb1;
+			};
+			hsitxch0 at dmac0 {
+				signal = "hsitxch0";
+				bus-interface-ahb1;
+			};
+			hsitxch1 at dmac0 {
+				signal = "hsitxch1";
+				bus-interface-ahb1;
+			};
+			hsitxch2 at dmac0 {
+				signal = "hsitxch2";
+				bus-interface-ahb1;
+			};
+			hsitxch3 at dmac0 {
+				signal = "hsitxch3";
+				bus-interface-ahb1;
+			};
+			hsitxch4 at dmac0 {
+				signal = "hsitxch4";
+				bus-interface-ahb1;
+			};
+			hsitxch5 at dmac0 {
+				signal = "hsitxch5";
+				bus-interface-ahb1;
+			};
+			hsitxch6 at dmac0 {
+				signal = "hsitxch6";
+				bus-interface-ahb1;
+			};
+			hsitxch7 at dmac0 {
+				signal = "hsitxch7";
+				bus-interface-ahb1;
+			};
+		};
+		dmac1: dma-controller at 10150000 {
+			compatible = "arm,pl080", "arm,primecell";
+			reg = <0x10150000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <13>;
+			clocks = <&hclkdma1>;
+			clock-names = "apb_pclk";
+			lli-bus-interface-ahb1;
+			lli-bus-interface-ahb2;
+			mem-bus-interface-ahb2;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+			#dma-cells = <1>;
+			/* Assignments for the 32 channels */
+			saa0 at dmac1 {
+				signal = "saa0";
+				bus-interface-ahb1;
+			};
+			saa1 at dmac1 {
+				signal = "saa1";
+				bus-interface-ahb1;
+			};
+			saa2 at dmac1 {
+				signal = "saa2";
+				bus-interface-ahb1;
+			};
+			saa3 at dmac1 {
+				signal = "saa3";
+				bus-interface-ahb1;
+			};
+			saa4 at dmac1 {
+				signal = "saa4";
+				bus-interface-ahb1;
+			};
+			saa5 at dmac1 {
+				signal = "saa5";
+				bus-interface-ahb1;
+			};
+			saa6 at dmac1 {
+				signal = "saa6";
+				bus-interface-ahb1;
+			};
+			saa7 at dmac1 {
+				signal = "saa7";
+				bus-interface-ahb1;
+			};
+			unused at dmac1 {
+				signal = "unused";
+				bus-interface-ahb1;
+			};
+			fir at dmac1 {
+				signal = "firdatxrx";
+				bus-interface-ahb1;
+			};
+			msp0rx at dmac1 {
+				signal = "msp0rx";
+				bus-interface-ahb1;
+			};
+			msp0tx at dmac1 {
+				signal = "msp0tx";
+				bus-interface-ahb1;
+			};
+			ssprx at dmac1 {
+				signal = "ssprx";
+				bus-interface-ahb1;
+			};
+			ssptx at dmac1 {
+				signal = "ssptx";
+				bus-interface-ahb1;
+			};
+			uart0rx at dmac1 {
+				signal = "uart0rx";
+				bus-interface-ahb1;
+			};
+			uart0tx at dmac1 {
+				signal = "uart0tx";
+				bus-interface-ahb1;
+			};
+			tdesin at dmac1 {
+				signal = "tdesin";
+				bus-interface-ahb1;
+			};
+			tdesout at dmac1 {
+				signal = "tdesout";
+				bus-interface-ahb1;
+			};
+			i2c1rxtx at dmac1 {
+				signal = "i2c1rxtx";
+				bus-interface-ahb1;
+			};
+			i2c0rxtx at dmac1 {
+				signal = "i2c0rxtx";
+				bus-interface-ahb1;
+			};
+			sha1 at dmac1 {
+				signal = "sha1";
+				bus-interface-ahb1;
+			};
+			sdirxtx at dmac1 {
+				signal = "sdirxtx";
+				bus-interface-ahb1;
+			};
+			uart1rxdmac1 {
+				signal = "uart1rx";
+				bus-interface-ahb1;
+			};
+			uart1tx at dmac1 {
+				signal = "uart1tx";
+				bus-interface-ahb1;
+			};
+			usbotg0 at dmac1 {
+				signal = "usbotg0";
+				bus-interface-ahb1;
+			};
+			usbotg1 at dmac1 {
+				signal = "usbotg1";
+				bus-interface-ahb1;
+			};
+			usbotg2 at dmac1 {
+				signal = "usbotg2";
+				bus-interface-ahb1;
+			};
+			usbotg3 at dmac1 {
+				signal = "usbotg3";
+				bus-interface-ahb1;
+			};
+			usbotg4 at dmac1 {
+				signal = "usbotg4";
+				bus-interface-ahb1;
+			};
+			usbotg5 at dmac1 {
+				signal = "usbotg5";
+				bus-interface-ahb1;
+			};
+			usbotg6 at dmac1 {
+				signal = "usbotg6";
+				bus-interface-ahb1;
+			};
+			usbotg7 at dmac1 {
+				signal = "usbotg7";
+				bus-interface-ahb1;
+			};
 		};
 	};
 };
-- 
1.9.3
