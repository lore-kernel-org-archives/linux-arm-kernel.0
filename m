From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 May 2017 10:20:31 +0200
Subject: [PATCH 1/2 v4] clk: add DT bindings header for Gemini clock controller
Message-ID: <20170524082031.8424-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DT binding macros used by the clock controller.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mike/Stephen: please merge this into the clock subsystem once
you're happy with it. Sorry for the back-and-forth. I will
deal with the ARM SoC DTS landing orthogonally.

The DTS files will be submitted with numerical values for
the reset lines, then a follow-up patch after -rc1 will
switch to using defines. This strategy was adviced by the
ARM SoC maintainers.

ChangeLog v1->v4:
- New file to merge the macros in isolation from the
  DT bindings and implementation.

The bindings themselves will be merged as part of the DTS updates
through the ARM SoC tree.
---
 include/dt-bindings/clock/cortina,gemini-clock.h | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/clock/cortina,gemini-clock.h

diff --git a/include/dt-bindings/clock/cortina,gemini-clock.h b/include/dt-bindings/clock/cortina,gemini-clock.h
new file mode 100644
index 000000000000..acf5cd550b0c
--- /dev/null
+++ b/include/dt-bindings/clock/cortina,gemini-clock.h
@@ -0,0 +1,29 @@
+#ifndef DT_BINDINGS_CORTINA_GEMINI_CLOCK_H
+#define DT_BINDINGS_CORTINA_GEMINI_CLOCK_H
+
+/* RTC, AHB, APB, CPU, PCI, TVC, UART clocks and 13 gates */
+#define GEMINI_NUM_CLKS 20
+
+#define GEMINI_CLK_RTC 0
+#define GEMINI_CLK_AHB 1
+#define GEMINI_CLK_APB 2
+#define GEMINI_CLK_CPU 3
+#define GEMINI_CLK_PCI 4
+#define GEMINI_CLK_TVC 5
+#define GEMINI_CLK_UART 6
+#define GEMINI_CLK_GATES 7
+#define GEMINI_CLK_GATE_SECURITY 7
+#define GEMINI_CLK_GATE_GMAC0 8
+#define GEMINI_CLK_GATE_GMAC1 9
+#define GEMINI_CLK_GATE_SATA0 10
+#define GEMINI_CLK_GATE_SATA1 11
+#define GEMINI_CLK_GATE_USB0 12
+#define GEMINI_CLK_GATE_USB1 13
+#define GEMINI_CLK_GATE_IDE 14
+#define GEMINI_CLK_GATE_PCI 15
+#define GEMINI_CLK_GATE_DDR 16
+#define GEMINI_CLK_GATE_FLASH 17
+#define GEMINI_CLK_GATE_TVC 18
+#define GEMINI_CLK_GATE_BOOT 19
+
+#endif /* DT_BINDINGS_CORTINA_GEMINI_CLOCK_H */
-- 
2.9.4
