From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  3 Apr 2013 17:34:57 -0600
Subject: [PATCH V2 6/7] ARM: dt: add header to define IRQ flags
In-Reply-To: <1365032098-22825-1-git-send-email-swarren@wwwdotorg.org>
References: <1365032098-22825-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365032098-22825-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Many IRQ device tree bindings use the same flags. Create a header to
define those.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: No change.
v1: Moved header. Added include guard.
    (this patch was previously posted separately, hence there are
    changes in v1!)
---
 include/dt-bindings/interrupt-controller/irq.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/interrupt-controller/irq.h

diff --git a/include/dt-bindings/interrupt-controller/irq.h b/include/dt-bindings/interrupt-controller/irq.h
new file mode 100644
index 0000000..33a1003
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/irq.h
@@ -0,0 +1,19 @@
+/*
+ * This header provides constants for most IRQ bindings.
+ *
+ * Most IRQ bindings include a flags cell as part of the IRQ specifier.
+ * In most cases, the format of the flags cell uses the standard values
+ * defined in this header.
+ */
+
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_H
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_H
+
+#define IRQ_TYPE_NONE		0
+#define IRQ_TYPE_EDGE_RISING	1
+#define IRQ_TYPE_EDGE_FALLING	2
+#define IRQ_TYPE_EDGE_BOTH	(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
+#define IRQ_TYPE_LEVEL_HIGH	4
+#define IRQ_TYPE_LEVEL_LOW	8
+
+#endif
-- 
1.7.10.4
