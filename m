From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:53:10 +1030
Subject: [PATCH v3 02/20] dt-bindings: gpio: Add ASPEED constants
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-3-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are used to by the device tree to map pin numbers to constants
required by the GPIO bindings.

Signed-off-by: Joel Stanley <joel@jms.id.au>
--
v3:
 - Remove dtsi includes from this patch, they will come later
---
 include/dt-bindings/gpio/aspeed-gpio.h | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 include/dt-bindings/gpio/aspeed-gpio.h

diff --git a/include/dt-bindings/gpio/aspeed-gpio.h b/include/dt-bindings/gpio/aspeed-gpio.h
new file mode 100644
index 000000000000..56fc4889b2c4
--- /dev/null
+++ b/include/dt-bindings/gpio/aspeed-gpio.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * This header provides constants for binding aspeed,*-gpio.
+ *
+ * The first cell in Aspeed's GPIO specifier is the GPIO ID. The macros below
+ * provide names for this.
+ *
+ * The second cell contains standard flag values specified in gpio.h.
+ */
+
+#ifndef _DT_BINDINGS_GPIO_ASPEED_GPIO_H
+#define _DT_BINDINGS_GPIO_ASPEED_GPIO_H
+
+#include <dt-bindings/gpio/gpio.h>
+
+#define ASPEED_GPIO_PORT_A 0
+#define ASPEED_GPIO_PORT_B 1
+#define ASPEED_GPIO_PORT_C 2
+#define ASPEED_GPIO_PORT_D 3
+#define ASPEED_GPIO_PORT_E 4
+#define ASPEED_GPIO_PORT_F 5
+#define ASPEED_GPIO_PORT_G 6
+#define ASPEED_GPIO_PORT_H 7
+#define ASPEED_GPIO_PORT_I 8
+#define ASPEED_GPIO_PORT_J 9
+#define ASPEED_GPIO_PORT_K 10
+#define ASPEED_GPIO_PORT_L 11
+#define ASPEED_GPIO_PORT_M 12
+#define ASPEED_GPIO_PORT_N 13
+#define ASPEED_GPIO_PORT_O 14
+#define ASPEED_GPIO_PORT_P 15
+#define ASPEED_GPIO_PORT_Q 16
+#define ASPEED_GPIO_PORT_R 17
+#define ASPEED_GPIO_PORT_S 18
+#define ASPEED_GPIO_PORT_T 19
+#define ASPEED_GPIO_PORT_U 20
+#define ASPEED_GPIO_PORT_V 21
+#define ASPEED_GPIO_PORT_W 22
+#define ASPEED_GPIO_PORT_X 23
+#define ASPEED_GPIO_PORT_Y 24
+#define ASPEED_GPIO_PORT_Z 25
+#define ASPEED_GPIO_PORT_AA 26
+#define ASPEED_GPIO_PORT_AB 27
+#define ASPEED_GPIO_PORT_AC 28
+
+#define ASPEED_GPIO(port, offset) \
+	((ASPEED_GPIO_PORT_##port * 8) + offset)
+
+#endif
-- 
2.15.1
