From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 12 Mar 2017 23:36:01 +0100
Subject: [PATCH 1/2 RESEND] power: reset: Add Gemini poweroff DT bindings
Message-ID: <20170312223601.2952-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings to the power management controller
in the Gemini SoC.

Cc: devicetree at vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sebastian: please just merge this when your are pleased
with it. I will funnel the ARM parts through the ARM SoC tree.
---
 .../devicetree/bindings/power/reset/gemini-poweroff.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt
new file mode 100644
index 000000000000..7fec3e100214
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt
@@ -0,0 +1,17 @@
+* Device-Tree bindings for Cortina Systems Gemini Poweroff
+
+This is a special IP block in the Cortina Gemini SoC that only
+deals with different ways to power the system down.
+
+Required properties:
+- compatible: should be "cortina,gemini-power-controller"
+- reg: should contain the physical memory base and size
+- interrupts: should contain the power management interrupt
+
+Example:
+
+power-controller at 4b000000 {
+	compatible = "cortina,gemini-power-controller";
+	reg = <0x4b000000 0x100>;
+	interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.9.3
