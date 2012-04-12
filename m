From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 12 Apr 2012 11:04:39 -0700
Subject: [PATCH] arm: iomap.c: include asm/vga.h to pickup declaration of
 exported symbol
Message-ID: <201204121104.39408.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include <asm/vga.h> to pickup the declaration of the exported symbol
'vga_base'.

This quiets the sparse warning:

warning: symbol 'vga_base' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
index 4614208..af177d6 100644
--- a/arch/arm/mm/iomap.c
+++ b/arch/arm/mm/iomap.c
@@ -9,6 +9,8 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 
+#include <asm/vga.h>
+
 unsigned long vga_base;
 EXPORT_SYMBOL(vga_base);
 
