From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:04:03 +0200
Subject: [PATCH 2/4] soc: renesas: Add r8a77995 SYSC PM Domain Binding
 Definitions
In-Reply-To: <cover.1501511923.git.horms+renesas@verge.net.au>
References: <cover.1501511923.git.horms+renesas@verge.net.au>
Message-ID: <ee011c5b4c43b215a985c7d4368f77a572c5c216.1501511923.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add power domain indices for R-Car D3.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/power/r8a77995-sysc.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a77995-sysc.h

diff --git a/include/dt-bindings/power/r8a77995-sysc.h b/include/dt-bindings/power/r8a77995-sysc.h
new file mode 100644
index 000000000000..09d0ed575b73
--- /dev/null
+++ b/include/dt-bindings/power/r8a77995-sysc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2017 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A77995_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A77995_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A77995_PD_CA53_CPU0		 5
+#define R8A77995_PD_CA53_SCU		21
+
+/* Always-on power area */
+#define R8A77995_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A77995_SYSC_H__ */
-- 
2.1.4
