From: hao5781286@gmail.com (hao_zhang)
Date: Wed, 13 Dec 2017 22:43:09 +0800
Subject: [PATCH v4 1/4] dt-bindings: pwm: binding allwinner sun8i R40/V40/T3.
Message-ID: <20171213144309.GA18167@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds allwinner R40, V40, T3 pwm binding documents.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
new file mode 100644
index 0000000..76750d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
@@ -0,0 +1,18 @@
+Allwinner sun8i R40/V40/T3 SoC PWM controller
+
+Required properties:
+- compatible: should be one of:
+- "allwinner,sun8i-r40-pwm"
+- reg: physical base address and length of the controller's registers
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+the cells format.
+- clocks: From common clock binding, handle to the parent clock.
+
+Example:
+
+pwm: pwm at 1c23400 {
+	     compatible = "allwinner,sun8i-r40-pwm";
+	     reg = <0x01c23400 0x154>;
+	     clocks = <&osc24M>;
+	     #pwm-cells = <3>;
+};
-- 
2.7.4
