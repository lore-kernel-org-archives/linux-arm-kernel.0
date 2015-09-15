From: yassinjaffer@gmail.com (yassinjaffer at gmail.com)
Date: Wed, 16 Sep 2015 00:05:57 +1000
Subject: [PATCH 4/4] devicetree: bindings:Allwinner sun4i keypad
In-Reply-To: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
Message-ID: <1442325957-10102-5-git-send-email-yassinjaffer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yassin Jaffer <yassinjaffer@gmail.com>

Signed-off-by: Yassin Jaffer <yassinjaffer@gmail.com>
---
 .../devicetree/bindings/input/sun4i-keypad.txt     | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sun4i-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/sun4i-keypad.txt b/Documentation/devicetree/bindings/input/sun4i-keypad.txt
new file mode 100644
index 0000000..60ed0f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sun4i-keypad.txt
@@ -0,0 +1,56 @@
+Allwinner sun4i keypad
+------------------------------------------------
+
+Required properties:
+ - compatible: "allwinner,sun4i-a10-keypad"
+ - reg: mmio address range of the chip
+ - interrupts: interrupt to which the chip is connected
+ - clocks : shall reference keypad controller clocks.
+ - clock-names : keypad controller internal clock names. Shall contain :
+    * "apb" : APB gating clock
+    * "keypad" : keypad controller clock
+
+Required Board Specific Properties:
+- pinctrl-names: The definition can be found at
+pinctrl/pinctrl-bindings.txt.
+
+- pinctrl-0: The definition can be found at
+pinctrl/pinctrl-bindings.txt.
+
+- linux,keymap: The definition can be found at
+bindings/input/matrix-keymap.txt.
+
+Optional properties:
+ - scan-cycle: device specific scan cycle
+ - debounce-cycle: device specific debounce cycle
+ - autorepeat: If specified device will autorepeat
+
+Example:
+
+#include <dt-bindings/input/input.h>
+
+	kp: kp at 01c23000 {
+		compatible = "allwinner,sun4i-a10-keypad";
+		reg = <0x01c23000 0x400>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&apb0_gates 10>, <&keypad_clk>;
+		clock-names = "apb", "keypad";
+		pinctrl-names = "default";
+		pinctrl-0 = <&keypad_rows>, <&keypad_cols>;
+		linux,keymap = <0x00000067	/* KEY_UP */
+				0x0001006c	/* KEY_DOWN */
+				0x00020072	/* KEY_VOLUMEDOWN */
+				0x00030066	/* KEY_HOME */
+				0x0100006a	/* KEY_RIGHT */
+				0x01010069	/* KEY_LEFT */
+				0x0102001c	/* KEY_ENTER */
+				0x01030073	/* KEY_VOLUMEUP */
+				0x02000040	/* KEY_F6 */
+				0x02010042	/* KEY_F8 */
+				0x02020043	/* KEY_F9 */
+				0x02030044	/* KEY_F10 */
+				0x0300003b	/* KEY_F1 */
+				0x0301003c	/* KEY_F2 */
+				0x0302003d	/* KEY_F3 */
+				0x03030074>;	/* KEY_POWER */
+	};
-- 
1.9.1
