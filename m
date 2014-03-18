From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 10:15:44 +0200
Subject: [PATCHv2 5/8] Doc/DT: Add DT binding documentation for MIPI DSI CM
 Panel
In-Reply-To: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1395130547-18633-6-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for MIPI DSI Command Mode Panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/panel-dsi-cm.txt     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/panel-dsi-cm.txt

diff --git a/Documentation/devicetree/bindings/video/panel-dsi-cm.txt b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
new file mode 100644
index 000000000000..dce48eb9db57
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
@@ -0,0 +1,29 @@
+Generic MIPI DSI Command Mode Panel
+===================================
+
+Required properties:
+- compatible: "panel-dsi-cm"
+
+Optional properties:
+- label: a symbolic name for the panel
+- reset-gpios: panel reset gpio
+- te-gpios: panel TE gpio
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
+	reset-gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;
+
+	port {
+		lcd0_in: endpoint {
+			remote-endpoint = <&dsi1_out_ep>;
+		};
+	};
+};
-- 
1.8.3.2
