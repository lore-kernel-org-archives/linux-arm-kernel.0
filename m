From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 13 Sep 2017 17:56:29 +0900
Subject: [PATCH v5 2/3] dt-bindings: gpio: uniphier: add UniPhier GPIO binding
In-Reply-To: <1505292990-22957-1-git-send-email-yamada.masahiro@socionext.com>
References: <1505292990-22957-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1505292990-22957-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This GPIO controller is used on UniPhier SoC family.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
---


 .../devicetree/bindings/gpio/gpio-uniphier.txt     | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-uniphier.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt b/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
new file mode 100644
index 0000000..0a371bdd
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
@@ -0,0 +1,43 @@
+UniPhier GPIO controller
+
+Required properties:
+- compatible: Should be "socionext,uniphier-gpio".
+- reg: Specifies offset and length of the register set for the device.
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells: Should be 2.  The first cell is the pin number and the second
+  cell is used to specify optional parameters.
+- interrupt-parent: Specifies the parent interrupt controller.
+- interrupts: Specifies interrupts connected to the parent interrupt controller.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells: Should be 2.  The first cell defines the interrupt number.
+  The second cell bits[3:0] is used to specify trigger type as follows:
+    1 = low-to-high edge triggered
+    2 = high-to-low edge triggered
+    4 = active high level-sensitive
+    8 = active low level-sensitive
+  Valid combinations are 1, 2, 3, 4, 8.
+- ngpios: Specifies the number of GPIO lines.
+- gpio-ranges: Mapping to pin controller pins (as described in gpio.txt)
+
+Optional properties:
+- gpio-ranges-group-names: Used for named gpio ranges (as described in gpio.txt)
+
+Example:
+	gpio: gpio at 55000000 {
+		compatible = "socionext,uniphier-gpio";
+		reg = <0x55000000 0x200>;
+		interrupt-parent = <&aidet>;
+		interrupts = <48 0>, <49 0>, <50 0>, <51 0>,
+			     <52 0>, <53 0>, <54 0>, <55 0>,
+			     <56 0>, <57 0>, <58 0>, <59 0>,
+			     <60 0>, <61 0>, <62 0>, <63 0>,
+			     <154 0>, <155 0>, <156 0>, <157 0>,
+			     <158 0>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl 0 0 0>;
+		gpio-ranges-group-names = "gpio_range";
+		ngpios = <248>;
+	};
-- 
2.7.4
