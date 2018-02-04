From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Sun,  4 Feb 2018 23:19:27 +0530
Subject: [PATCH v3 3/7] ARM: dts: imx6dl-icore: Add LVDS node
In-Reply-To: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
References: <1517766571-409-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1517766571-409-4-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ampire,am-800480aytzqw-00h LVDS support by using
timings from panel-simple.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3, v2:
- none

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
