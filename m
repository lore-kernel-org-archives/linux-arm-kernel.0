From: dkos@cadence.com (Damian Kos)
Date: Tue, 24 Jul 2018 12:13:35 +0100
Subject: [PATCH v2 4/5] dt-bindings: drm/bridge Document Cadence MHDP DPI/DP
 bridge bindings
In-Reply-To: <1532430824-23477-1-git-send-email-dkos@cadence.com>
References: <1532430824-23477-1-git-send-email-dkos@cadence.com>
Message-ID: <1532430824-23477-5-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 .../bindings/display/bridge/cdns,mhdp.txt     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
new file mode 100644
index 000000000000..dc7be7590048
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
@@ -0,0 +1,43 @@
+Cadence MHDP bridge
+==========================
+
+The Cadence MHDP bridge is a DPI to DP bridge.
+
+Required properties:
+- compatible: should be "cdns,mhdp8546",
+- reg: physical base address and length of the controller's registers,
+- clocks: DP bridge clock, it's used by the IP to know how to translate
+	a number of clock cycles into a time (which is used to comply
+	with DP standard timings and delays),
+
+Required subnodes:
+- ports: Ports as described in Documentation/devictree/bindings/graph.txt
+	Port 0 - input port representing the VGA bridge input
+	Port 1 - output port representing the VGA bridge output
+
+Example:
+
+	mhdp: dp-bridge at f0fb000000 {
+		compatible = "cdns,mhdp8546";
+		reg = <0xf0 0xfb000000 0x0 0x1000000>;
+		clocks = <&mhdp_clock>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				vga_bridge_input: endpoint {
+					remote-endpoint = <&xxx_dpi_output>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				vga_bridge_output: endpoint {
+					remote-endpoint = <&xxx_vga_connector_input>;
+				};
+			};
+		};
+	};
-- 
2.17.1
