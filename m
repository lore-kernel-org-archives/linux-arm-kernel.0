From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:23 +0800
Subject: [PATCH 18/19] ARM: sun6i: a31s: Enable HDMI display output on the
 Sinlinx SinA31s
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-19-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Sinlinx SinA31s has an HDMI connector wired to the HDMI pins
from the SoC.

Enable the display pipeline and the HDMI output.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index b3d98222bd81..298476485bb4 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -53,6 +53,17 @@
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
@@ -90,6 +101,10 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	/* USB 2.0 4 port hub IC */
 	status = "okay";
@@ -112,6 +127,16 @@
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
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.11.0
