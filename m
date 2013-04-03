From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  3 Apr 2013 17:34:56 -0600
Subject: [PATCH V2 5/7] ARM: dt: add header to define GPIO flags
In-Reply-To: <1365032098-22825-1-git-send-email-swarren@wwwdotorg.org>
References: <1365032098-22825-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365032098-22825-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Many GPIO device tree bindings use the same flags. Create a header to
define those.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: No change.
v1: Moved header. Added include guard.
    (this patch was previously posted separately, hence there are
    changes in v1!)
---
 include/dt-bindings/gpio/gpio.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 include/dt-bindings/gpio/gpio.h

diff --git a/include/dt-bindings/gpio/gpio.h b/include/dt-bindings/gpio/gpio.h
new file mode 100644
index 0000000..e6b1e0a
--- /dev/null
+++ b/include/dt-bindings/gpio/gpio.h
@@ -0,0 +1,15 @@
+/*
+ * This header provides constants for most GPIO bindings.
+ *
+ * Most GPIO bindings include a flags cell as part of the GPIO specifier.
+ * In most cases, the format of the flags cell uses the standard values
+ * defined in this header.
+ */
+
+#ifndef _DT_BINDINGS_GPIO_GPIO_H
+#define _DT_BINDINGS_GPIO_GPIO_H
+
+#define GPIO_ACTIVE_HIGH 0
+#define GPIO_ACTIVE_LOW 1
+
+#endif
-- 
1.7.10.4
