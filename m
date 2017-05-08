From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  8 May 2017 22:07:20 +0200
Subject: [PATCH 1/2 v2] reset: Add DT bindings for the Gemini reset controller
Message-ID: <20170508200720.26145-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a simple reset controller in a single 32bit
register.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Move the reset controller node to be the same as the syscon
  node, no need for a specific child node.
- Add an include file with nice #defines.
---
 .../bindings/reset/cortina,gemini-reset.txt        | 58 ++++++++++++++++++++++
 include/dt-bindings/reset/cortina,gemini-reset.h   | 36 ++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/cortina,gemini-reset.txt
 create mode 100644 include/dt-bindings/reset/cortina,gemini-reset.h

diff --git a/Documentation/devicetree/bindings/reset/cortina,gemini-reset.txt b/Documentation/devicetree/bindings/reset/cortina,gemini-reset.txt
new file mode 100644
index 000000000000..aa3d1b2a9677
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/cortina,gemini-reset.txt
@@ -0,0 +1,58 @@
+Cortina Gemini Reset Controller
+
+This reset controller is found in Cortina Systems CS3516 and
+the predecessor StorLink SL3516.
+
+Required properties:
+- compatible: "cortina,gemini-reset"
+- #reset-cells: Must be 1
+
+The Gemini reset controller must be identical to the system controller node.
+Apart from this it follows the standard reset controller bindings.
+
+Valid reset line values:
+
+0:  DRAM controller
+1:  Flash controller
+2:  IDE controller
+3:  RAID controller
+4:  Security module
+5:  GMAC0 (ethernet)
+6:  GMAC1 (ethernet)
+7:  PCI host bridge
+8:  USB0 USB host controller
+9:  USB1 USB host controller
+10: General DMA controller
+11: APB bridge
+12: LPC (Low Pin Count) controller
+13: LCD module
+14: Interrupt controller 0
+15: Interrupt controller 1
+16: RTC module
+17: Timer module
+18: UART controller
+19: SSP controller
+20: GPIO0 GPIO controller
+21: GPIO1 GPIO controller
+22: GPIO2 GPIO controller
+23: Watchdog timer
+24: External device reset
+25: CIR module (infrared)
+26: SATA0 SATA bridge
+27: SATA1 SATA bridge
+28: TVE TV Encoder module
+29: Reserved
+30: CPU1 reset
+31: Global soft reset
+
+These also have shorthand defines in the include file:
+<dt-bindings/reset/cortina,gemini-reset.h>
+
+Example:
+
+syscon: syscon at 40000000 {
+	compatible = "cortina,gemini-syscon", "cortina,gemini-reset",
+		     "syscon", "simple-mfd";
+	reg = <0x40000000 0x1000>;
+	#reset-cells = <1>;
+};
diff --git a/include/dt-bindings/reset/cortina,gemini-reset.h b/include/dt-bindings/reset/cortina,gemini-reset.h
new file mode 100644
index 000000000000..aebecae43721
--- /dev/null
+++ b/include/dt-bindings/reset/cortina,gemini-reset.h
@@ -0,0 +1,36 @@
+#ifndef _DT_BINDINGS_RESET_CORTINA_GEMINI_H
+#define _DT_BINDINGS_RESET_CORTINA_GEMINI_H
+
+#define GEMINI_RESET_DRAM	0
+#define GEMINI_RESET_FLASH	1
+#define GEMINI_RESET_IDE	2
+#define GEMINI_RESET_RAID	3
+#define GEMINI_RESET_SECURITY	4
+#define GEMINI_RESET_GMAC0	5
+#define GEMINI_RESET_GMAC1	6
+#define GEMINI_RESET_PCI	7
+#define GEMINI_RESET_USB0	8
+#define GEMINI_RESET_USB1	9
+#define GEMINI_RESET_DMAC	10
+#define GEMINI_RESET_APB	11
+#define GEMINI_RESET_LPC	12
+#define GEMINI_RESET_LCD	13
+#define GEMINI_RESET_INTCON0	14
+#define GEMINI_RESET_INTCON1	15
+#define GEMINI_RESET_RTC	16
+#define GEMINI_RESET_TIMER	17
+#define GEMINI_RESET_UART	18
+#define GEMINI_RESET_SSP	19
+#define GEMINI_RESET_GPIO0	20
+#define GEMINI_RESET_GPIO1	21
+#define GEMINI_RESET_GPIO2	22
+#define GEMINI_RESET_WDOG	23
+#define GEMINI_RESET_EXTERN	24
+#define GEMINI_RESET_CIR	25
+#define GEMINI_RESET_SATA0	26
+#define GEMINI_RESET_SATA1	27
+#define GEMINI_RESET_TVE	28
+#define GEMINI_RESET_CPU1	30
+#define GEMINI_RESET_GLOBAL	31
+
+#endif
-- 
2.9.3
