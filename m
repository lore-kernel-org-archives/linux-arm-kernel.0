From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:18:30 +0100
Subject: [PATCH 06/22] gpio: add DT bindings for Cortina Gemini GPIO
Message-ID: <20170122121830.10336-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds fairly standard DT bindings for the Cortina Systems
Gemini GPIO controller.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Note to self: just apply this to the GPIO tree when discussion is over.
---
 .../bindings/gpio/cortina,gemini-gpio.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/cortina,gemini-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/cortina,gemini-gpio.txt b/Documentation/devicetree/bindings/gpio/cortina,gemini-gpio.txt
new file mode 100644
index 000000000000..5c9246c054e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/cortina,gemini-gpio.txt
@@ -0,0 +1,24 @@
+Cortina Systems Gemini GPIO Controller
+
+Required properties:
+
+- compatible : Must be "cortina,gemini-gpio"
+- reg : Should contain registers location and length
+- interrupts : Should contain the interrupt line for the GPIO block
+- gpio-controller : marks this as a GPIO controller
+- #gpio-cells : Should be 2, see gpio/gpio.txt
+- interrupt-controller : marks this as an interrupt controller
+- #interrupt-cells : a standard two-cell interrupt flag, see
+  interrupt-controller/interrupts.txt
+
+Example:
+
+gpio at 4d000000 {
+	compatible = "cortina,gemini-gpio";
+	reg = <0x4d000000 0x100>;
+	interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
-- 
2.9.3
