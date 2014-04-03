From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu,  3 Apr 2014 10:59:25 -0700
Subject: [PATCH v4 1/3] i2c: cadence: Document device tree bindings
Message-ID: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding documentation for the Cadence I2C controller.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

Changes in v4:
 - moved adding DT docs into this dedicated patch

Changes in v3: None
Changes in v2: None

---
 .../devicetree/bindings/i2c/i2c-cadence.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cadence.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
new file mode 100644
index 000000000000..685adf513111
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
@@ -0,0 +1,21 @@
+Binding for the Cadence I2C controller
+
+Required properties:
+  compatible: Compatibility string. Must be 'cdns,i2c-r1p10'.
+  clocks: From common clock bindings. Phandle to input clock.
+
+Optional properties:
+  clock-frequency: Desired operating frequency, in Hz, of the bus (actual may
+		   be lower). Defaults to 400000 if not specified.
+
+Example:
+
+	i2c at e0004000 {
+		compatible = "cdns,i2c-r1p10";
+		clocks = <&clkc 38>;
+		interrupts = <0 25 4>;
+		reg = <0xE0004000 0x1000>;
+		clock-frequency = <400000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.9.1.1.gbb9f595
