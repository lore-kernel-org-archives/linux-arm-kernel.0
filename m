From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 14:33:11 -0700
Subject: [PATCH 2/9] ARM: dt: add header to define IRQ flags
In-Reply-To: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360791198-29462-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Many IRQ device tree bindings use the same flags. Create a header to
define those.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/irq.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 arch/arm/boot/dts/irq.h

diff --git a/arch/arm/boot/dts/irq.h b/arch/arm/boot/dts/irq.h
new file mode 100644
index 0000000..165d039
--- /dev/null
+++ b/arch/arm/boot/dts/irq.h
@@ -0,0 +1,14 @@
+/*
+ * This header provides constants for most IRQ bindings.
+ *
+ * Most IRQ bindings include a flags cell as part of the IRQ specifier.
+ * In most cases, the format of the flags cell uses the standard values
+ * defined in this header.
+ */
+
+#define IRQ_TYPE_NONE		0
+#define IRQ_TYPE_EDGE_RISING	1
+#define IRQ_TYPE_EDGE_FALLING	2
+#define IRQ_TYPE_EDGE_BOTH	(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
+#define IRQ_TYPE_LEVEL_HIGH	4
+#define IRQ_TYPE_LEVEL_LOW	8
-- 
1.7.10.4
