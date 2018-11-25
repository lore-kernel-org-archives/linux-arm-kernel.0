From: hao5781286@gmail.com (Hao Zhang)
Date: Mon, 26 Nov 2018 00:18:59 +0800
Subject: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner sun8i.
Message-ID: <20181125161859.GA5277@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Allwinner sun8i pwm binding document.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
new file mode 100644
index 0000000..7531d85
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
@@ -0,0 +1,24 @@
+Allwinner sun8i R40/V40/T3 SoC PWM controller
+
+Required properties:
+  - compatible: Should be one of:
+    - "allwinner,sun8i-r40-pwm"
+  - reg: Physical base address and length of the controller's registers
+  - interrupts: Should contain interrupt.
+  - clocks: From common clock binding, handle to the parent clock.
+  - clock-names: Must contain the clock names described just above.
+  - pwm-channels: PWM channels of the controller.
+  - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+    the cells format.
+
+Example:
+
+pwm: pwm at 1c23400 {
+	     compatible = "allwinner,sun8i-r40-pwm";
+	     reg = <0x01c23400 0x400>;
+	     interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+	     clocks = <&osc24M>, <&ccu CLK_APB1>;
+	     clock-names = "mux-0", "mux-1";
+	     pwm-channels = <8>;
+	     #pwm-cells = <3>;
+};
-- 
2.7.4
