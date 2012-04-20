From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Thu, 19 Apr 2012 17:31:52 -0700
Subject: [RESEND PATCH] ARM: BCMRING: Add debug macro
In-Reply-To: <CAOesGMh8EA66uajVeauJj8vviATLEnNHODeNyyas0iC1vQjMww@mail.gmail.com>
References: <1334605108-28616-1-git-send-email-paul.gortmaker@windriver.com>
 <4F8C7617.5080902@broadcom.com> <4F8D7150.9060201@windriver.com>
 <CAOesGMh8EA66uajVeauJj8vviATLEnNHODeNyyas0iC1vQjMww@mail.gmail.com>
Message-ID: <4F90AE78.9060108@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add debug macro to bcmring so that it supports LL debug and early printk.

Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>
---
arch/arm/mach-bcmring/include/mach/debug-macro.S |   19 +++++++++++++++++++
  1 files changed, 19 insertions(+), 0 deletions(-)
  create mode 100755 arch/arm/mach-bcmring/include/mach/debug-macro.S

diff --git a/arch/arm/mach-bcmring/include/mach/debug-macro.S 
b/arch/arm/mach-bcmring/include/mach/debug-macro.S
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
+        .macro    addruart, rp, rv, tmp
+        mov    \rp,      #0x00012000
+        orr    \rv, \rp, #0xf8000000    @ virtual base
+        orr    \rp, \rp, #0x80000000    @ physical base
+        .endm
+
+#include <asm/hardware/debug-pl01x.S>
-- 
1.7.9.1
