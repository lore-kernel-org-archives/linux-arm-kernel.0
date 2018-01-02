From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue,  2 Jan 2018 14:32:16 +0530
Subject: [PATCH 3/5] ARM: dts: imx6dl-icore: Add LVDS node
In-Reply-To: <1514883738-16297-1-git-send-email-jagan@amarulasolutions.com>
References: <1514883738-16297-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1514883738-16297-3-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ampire,am-800480aytzqw-00h LVDS support by using
timings from panel-simple.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6dl-icore.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-icore.dts b/arch/arm/boot/dts/imx6dl-icore.dts
index 971f9fc..74bff84 100644
--- a/arch/arm/boot/dts/imx6dl-icore.dts
+++ b/arch/arm/boot/dts/imx6dl-icore.dts
@@ -48,6 +48,17 @@
 / {
 	model = "Engicam i.CoreM6 DualLite/Solo Starter Kit";
 	compatible = "engicam,imx6-icore", "fsl,imx6dl";
+
+	panel {
+		compatible = "ampire,am-800480aytzqw-00h";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
 };
 
 &can1 {
@@ -66,3 +77,20 @@
 		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
 	};
 };
+
+&ldb {
+	status = "okay";
+
+	lvds-channel at 0 {
+		reg = <0>;
+		status = "okay";
+
+		port at 4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
-- 
2.7.4
