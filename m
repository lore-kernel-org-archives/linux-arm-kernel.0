From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 23 Aug 2016 14:44:51 +0800
Subject: [PATCH 2/2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <20160823064451.25997-1-icenowy@aosc.xyz>
References: <20160823064451.25997-1-icenowy@aosc.xyz>
Message-ID: <20160823064451.25997-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART1 is connected to the bluetooth part of RTL8723BS WiFi/BT combo card
on iNet D978 Rev2 board.

Enable the UART1 to make it possible to use the modified hciattach by
Realtek to drive the BT part of RTL8723BS.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
index 78823d8..3ac22d4 100644
--- a/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
+++ b/arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
@@ -48,6 +48,10 @@
 	model = "INet-D978 Rev 02";
 	compatible = "primux,inet-d978-rev2", "allwinner,sun8i-a33";
 
+	aliases {
+		serial1 = &uart1;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -77,6 +81,13 @@
 	};
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_b>,
+		    <&uart1_pins_cts_rts_b>;
+	status = "okay";
+};
+
 &r_pio {
 	led_pin_d978: led_pin_d978 at 0 {
 		allwinner,pins = "PL5";
-- 
2.9.3
