From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:24 +0800
Subject: [PATCH 19/19] ARM: sun6i: a31s: Enable HDMI display output on the MSI
 Primo81 tablet
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-20-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MSI Primo81 tablet has a micro HDMI connector at the bottom.
This is connected to the SoCs HDMI output.

Enable the display pipeline and the HDMI output.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-primo81.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index f3712753fa42..26154b2f87a3 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -52,17 +52,42 @@
 / {
 	model = "MSI Primo81 tablet";
 	compatible = "msi,primo81", "allwinner,sun6i-a31s";
+
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
 };
 
 &cpu0 {
 	cpu-supply = <&reg_dcdc3>;
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	/* rtl8188etv wifi is connected here */
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
 &i2c0 {
 	/* pull-ups and device VDDIO use AXP221 DLDO3 */
 	pinctrl-names = "default";
-- 
2.11.0
