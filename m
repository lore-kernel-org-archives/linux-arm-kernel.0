From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 28 May 2017 12:59:35 +0800
Subject: [PATCH 1/2] dt: bindings: add documentation for zx2967 family i2c
 controller
In-Reply-To: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1495947576-11037-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Baoyou Xie <baoyou.xie@linaro.org>

This patch adds dt-binding documentation for zx2967 family
i2c controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-zx2967.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-zx2967.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
new file mode 100644
index 000000000000..cb806d1ae4c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
@@ -0,0 +1,22 @@
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
+	};
-- 
1.9.1
