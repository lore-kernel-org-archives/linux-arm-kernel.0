From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 9 Mar 2015 16:51:13 +0100
Subject: [PATCH] ARM: at91/dt: fix USB high-speed clock to select UTMI
Message-ID: <1425916273-393-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UTMI clock must be selected by any high-speed USB IP. The logic behind it
needs this particular clock.
So, correct the clock in the device tree files affected.

Reported-by: Bo Shen <voice.shen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++--
 arch/arm/boot/dts/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 56fa94bf6776..72be4be57767 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1325,7 +1325,7 @@
 			reg = <0x00800000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
 			//TODO
-			clocks = <&usb>, <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
+			clocks = <&utmi>, <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
 			clock-names = "usb_clk", "ehci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index a2ad79b0878c..76043e95b958 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -1062,7 +1062,7 @@
 				reg = <0x00500000 0x80000
 				       0xf803c000 0x400>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&usb>, <&udphs_clk>;
+				clocks = <&utmi>, <&udphs_clk>;
 				clock-names = "hclk", "pclk";
 				status = "disabled";
 
@@ -1182,7 +1182,7 @@
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00700000 0x100000>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&usb>, <&uhphs_clk>, <&uhpck>;
+			clocks = <&utmi>, <&uhphs_clk>, <&uhpck>;
 			clock-names = "usb_clk", "ehci_clk", "uhpck";
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 7ec28dab308a..29c08215d93a 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1426,7 +1426,7 @@
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00700000 0x100000>;
 			interrupts = <32 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&usb>, <&uhphs_clk>, <&uhpck>;
+			clocks = <&utmi>, <&uhphs_clk>, <&uhpck>;
 			clock-names = "usb_clk", "ehci_clk", "uhpck";
 			status = "disabled";
 		};
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index d050decd3ca0..3b23b88ca6a2 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -266,7 +266,7 @@
 			compatible = "atmel,at91sam9g45-ehci", "usb-ehci";
 			reg = <0x00600000 0x100000>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH 2>;
-			clocks = <&usb>, <&uhphs_clk>, <&uhpck>;
+			clocks = <&utmi>, <&uhphs_clk>, <&uhpck>;
 			clock-names = "usb_clk", "ehci_clk", "uhpck";
 			status = "disabled";
 		};
-- 
2.1.3
