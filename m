From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:04:34 +0100
Subject: [PATCH 1/4] ARM: shmobile: r8a7745: add power domain index macros
In-Reply-To: <cover.1479389981.git.horms+renesas@verge.net.au>
References: <cover.1479389981.git.horms+renesas@verge.net.au>
Message-ID: <46f62e7c654d2a16ef2f977c7088934bfaf8a132.1479389981.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add macros usable by the device tree sources to reference R8A7745 SYSC power
domains by index.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/power/r8a7745-sysc.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a7745-sysc.h

diff --git a/include/dt-bindings/power/r8a7745-sysc.h b/include/dt-bindings/power/r8a7745-sysc.h
new file mode 100644
index 000000000000..1844c1171c04
--- /dev/null
+++ b/include/dt-bindings/power/r8a7745-sysc.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2016 Cogent Embedded Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A7745_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A7745_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A7745_PD_CA7_CPU0		 5
+#define R8A7745_PD_CA7_CPU1		 6
+#define R8A7745_PD_SGX			20
+#define R8A7745_PD_CA7_SCU		21
+
+/* Always-on power area */
+#define R8A7745_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A7745_SYSC_H__ */
-- 
2.7.0.rc3.207.g0ac5344
