From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu, 16 Feb 2017 14:00:42 +0800
Subject: [PATCH v7 1/3] dt: bindings: add documentation for zx2967 family i2c
 controller
Message-ID: <1487224844-10973-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds dt-binding documentation for zx2967 family
i2c controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-zx2967.txt         | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-zx2967.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
new file mode 100644
index 0000000..a528374
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
@@ -0,0 +1,24 @@
+ZTE zx2967 I2C controller
+
+Required properties:
+ - compatible: must be "zte,zx296718-i2c"
+ - reg: physical address and length of the device registers
+ - interrupts: a single interrupt specifier
+ - clocks: clock for the device
+ - #address-cells: should be <1>
+ - #size-cells: should be <0>
+ - clock-frequency: the desired I2C bus clock frequency.
+
+Examples:
+
+	i2c at 112000 {
+		compatible = "zte,zx296718-i2c";
+		reg = <0x00112000 0x1000>;
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&osc24m>;
+		#address-cells = <1>
+		#size-cells = <0>;
+		clock-frequency = <1600000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c_global_pin>;
+	};
-- 
2.7.4
