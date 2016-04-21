From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 21 Apr 2016 13:44:46 +1000
Subject: [PATCH 4/7] soc: renesas: Add r8a7791 SYSC PM Domain Binding
 Definitions
In-Reply-To: <cover.1461210185.git.horms+renesas@verge.net.au>
References: <cover.1461210185.git.horms+renesas@verge.net.au>
Message-ID: <434ac75a28d8b2aec08b6b8e080d793857c1b090.1461210185.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/power/r8a7791-sysc.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a7791-sysc.h

diff --git a/include/dt-bindings/power/r8a7791-sysc.h b/include/dt-bindings/power/r8a7791-sysc.h
new file mode 100644
index 000000000000..1403baa0514f
--- /dev/null
+++ b/include/dt-bindings/power/r8a7791-sysc.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2016 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A7791_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A7791_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A7791_PD_CA15_CPU0		 0
+#define R8A7791_PD_CA15_CPU1		 1
+#define R8A7791_PD_CA15_SCU		12
+#define R8A7791_PD_SH_4A		16
+#define R8A7791_PD_SGX			20
+
+/* Always-on power area */
+#define R8A7791_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A7791_SYSC_H__ */
-- 
2.7.0.rc3.207.g0ac5344
