From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Mon, 7 May 2012 12:35:01 -0700
Subject: [PATCH] ARM: BCMRING: Add debug macro
Message-ID: <4FA823E5.8070100@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add debug macro for bcmring.

It is to support low-level debugging and earlyprintk.

Signed-off-by: Jiandong Zheng<jdzheng@broadcom.com  <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>>
---
   arch/arm/mach-bcmring/include/mach/debug-macro.S |   19
+++++++++++++++++++
   1 file changed, 19 insertions(+)
   create mode 100644 arch/arm/mach-bcmring/include/mach/debug-macro.S

diff --git a/arch/arm/mach-bcmring/include/mach/debug-macro.S
b/arch/arm/mach-bcmring/include/mach/debug-macro.S
new file mode 100644
index 0000000..fae01fd
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/debug-macro.S
@@ -0,0 +1,19 @@
+/* arch/arm/mach-bcmring/include/mach/debug-macro.S
+ *
+ * Debugging macro include header
+ *
+ *  Based on arch/arm/mach-versatile/include/mach/debug-macro.S
+ *  by Jiandong Zheng
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+        .macro    addruart, rp, rv, tmp
+        mov    \rp,      #0x00012000
+        orr    \rv, \rp, #0xf8000000    @ virtual base
+        orr    \rp, \rp, #0x80000000    @ physical base
+        .endm
+
+#include<asm/hardware/debug-pl01x.S>
-- 
1.7.9.5
