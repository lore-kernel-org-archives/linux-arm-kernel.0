From: b.galvani@gmail.com (Beniamino Galvani)
Date: Wed, 17 Sep 2014 00:07:57 +0200
Subject: [PATCH 2/2] i2c: meson: add device tree bindings documentation
In-Reply-To: <1410905277-22172-1-git-send-email-b.galvani@gmail.com>
References: <1410905277-22172-1-git-send-email-b.galvani@gmail.com>
Message-ID: <1410905277-22172-3-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings documentation for the I2C controller
found in Amlogic Meson SoCs.

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 .../devicetree/bindings/i2c/i2c-meson.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-meson.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
new file mode 100644
index 0000000..54a6c2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
@@ -0,0 +1,24 @@
+* Amlogic Meson I2C controller
+
+Required properties:
+ - compatible: must be "amlogic,meson6-i2c"
+ - reg: physical address and length of the device register set
+ - interrupts: a single interrupt specifier
+ - clocks: clock for the device
+ - #address-cells: should be <1>
+ - #size-cells: should be <0>
+
+Optional properties:
+- clock-frequency: the desired I2C bus clock frequency in Hz; in
+  absence of this property the default value is used (100 kHz).
+
+Example:
+
+	i2c at c1108500 {
+		compatible = "amlogic,meson6-i2c";
+		reg = <0xc1108500 0x20>;
+		interrupts = <0 21 1>;
+		clocks = <&clk81>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.9.1
