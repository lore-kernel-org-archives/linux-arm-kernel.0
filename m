From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:15:41 +0200
Subject: [PATCH 21/41] ARM: dts: r8a7792: add power domain index macros
In-Reply-To: <cover.1467294011.git.horms+renesas@verge.net.au>
References: <cover.1467294011.git.horms+renesas@verge.net.au>
Message-ID: <5258bb5d980024dae22f4256329caec4fe5e98b3.1467294011.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add macros usable by the device tree sources to reference R8A7792 SYSC power
domains by index.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/power/r8a7792-sysc.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a7792-sysc.h

diff --git a/include/dt-bindings/power/r8a7792-sysc.h b/include/dt-bindings/power/r8a7792-sysc.h
new file mode 100644
index 000000000000..74f4a78e29aa
--- /dev/null
+++ b/include/dt-bindings/power/r8a7792-sysc.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2016 Cogent Embedded Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A7792_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A7792_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A7792_PD_CA15_CPU0		0
+#define R8A7792_PD_CA15_CPU1		1
+#define R8A7792_PD_CA15_SCU		12
+#define R8A7792_PD_SGX			20
+#define R8A7792_PD_IMP			24
+
+/* Always-on power area */
+#define R8A7792_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A7792_SYSC_H__ */
-- 
2.7.0.rc3.207.g0ac5344
