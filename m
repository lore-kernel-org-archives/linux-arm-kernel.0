From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Tue,  9 Aug 2016 18:41:40 +0200
Subject: [PATCH V5 2/4] Documentation/devicetree/bindings: b850v3_lvds_dp
In-Reply-To: <cover.1470739193.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1470739193.git.peter.senna@collabora.com>
Message-ID: <2add7cb9193b96211f5e5938cbfc6181c76e2591.1470739193.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devicetree bindings documentation for the GE B850v3 LVDS/DP++
display bridge.

Cc: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Martin Donnelly <martin.donnelly@ge.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
Unchanged from V4

Changes from V3:
 - 2/4 instead of 3/5

Unchanged from V2

Changes from V1:
 - Replaced '_' by '-' in node names or compatible strings
 - Added missing @73 to the example


 .../devicetree/bindings/ge/b850v3-lvds-dp.txt      | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt

diff --git a/Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt b/Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt
new file mode 100644
index 0000000..f05c3e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt
@@ -0,0 +1,37 @@
+Driver for GE B850v3 LVDS/DP++ display bridge
+
+Required properties:
+  - compatible : should be "ge,b850v3-lvds-dp".
+  - reg : should contain the address used to ack the interrupts.
+  - interrupt-parent : phandle of the interrupt controller that services
+    interrupts to the device
+  - interrupts : one interrupt should be described here, as in
+    <0 IRQ_TYPE_LEVEL_HIGH>.
+  - edid-reg : should contain the address used to read edid information
+  - port : should describe the video signal connection between the host
+    and the bridge.
+
+Example:
+
+&mux2_i2c2 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	b850v3-lvds-dp-bridge at 73  {
+		compatible = "ge,b850v3-lvds-dp";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg = <0x73>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+		edid-reg = <0x72>;
+
+		port {
+			b850v3_dp_bridge_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+};
-- 
2.5.5
