From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Mon, 30 May 2016 18:39:43 +0200
Subject: [PATCH 3/5] Documentation/devicetree/bindings: Add b850v3_lvds_dp
In-Reply-To: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
Message-ID: <1464626385-19253-4-git-send-email-peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devicetree bindings documentation for the GE B850v3 LVDS/DP++
display bridge.

Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
 .../devicetree/bindings/ge/b850v3_lvds_dp.txt      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt

diff --git a/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt b/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
new file mode 100644
index 0000000..32e123a
--- /dev/null
+++ b/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
@@ -0,0 +1,38 @@
+Driver for GE B850v3 LVDS/DP++ display bridge
+
+Required properties:
+  - compatible : should be "ge,b850v3_lvds_dp".
+  - reg : should contain the address used to ack the interrupts.
+  - interrupt-parent : should link to the gpio used as interrupt
+    source on the host.
+  - interrupts : one interrupt should be described here, as in
+    <0 IRQ_TYPE_LEVEL_HIGH>.
+  - edid-reg : should contain the address used to read edid information
+  - port : should describe the vide signal connection between the host
+    and the bridge.
+
+Example:
+
+&mux2_i2c2 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	b850v3_dp_bridge {
+		compatible = "ge,b850v3_lvds_dp";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg = <0x73>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+		edid-reg = <0x72>;
+
+		port at 0 {
+			reg = <0>;
+			b850v3_dp_bridge_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+};
-- 
2.5.5
