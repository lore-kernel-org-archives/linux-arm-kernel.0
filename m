From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:54:26 +1030
Subject: [PATCH v2 02/19] dt-bindings: gpio: Add ASPEED constants
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-3-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are used to by the device tree to map pin numbers to constants
required by the GPIO bindings.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi       |  1 +
 arch/arm/boot/dts/aspeed-g5.dtsi       |  1 +
 include/dt-bindings/gpio/aspeed-gpio.h | 49 ++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 include/dt-bindings/gpio/aspeed-gpio.h

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 45d815a86d42..100d092e6c07 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
 
 / {
 	model = "Aspeed BMC";
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 5c4ecdba3a6b..1f9d28313f82 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
 
 / {
 	model = "Aspeed BMC";
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
2.14.1
