From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 21 Jan 2014 12:57:12 +0200
Subject: [PATCHv3 40/41] Doc/DT: Add DT binding documentation for TFP410
 encoder
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1390301833-24944-41-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding documentation for TFP410 encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/video/ti,tfp410.txt        | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,tfp410.txt

diff --git a/Documentation/devicetree/bindings/video/ti,tfp410.txt b/Documentation/devicetree/bindings/video/ti,tfp410.txt
new file mode 100644
index 000000000000..6a5a04627584
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,tfp410.txt
@@ -0,0 +1,41 @@
+TFP410 DPI to DVI encoder
+=========================
+
+Required properties:
+- compatible: "ti,tfp410"
+
+Optional properties:
+- gpios: power-down gpio
+
+Required nodes:
+- Video port 0 for DPI input
+- Video port 1 for DVI output
+
+Example
+-------
+
+tfp410: encoder at 0 {
+	compatible = "ti,tfp410";
+	gpios = <&twl_gpio 2 GPIO_ACTIVE_LOW>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+
+			tfp410_in: endpoint at 0 {
+				remote-endpoint = <&dpi_out>;
+			};
+		};
+
+		port at 1 {
+			reg = <1>;
+
+			tfp410_out: endpoint at 0 {
+				remote-endpoint = <&dvi_connector_in>;
+			};
+		};
+	};
+};
-- 
1.8.3.2
