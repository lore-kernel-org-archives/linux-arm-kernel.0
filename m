From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Oct 2015 10:58:02 +0900
Subject: [PATCH 25/28] ARM: shmobile: dts: Add common file for AA121TD01 panel
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
Message-ID: <5325f83aba3cc80a1d3aa62a0350a107cfae7a43.1444182812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The Mitsubishi AA121TD01 panel is commonly used with the Marzen, Lager
and Koelsch boards. Create a .dtsi file that describe the panel and its
connection to the board.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi

diff --git a/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi b/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
new file mode 100644
index 000000000000..a07ebf8f6938
--- /dev/null
+++ b/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Common file for the AA121TD01 panel connected to Renesas R-Car boards
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	panel {
+		compatible = "mitsubishi,aa121td01", "panel-dpi";
+
+		width-mm = <261>;
+		height-mm = <163>;
+
+		panel-timing {
+			/* 1280x800 @60Hz */
+			clock-frequency = <71000000>;
+			hactive = <1280>;
+			vactive = <800>;
+			hsync-len = <70>;
+			hfront-porch = <20>;
+			hback-porch = <70>;
+			vsync-len = <5>;
+			vfront-porch = <3>;
+			vback-porch = <15>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds_connector>;
+			};
+		};
+	};
+};
+
+&lvds_connector {
+	remote-endpoint = <&panel_in>;
+};
-- 
2.1.4
