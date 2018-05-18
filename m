From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri, 18 May 2018 15:15:35 +0530
Subject: [PATCH v2 25/26] arm64: dts: allwinner: a64: pine64: Enable HDMI
 output
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Message-ID: <20180518094536.17201-26-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable HDMI output on pine64 board.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index a75825798a71..a4ec0900a885 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -62,6 +62,21 @@
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
 
 &ehci0 {
@@ -82,6 +97,17 @@
 
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
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
-- 
2.14.3
