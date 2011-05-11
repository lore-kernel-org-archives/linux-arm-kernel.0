From: jdzheng@broadcom.com (JD (Jiandong) Zheng)
Date: Wed, 11 May 2011 15:14:46 -0700
Subject: [PATCH] Add low level debug and early printk support in BCMRING
Message-ID: <8628FE4E7912BF47A96AE7DD7BAC0AADE080FD2191@SJEXCHCCR02.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add BCMRING debug macro for LL_DEBUG and early printk.

Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>
---
 arch/arm/mach-bcmring/include/mach/debug-macro.S |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100755 arch/arm/mach-bcmring/include/mach/debug-macro.S

diff --git a/arch/arm/mach-bcmring/include/mach/debug-macro.S b/arch/arm/mach-bcmring/include/mach/debug-macro.S
new file mode 100755
index 0000000..a7e08f8
--- /dev/null
+++ b/arch/arm/mach-bcmring/include/mach/debug-macro.S
@@ -0,0 +1,21 @@
+/* arch/arm/mach-bcmring/include/mach/debug-macro.S
+ *
+ * Debugging macro include header
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *  Based on arch/arm/mach-versatile/include/mach/debug-macro.S 
+ *      by Jiandong Zheng
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+		.macro	addruart, rp, rv
+		mov	\rp,      #0x00012000
+		orr	\rv, \rp, #0xf8000000	@ virtual base
+		orr	\rp, \rp, #0x80000000	@ physical base
+		.endm
+
+#include <asm/hardware/debug-pl01x.S>
-- 
1.7.4.1
