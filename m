From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 16:05:08 +0100
Subject: [PATCH 4/9] ARM: fix missing <asm/vga.h> in arch/arm/mm/iomap.c
In-Reply-To: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466175913-19067-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vga_base is exported but has no declaration, so fix the
warning by including the declaration in <asm/vga.h>.

arch/arm/mm/iomap.c:12:15: warning: symbol 'vga_base' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mm/iomap.c | 2 ++
 1 file changed, 2 insertions(+)

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
 
-- 
2.8.1
