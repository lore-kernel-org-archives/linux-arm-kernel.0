From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri,  2 Dec 2016 23:19:13 +0800
Subject: [PATCH 2/2] arm: dts: sun8i: reuse the uart1 node of iNet D978 rev2
 board
In-Reply-To: <20161202151913.38892-1-icenowy@aosc.xyz>
References: <20161202151913.38892-1-icenowy@aosc.xyz>
Message-ID: <20161202151913.38892-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a uart1 node is added into sun8i-reference-design-tablet.dtsi, simply
use it in iNet D978 rev2 device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
index fb46655..7335461 100644
--- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
+++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
@@ -49,15 +49,6 @@
 	model = "INet-D978 Rev 02";
 	compatible = "primux,inet-d978-rev2", "allwinner,sun8i-a33";
 
-	aliases {
-		serial0 = &uart1;
-	};
-
-	chosen {
-		/* Delete debug UART as serial0 is the UART for bluetooth */
-		/delete-property/stdout-path;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -96,13 +87,6 @@
 	};
 };
 
-&r_uart {
-	status = "disabled";
-};
-
 &uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart1_pins_a>,
-		    <&uart1_pins_cts_rts_a>;
 	status = "okay";
 };
-- 
2.10.2
