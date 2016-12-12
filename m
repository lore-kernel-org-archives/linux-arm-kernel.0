From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 12 Dec 2016 14:05:39 +0100
Subject: [PATCH v6 2/5] drm: bridge: add DT bindings for TI ths8135
In-Reply-To: <1481547942-24775-1-git-send-email-bgolaszewski@baylibre.com>
References: <1481547942-24775-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1481547942-24775-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

THS8135 is a configurable video DAC. Add DT bindings for this chip.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../bindings/display/bridge/ti,ths8135.txt         | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt b/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
new file mode 100644
index 0000000..87aff90
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/ti,ths8135.txt
@@ -0,0 +1,52 @@
+THS8135 Video DAC
+-----------------
+
+This is the binding for Texas Instruments THS8135 Video DAC bridge.
+
+Required properties:
+
+- compatible: Must be "ti,ths8135"
+
+Required nodes:
+
+This device has two video ports. Their connections are modelled using the OF
+graph bindings specified in Documentation/devicetree/bindings/graph.txt.
+
+- Video port 0 for RGB input
+- Video port 1 for VGA output
+
+Example
+-------
+
+vga-bridge {
+	compatible = "ti,ths8135";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			vga_bridge_in: endpoint {
+				reg = <0>;
+				remote-endpoint = <&lcdc_out_vga>;
+			};
+		};
+
+		port at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			vga_bridge_out: endpoint {
+				reg = <0>;
+				remote-endpoint = <&vga_con_in>;
+			};
+		};
+	};
+};
-- 
2.9.3
