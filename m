From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Thu,  9 Jun 2016 18:25:03 +0200
Subject: [PATCH V2 3/5] Documentation/devicetree/bindings: b850v3_lvds_dp
In-Reply-To: <cover.1465486875.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1465486875.git.peter.senna@collabora.com>
Message-ID: <59c49951b95b0eb5b34eede6cfce526e72bc2443.1465486875.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devicetree bindings documentation for the GE B850v3 LVDS/DP++
display bridge.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
Changes from V1:
 - Replaced '_' by '-' in node names or compatible strings
 - Added missing @73 to the example

 .../devicetree/bindings/ge/b850v3_lvds_dp.txt      | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt

diff --git a/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt b/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
new file mode 100644
index 0000000..46bbea9
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
