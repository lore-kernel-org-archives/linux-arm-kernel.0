From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 19 Nov 2014 00:02:27 +0100
Subject: [PATCHv4 06/10] arm: mvebu: define and use common Armada 370 UART
 pinctrl settings
In-Reply-To: <cover.1416351425.git.arno@natisbad.org>
References: <cover.1416351425.git.arno@natisbad.org>
Message-ID: <a3d6d0b3ad77e4bc4526809ed584461504e4cc53.1416351426.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch defines common Armada 370 pinctrl settings for uart0 and
uart1 interfaces:

 uart0: MPP0-1 as default
 uart1: MPP41-42 as default

Note: this patch has the potential to break out-of-tree users w/o
specific pinctrl settings for their uart interfaces if the default
above does not match their config.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index f1284ae0cddd..b8de32b2a265 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -211,6 +211,21 @@
 				pinctrl-names = "default";
 			};
 
+			/*
+			 * Default UART pinctrl setting without RTS/CTS, can
+			 * be overwritten on board level if a different
+			 * configuration is used.
+			 */
+			uart0: serial at 12000 {
+				pinctrl-0 = <&uart0_pins>;
+				pinctrl-names = "default";
+			};
+
+			uart1: serial at 12100 {
+				pinctrl-0 = <&uart1_pins>;
+				pinctrl-names = "default";
+			};
+
 			usb at 50000 {
 				clocks = <&coreclk 0>;
 			};
@@ -281,6 +296,16 @@
 		marvell,function = "spi1";
 	};
 
+	uart0_pins: uart0-pins {
+		marvell,pins = "mpp0", "mpp1";
+		marvell,function = "uart0";
+	};
+
+	uart1_pins: uart1-pins {
+		marvell,pins = "mpp41", "mpp42";
+		marvell,function = "uart1";
+	};
+
 	sdio_pins1: sdio-pins1 {
 		marvell,pins = "mpp9",  "mpp11", "mpp12",
 				"mpp13", "mpp14", "mpp15";
-- 
2.1.1
