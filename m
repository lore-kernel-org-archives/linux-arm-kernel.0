From: monnier@IRO.UMontreal.CA (Stefan Monnier)
Date: Fri, 16 Feb 2018 11:16:04 -0500
Subject: [PATCH] ARM: dts: sun7i: Enable HDMI support on the Banana Pi
Message-ID: <jwvbmgoapat.fsf-monnier@gnu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Monnier <monnier@iro.umontreal.ca>

Enable the display pipeline and HDMI output

Signed-off-by: Stefan Monnier <monnier@iro.umontreal.ca>
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 88a1c2363c6c..45da8a282288 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -63,6 +63,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -109,6 +120,10 @@
 		>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -130,6 +145,16 @@
 	};
 };
 
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
