From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  4 Apr 2014 14:27:54 -0700
Subject: [PATCH v5 1/3] i2c: cadence: Document device tree bindings
Message-ID: <1396646876-27336-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding documentation for the Cadence I2C controller.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

Changes in v5:
 - Document all properties
 - list clock-names as optional property (driver doesn't use it, though)
 - use lower case hex digits in 'reg' property
 - reword description of 'clocks' property
 - remove implementation specific notes regarding default speed
 - use #defines for interrupt specifier

Changes in v4:
 - moved adding DT docs into this dedicated patch

Changes in v3: None
Changes in v2: None

---
 .../devicetree/bindings/i2c/i2c-cadence.txt        | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cadence.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
new file mode 100644
index 000000000000..7cb0b5608f49
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
@@ -0,0 +1,24 @@
+Binding for the Cadence I2C controller
+
+Required properties:
+  - reg: Physical base address and size of the controller's register area.
+  - compatible: Compatibility string. Must be 'cdns,i2c-r1p10'.
+  - clocks: Input clock specifier. Refer to common clock bindings.
+  - interrupts: Interrupt specifier. Refer to interrupt bindings.
+  - #address-cells: Should be 1.
+  - #size-cells: Should be 0.
+
+Optional properties:
+  - clock-frequency: Desired operating frequency, in Hz, of the bus.
+  - clock-names: Input clock name, should be 'pclk'.
+
+Example:
+	i2c at e0004000 {
+		compatible = "cdns,i2c-r1p10";
+		clocks = <&clkc 38>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xe0004000 0x1000>;
+		clock-frequency = <400000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.9.1.1.gbb9f595
