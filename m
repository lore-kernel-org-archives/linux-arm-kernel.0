From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 19 Mar 2015 13:16:46 +0200
Subject: [PATCH v3 1/2] i2c: dt binding documentation for the Digicolor I2C
 controller
Message-ID: <7f61d9379c89db43f5b7f65c408433dd0d82a88a.1426763807.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CX92755 is an SoC in the Conexant Digicolor series. This devicetree binding
document describes the I2C controller on the CX92755 SoC, that is also shared
by some other SoCs in the Digicolor series.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v3: No change
v2: No change
---
 .../devicetree/bindings/i2c/i2c-digicolor.txt      | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-digicolor.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-digicolor.txt b/Documentation/devicetree/bindings/i2c/i2c-digicolor.txt
new file mode 100644
index 000000000000..457a098d4f7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-digicolor.txt
@@ -0,0 +1,25 @@
+Conexant Digicolor I2C controller
+
+Required properties:
+ - compatible: must be "cnxt,cx92755-i2c"
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
+Example:
+
+	i2c: i2c at f0000120 {
+		compatible = "cnxt,cx92755-i2c";
+		reg = <0xf0000120 0x10>;
+		interrupts = <28>;
+		clocks = <&main_clk>;
+		clock-frequency = <100000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
2.1.4
