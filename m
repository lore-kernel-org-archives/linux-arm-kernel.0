From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  1 Aug 2018 09:09:10 +0530
Subject: [PATCH v2 05/10] dt-bindings: reset: Add Actions Semi S700 SoC RMU
 support
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180801033915.15880-6-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add RMU (Reset Management Unit) support for the Actions Semi S700
SoC which is a part of the Actions Semi Owl family series.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/reset/actions,owl-reset.txt      |  8 +++--
 include/dt-bindings/reset/actions,s700-rmu.h  | 34 +++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/reset/actions,s700-rmu.h

diff --git a/Documentation/devicetree/bindings/reset/actions,owl-reset.txt b/Documentation/devicetree/bindings/reset/actions,owl-reset.txt
index 38e2c7051d86..a29950cb2db0 100644
--- a/Documentation/devicetree/bindings/reset/actions,owl-reset.txt
+++ b/Documentation/devicetree/bindings/reset/actions,owl-reset.txt
@@ -7,12 +7,14 @@ controller binding usage.
 The RMU registers are part of the system-controller block on Owl SoCs.
 
 Required properties:
-- compatible: Should be "actions,s900-rmu"
+- compatible: Should be one of the following,
+       "actions,s900-rmu"
+       "actions,s700-rmu"
 - #reset-cells: Should be 1
 
 All available resets are defined as preprocessor macros in corresponding
-dt-bindings/reset/actions,s900-rmu.h header and can be used in device
-tree sources.
+dt-bindings/reset/actions,s900-rmu.h or actions,s700-rmu.h header and can
+be used in device tree sources.
 
 Parent node should have the following properties :
 - compatible: "syscon", "simple-mfd"
diff --git a/include/dt-bindings/reset/actions,s700-rmu.h b/include/dt-bindings/reset/actions,s700-rmu.h
new file mode 100644
index 000000000000..8c5d4d1b8bd4
--- /dev/null
+++ b/include/dt-bindings/reset/actions,s700-rmu.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+//
+// Device Tree binding constants for Actions Semi S700 Reset Management Unit
+//
+// Copyright (c) 2018 Linaro Ltd.
+
+#ifndef _DT_BINDINGS_ACTIONS_S700_RESET_H
+#define _DT_BINDINGS_ACTIONS_S700_RESET_H
+
+#define S700_RESET_AUDIO		0
+#define S700_RESET_CSI			1
+#define S700_RESET_DE			2
+#define S700_RESET_DSI			3
+#define S700_RESET_GPIO			4
+#define S700_RESET_I2C0			5
+#define S700_RESET_I2C1			6
+#define S700_RESET_I2C2			7
+#define S700_RESET_I2C3			8
+#define S700_RESET_KEY			9
+#define S700_RESET_LCD0			10
+#define S700_RESET_SI			11
+#define S700_RESET_SPI0			12
+#define S700_RESET_SPI1			13
+#define S700_RESET_SPI2			14
+#define S700_RESET_SPI3			15
+#define S700_RESET_UART0		16
+#define S700_RESET_UART1		17
+#define S700_RESET_UART2		18
+#define S700_RESET_UART3		19
+#define S700_RESET_UART4		20
+#define S700_RESET_UART5		21
+#define S700_RESET_UART6		22
+
+#endif /* _DT_BINDINGS_ACTIONS_S700_RESET_H */
-- 
2.17.1
