From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 21 Jan 2014 12:57:07 +0200
Subject: [PATCHv3 35/41] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1390301833-24944-36-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for DVI Connector.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/dvi-connector.txt    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt

diff --git a/Documentation/devicetree/bindings/video/dvi-connector.txt b/Documentation/devicetree/bindings/video/dvi-connector.txt
new file mode 100644
index 000000000000..6a0aff866c78
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/dvi-connector.txt
@@ -0,0 +1,26 @@
+DVI Connector
+==============
+
+Required properties:
+- compatible: "dvi-connector"
+
+Optional properties:
+- label: a symbolic name for the connector
+- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
+
+Required nodes:
+- Video port for DVI input
+
+Example
+-------
+
+dvi0: connector at 0 {
+	compatible = "dvi-connector";
+	label = "dvi";
+
+	i2c-bus = <&i2c3>;
+
+	dvi_connector_in: endpoint {
+		remote-endpoint = <&tfp410_out>;
+	};
+};
-- 
1.8.3.2
