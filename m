From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 14:33:12 -0700
Subject: [PATCH 3/9] ARM: dt: create a DT header for the GIC
In-Reply-To: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
References: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360791198-29462-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The ARM GIC binding defines a few custom cells and flags for its IRQ
specifier. Provide names for those.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/arm-gic.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 arch/arm/boot/dts/arm-gic.h

diff --git a/arch/arm/boot/dts/arm-gic.h b/arch/arm/boot/dts/arm-gic.h
new file mode 100644
index 0000000..5b1bc85
--- /dev/null
+++ b/arch/arm/boot/dts/arm-gic.h
@@ -0,0 +1,17 @@
+/*
+ * This header provides constants for the ARM GIC.
+ */
+
+#include "irq.h"
+
+/* interrupt specific cell 0 */
+
+#define GIC_SPI 0
+#define GIC_PPI 1
+
+/*
+ * Interrupt specifier cell 2.
+ * The flaggs in irq.h are valid, plus those below.
+ */
+#define GIC_CPU_MASK_RAW(x) ((x) << 8)
+#define GIC_CPU_MASK_SIMPLE(num) GIC_CPU_MASK_RAW((1 << (num)) - 1)
-- 
1.7.10.4
