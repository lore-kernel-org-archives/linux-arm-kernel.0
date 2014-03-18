From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 10:15:43 +0200
Subject: [PATCHv2 4/8] Doc/DT: Add DT binding documentation for HDMI Connector
In-Reply-To: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1395130547-18633-5-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for HDMI Connector.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/hdmi-connector.txt   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/hdmi-connector.txt

diff --git a/Documentation/devicetree/bindings/video/hdmi-connector.txt b/Documentation/devicetree/bindings/video/hdmi-connector.txt
new file mode 100644
index 000000000000..ccccc19e2573
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/hdmi-connector.txt
@@ -0,0 +1,28 @@
+HDMI Connector
+==============
+
+Required properties:
+- compatible: "hdmi-connector"
+- type: the HDMI connector type: "a", "b", "c", "d" or "e"
+
+Optional properties:
+- label: a symbolic name for the connector
+
+Required nodes:
+- Video port for HDMI input
+
+Example
+-------
+
+hdmi0: connector at 1 {
+	compatible = "hdmi-connector";
+	label = "hdmi";
+
+	type = "a";
+
+	port {
+		hdmi_connector_in: endpoint {
+			remote-endpoint = <&tpd12s015_out>;
+		};
+	};
+};
-- 
1.8.3.2
