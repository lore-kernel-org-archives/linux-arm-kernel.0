From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 21 Sep 2017 09:18:00 -0500
Subject: [PATCH 3/3] arm64: dts: stratix10: add reset property for various
 peripherals
In-Reply-To: <1506003480-22955-1-git-send-email-dinguyen@kernel.org>
References: <1506003480-22955-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1506003480-22955-3-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset property for emac, gpio, i2c, sdmmc, timers, and watchdog.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 99e2afe..6804936 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -101,6 +101,8 @@
 			interrupts = <0 90 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];
+			resets = <&rst EMAC0_RESET>;
+			reset-names = "stmmaceth";
 			status = "disabled";
 		};
 
@@ -110,6 +112,8 @@
 			interrupts = <0 91 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];
+			resets = <&rst EMAC1_RESET>;
+			reset-names = "stmmaceth";
 			status = "disabled";
 		};
 
@@ -119,6 +123,8 @@
 			interrupts = <0 92 4>;
 			interrupt-names = "macirq";
 			mac-address = [00 00 00 00 00 00];
+			resets = <&rst EMAC2_RESET>;
+			reset-names = "stmmaceth";
 			status = "disabled";
 		};
 
@@ -127,6 +133,7 @@
 			#size-cells = <0>;
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xffc03200 0x100>;
+			resets = <&rst GPIO0_RESET>;
 			status = "disabled";
 
 			porta: gpio-controller at 0 {
@@ -146,6 +153,7 @@
 			#size-cells = <0>;
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xffc03300 0x100>;
+			resets = <&rst GPIO1_RESET>;
 			status = "disabled";
 
 			portb: gpio-controller at 0 {
@@ -166,6 +174,7 @@
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02800 0x100>;
 			interrupts = <0 103 4>;
+			resets = <&rst I2C0_RESET>;
 			status = "disabled";
 		};
 
@@ -175,6 +184,7 @@
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02900 0x100>;
 			interrupts = <0 104 4>;
+			resets = <&rst I2C1_RESET>;
 			status = "disabled";
 		};
 
@@ -184,6 +194,7 @@
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02a00 0x100>;
 			interrupts = <0 105 4>;
+			resets = <&rst I2C2_RESET>;
 			status = "disabled";
 		};
 
@@ -193,6 +204,7 @@
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02b00 0x100>;
 			interrupts = <0 106 4>;
+			resets = <&rst I2C3_RESET>;
 			status = "disabled";
 		};
 
@@ -202,6 +214,7 @@
 			compatible = "snps,designware-i2c";
 			reg = <0xffc02c00 0x100>;
 			interrupts = <0 107 4>;
+			resets = <&rst I2C4_RESET>;
 			status = "disabled";
 		};
 
@@ -212,6 +225,8 @@
 			reg = <0xff808000 0x1000>;
 			interrupts = <0 96 4>;
 			fifo-depth = <0x400>;
+			resets = <&rst SDMMC_RESET>;
+			reset-names = "reset";
 			status = "disabled";
 		};
 
@@ -293,6 +308,7 @@
 			interrupts = <0 108 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst UART0_RESET>;
 			status = "disabled";
 		};
 
@@ -302,6 +318,7 @@
 			interrupts = <0 109 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst UART1_RESET>;
 			status = "disabled";
 		};
 
@@ -317,6 +334,8 @@
 			interrupts = <0 93 4>;
 			phys = <&usbphy0>;
 			phy-names = "usb2-phy";
+			resets = <&rst USB0_RESET>;
+			reset-names = "dwc2";
 			status = "disabled";
 		};
 
@@ -326,6 +345,8 @@
 			interrupts = <0 94 4>;
 			phys = <&usbphy0>;
 			phy-names = "usb2-phy";
+			resets = <&rst USB1_RESET>;
+			reset-names = "dwc2";
 			status = "disabled";
 		};
 
@@ -333,6 +354,7 @@
 			compatible = "snps,dw-wdt";
 			reg = <0xffd00200 0x100>;
 			interrupts = <0 117 4>;
+			resets = <&rst WATCHDOG0_RESET>;
 			status = "disabled";
 		};
 
@@ -340,6 +362,7 @@
 			compatible = "snps,dw-wdt";
 			reg = <0xffd00300 0x100>;
 			interrupts = <0 118 4>;
+			resets = <&rst WATCHDOG1_RESET>;
 			status = "disabled";
 		};
 
@@ -347,6 +370,7 @@
 			compatible = "snps,dw-wdt";
 			reg = <0xffd00400 0x100>;
 			interrupts = <0 125 4>;
+			resets = <&rst WATCHDOG2_RESET>;
 			status = "disabled";
 		};
 
@@ -354,6 +378,7 @@
 			compatible = "snps,dw-wdt";
 			reg = <0xffd00500 0x100>;
 			interrupts = <0 126 4>;
+			resets = <&rst WATCHDOG3_RESET>;
 			status = "disabled";
 		};
 	};
-- 
2.7.4
