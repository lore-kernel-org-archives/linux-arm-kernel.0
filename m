From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 21 Jan 2014 12:57:10 +0200
Subject: [PATCHv3 38/41] Doc/DT: Add DT binding documentation for MIPI DSI CM
 Panel
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1390301833-24944-39-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for MIPI DSI Command Mode Panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/panel-dsi-cm.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/panel-dsi-cm.txt

diff --git a/Documentation/devicetree/bindings/video/panel-dsi-cm.txt b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
new file mode 100644
index 000000000000..73f422556d4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
@@ -0,0 +1,26 @@
+Generic MIPI DSI Command Mode Panel
+===================================
+
+Required properties:
+- compatible: "panel-dsi-cm"
+
+Optional properties:
+- label: a symbolic name for the panel
+- gpios: panel reset gpio and TE gpio
+
+Required nodes:
+- Video port for DSI input
+
+Example
+-------
+
+lcd0: display {
+	compatible = "tpo,taal", "panel-dsi-cm";
+	label = "lcd0";
+
+	gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;	/* 102, reset */
+
+	lcd0_in: endpoint {
+		remote-endpoint = <&dsi1_out_ep>;
+	};
+};
-- 
1.8.3.2
