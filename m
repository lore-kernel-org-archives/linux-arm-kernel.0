From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 30 Apr 2018 17:10:55 +0530
Subject: [PATCH 18/21] arm64: dts: allwinner: a64: orangepi-win: Enable HDMI
 output
In-Reply-To: <20180430114058.5061-1-jagan@amarulasolutions.com>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
Message-ID: <20180430114058.5061-19-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HDMI output on Orangepi-win board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index bf42690a3361..b6fdd052d473 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -57,12 +57,38 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
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
+};
+
+&de {
+	status = "okay";
 };
 
 &ehci1 {
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
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.14.3
