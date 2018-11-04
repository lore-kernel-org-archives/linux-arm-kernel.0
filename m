From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun,  4 Nov 2018 19:27:05 +0100
Subject: [PATCH v3 28/28] arm64: dts: allwinner: h6: Enable HDMI output on
 Pine H64 board
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
Message-ID: <20181104182705.18047-29-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pine H64 board has HDMI type A connector.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 48daec7f78ba..36db21314996 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -21,6 +21,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector {
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
 
@@ -41,6 +52,20 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
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
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.19.1
