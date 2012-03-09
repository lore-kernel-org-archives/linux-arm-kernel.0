From: jdzheng@broadcom.com (JD (Jiandong) Zheng)
Date: Fri, 9 Mar 2012 14:07:42 -0800
Subject: [PATCH] ARM: BCMRING: Add debug macro
Message-ID: <8628FE4E7912BF47A96AE7DD7BAC0AAD0109D7942F1D@SJEXCHCCR02.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add debug macro to bcmring so that it supports LL debug and early printk.

Signed-off-by: Jiandong Zheng jdzheng at broadcom.com
---
 arch/arm/mach-bcmring/include/mach/debug-macro.S |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100755 arch/arm/mach-bcmring/include/mach/debug-macro.S

diff --git a/arch/arm/mach-bcmring/include/mach/debug-macro.S b/arch/arm/mach-bcmring/include/mach/debug-macro.S
new file mode 100755
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
+		.macro	addruart, rp, rv, tmp
+		mov	\rp,      #0x00012000
+		orr	\rv, \rp, #0xf8000000	@ virtual base
+		orr	\rp, \rp, #0x80000000	@ physical base
+		.endm
+
+#include <asm/hardware/debug-pl01x.S>
-- 
1.7.9.1
