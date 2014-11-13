From: b.galvani@gmail.com (Beniamino Galvani)
Date: Thu, 13 Nov 2014 20:32:01 +0100
Subject: [PATCH v3 1/3] i2c: meson: add device tree bindings documentation
In-Reply-To: <1415907123-4318-1-git-send-email-b.galvani@gmail.com>
References: <1415907123-4318-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1415907123-4318-2-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds device tree bindings documentation for the I2C bus
controller found on Amlogic Meson SoCs.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 .../devicetree/bindings/i2c/i2c-meson.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-meson.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
new file mode 100644
index 0000000..682f9a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -0,0 +1,24 @@
+Amlogic Meson I2C controller
+
+Required properties:
+ - compatible: must be "amlogic,meson6-i2c"
+ - reg: physical address and length of the device registers
+ - interrupts: a single interrupt specifier
+ - clocks: clock for the device
+ - #address-cells: should be <1>
+ - #size-cells: should be <0>
+
+Optional properties:
+- clock-frequency: the desired I2C bus clock frequency in Hz; in
+  absence of this property the default value is used (100 kHz).
+
+Examples:
+
+	i2c at c8100500 {
+		compatible = "amlogic,meson6-i2c";
+		reg = <0xc8100500 0x20>;
+		interrupts = <0 92 1>;
+		clocks = <&clk81>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.9.1
