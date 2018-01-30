From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 30 Jan 2018 19:32:54 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun4i: Enable HDMI support on the MK802
Message-ID: <20180130183254.20529-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Enable the display pipeline and HDMI output.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10-mk802.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
index 7198b34e2e50..982a704d5663 100644
--- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
+++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
@@ -56,12 +56,27 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
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
 };
 
 &codec {
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -70,6 +85,16 @@
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
2.16.1
