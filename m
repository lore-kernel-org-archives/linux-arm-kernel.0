From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:28 +0100
Subject: [PATCH 06/14] dt-bindings: power: add R8A77980 SYSC power domain
 definitions
In-Reply-To: <cover.1521211738.git.horms+renesas@verge.net.au>
References: <cover.1521211738.git.horms+renesas@verge.net.au>
Message-ID: <7755b40d07a8dba723aadcb9a1d2828331f3f1b3.1521211738.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add macros usable by the device tree sources to reference R8A77980 SYSC
power domains by index.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/power/r8a77980-sysc.h | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a77980-sysc.h

diff --git a/include/dt-bindings/power/r8a77980-sysc.h b/include/dt-bindings/power/r8a77980-sysc.h
new file mode 100644
index 000000000000..2c90c1237725
--- /dev/null
+++ b/include/dt-bindings/power/r8a77980-sysc.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2018 Renesas Electronics Corp.
+ * Copyright (C) 2018 Cogent Embedded, Inc.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A77980_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A77980_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A77980_PD_A2SC2		0
+#define R8A77980_PD_A2SC3		1
+#define R8A77980_PD_A2SC4		2
+#define R8A77980_PD_A2PD0		3
+#define R8A77980_PD_A2PD1		4
+#define R8A77980_PD_CA53_CPU0		5
+#define R8A77980_PD_CA53_CPU1		6
+#define R8A77980_PD_CA53_CPU2		7
+#define R8A77980_PD_CA53_CPU3		8
+#define R8A77980_PD_A2CN		10
+#define R8A77980_PD_A3VIP		11
+#define R8A77980_PD_A2IR5		12
+#define R8A77980_PD_CR7			13
+#define R8A77980_PD_A2IR4		15
+#define R8A77980_PD_CA53_SCU		21
+#define R8A77980_PD_A2IR0		23
+#define R8A77980_PD_A3IR		24
+#define R8A77980_PD_A3VIP1		25
+#define R8A77980_PD_A3VIP2		26
+#define R8A77980_PD_A2IR1		27
+#define R8A77980_PD_A2IR2		28
+#define R8A77980_PD_A2IR3		29
+#define R8A77980_PD_A2SC0		30
+#define R8A77980_PD_A2SC1		31
+
+/* Always-on power area */
+#define R8A77980_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A77980_SYSC_H__ */
-- 
2.11.0
