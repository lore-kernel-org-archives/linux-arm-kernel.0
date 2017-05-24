From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 May 2017 10:19:08 +0200
Subject: [PATCH 1/2] reset: add DT bindings header for Gemini reset controller
Message-ID: <20170524081908.8255-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DT binding macros used by the reset controller.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Philipp: please merge this into the reset subsystem once
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
 include/dt-bindings/reset/cortina,gemini-reset.h | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/dt-bindings/reset/cortina,gemini-reset.h

diff --git a/include/dt-bindings/reset/cortina,gemini-reset.h b/include/dt-bindings/reset/cortina,gemini-reset.h
new file mode 100644
index 000000000000..0b886aee65e3
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
+#define GEMINI_RESET_TVC	28
+#define GEMINI_RESET_CPU1	30
+#define GEMINI_RESET_GLOBAL	31
+
+#endif
-- 
2.9.4
