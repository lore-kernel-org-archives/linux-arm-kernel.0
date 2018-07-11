From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 11 Jul 2018 21:22:32 +0800
Subject: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output on Banana Pi M2 Zero
In-Reply-To: <20180711132233.42301-1-icenowy@aosc.io>
References: <20180711132233.42301-1-icenowy@aosc.io>
Message-ID: <20180711132233.42301-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
controller of Allwinner H3 SoC.

Enable the HDMI output in Banana Pi M2 Zero device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index 7d01f9322658..eb61dcf32797 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -26,6 +26,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "c";
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
@@ -55,10 +66,24 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
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
 &mmc0 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-- 
2.17.1
