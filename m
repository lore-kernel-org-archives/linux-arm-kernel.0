From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Apr 2017 20:55:45 +0200
Subject: [PATCH 1/2] clk: Add bindings for the Gemini Clock Controller
Message-ID: <20170424185545.26608-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings and a header for the Gemini SoC
Clock Controller.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../clock/cortina,gemini-clock-controller.txt      | 25 +++++++++++++++++++
 include/dt-bindings/clock/cortina,gemini-clock.h   | 29 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/cortina,gemini-clock-controller.txt
 create mode 100644 include/dt-bindings/clock/cortina,gemini-clock.h

diff --git a/Documentation/devicetree/bindings/clock/cortina,gemini-clock-controller.txt b/Documentation/devicetree/bindings/clock/cortina,gemini-clock-controller.txt
new file mode 100644
index 000000000000..7af84acfcbce
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/cortina,gemini-clock-controller.txt
@@ -0,0 +1,25 @@
+Clock bindings for the Cortina Systems Gemini SoC Clock Controller
+
+Required properties :
+- compatible : shall contain the following:
+  "cortina,gemini-clock-controller"
+- #clock-cells should be <1>
+
+The Gemini clock controller needs to be placed as a subnode of the
+system controller.
+
+All available clocks are defined as preprocessor macros in
+dt-bindings/clock/cortina,gemini-clock.h header and can be used in device
+tree sources.
+
+Example:
+
+syscon: syscon at 40000000 {
+	compatible = "cortina,gemini-syscon", "syscon", "simple-mfd";
+	reg = <0x40000000 0x1000>;
+
+	clock-controller {
+		compatible = "cortina,gemini-clock-controller";
+		#clock-cells = <1>;
+	};
+};
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
2.9.3
