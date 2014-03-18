From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 10:15:42 +0200
Subject: [PATCHv2 3/8] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1395130547-18633-4-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for DVI Connector.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/dvi-connector.txt    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/dvi-connector.txt

diff --git a/Documentation/devicetree/bindings/video/dvi-connector.txt b/Documentation/devicetree/bindings/video/dvi-connector.txt
new file mode 100644
index 000000000000..fc53f7c60bc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/dvi-connector.txt
@@ -0,0 +1,35 @@
+DVI Connector
+==============
+
+Required properties:
+- compatible: "dvi-connector"
+
+Optional properties:
+- label: a symbolic name for the connector
+- ddc-i2c-bus: phandle to the i2c bus that is connected to DVI DDC
+- analog: the connector has DVI analog pins
+- digital: the connector has DVI digital pins
+- dual-link: the connector has pins for DVI dual-link
+
+Required nodes:
+- Video port for DVI input
+
+Note: One (or both) of 'analog' or 'digital' must be set.
+
+Example
+-------
+
+dvi0: connector at 0 {
+	compatible = "dvi-connector";
+	label = "dvi";
+
+	digital;
+
+	ddc-i2c-bus = <&i2c3>;
+
+	port {
+		dvi_connector_in: endpoint {
+			remote-endpoint = <&tfp410_out>;
+		};
+	};
+};
-- 
1.8.3.2
