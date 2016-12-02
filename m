From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri,  2 Dec 2016 23:19:12 +0800
Subject: [PATCH 1/2] arm: dts: sun8i: add uart1 node to reference design tablet
Message-ID: <20161202151913.38892-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the A23/A33 tablet reference design, the UART1 at PG is used to
connect to the UART-connected bluetooth.

Add a disabled uart1 node for it in the reference design tablet dtsi,
contains the pinctrl info.

If a tablet uses the UART bluetooth, simply set the status of this node
to "okay".

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 08cd001..2d9cf0d 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -46,6 +46,7 @@
 / {
 	aliases {
 		serial0 = &r_uart;
+		serial1 = &uart1;
 	};
 
 	backlight: backlight {
@@ -223,6 +224,13 @@
 	vcc-lcd-supply = <&reg_dc1sw>;
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins_a>,
+		    <&uart1_pins_cts_rts_a>;
+	status = "disabled";
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.10.2
