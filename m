From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:17:07 +0100
Subject: [PATCH 04/22] clocksource: add DT bindings for Cortina Gemini
Message-ID: <20170122121707.10200-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for the Cortina Systems Gemini
timer block used in these SoCs.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
clocksource maintainers: please just apply this when you feel
pleased with it. These portions are functionally orthogonal to
the series, it is just in a series for context.
---
 .../bindings/timer/cortina,gemini-timer.txt        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/cortina,gemini-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/cortina,gemini-timer.txt b/Documentation/devicetree/bindings/timer/cortina,gemini-timer.txt
new file mode 100644
index 000000000000..16ea1d3b2e9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/cortina,gemini-timer.txt
@@ -0,0 +1,22 @@
+Cortina Systems Gemini timer
+
+This timer is embedded in the Cortina Systems Gemini SoCs.
+
+Required properties:
+
+- compatible : Must be "cortina,gemini-timer"
+- reg : Should contain registers location and length
+- interrupts : Should contain the three timer interrupts with
+  flags for rising edge
+- syscon : a phandle to the global Gemini system controller
+
+Example:
+
+timer at 43000000 {
+	compatible = "cortina,gemini-timer";
+	reg = <0x43000000 0x1000>;
+	interrupts = <14 IRQ_TYPE_EDGE_RISING>, /* Timer 1 */
+		   <15 IRQ_TYPE_EDGE_RISING>, /* Timer 2 */
+		   <16 IRQ_TYPE_EDGE_RISING>; /* Timer 3 */
+	syscon = <&syscon>;
+};
-- 
2.9.3
