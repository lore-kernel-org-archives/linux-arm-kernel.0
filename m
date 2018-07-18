From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 18 Jul 2018 16:24:58 +0530
Subject: [PATCH v3 18/18] arm64: dts: allwinner: a64: sopine: Enable HDMI
 output
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Message-ID: <20180718105458.22304-19-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable all necessary HDMI pipeline nodes with HDMI out
connector on sopine board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Enable all pipeline components
Changes for v2:
- none

 .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index c21f2331add6..050e0ff92145 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -61,6 +61,17 @@
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
 	reg_vcc1v8: vcc1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v8";
@@ -69,6 +80,10 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -86,6 +101,17 @@
 	status = "okay";
 };
 
+&hdmi {
+	hvcc-supply = <&reg_dldo1>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy at 1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -93,6 +119,10 @@
 	};
 };
 
+&mixer1 {
+	status = "okay";
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
@@ -138,6 +168,10 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&tcon1 {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.17.1
