From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed,  4 Feb 2015 15:22:43 -0800
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
Message-ID: <1423092164-9145-1-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cma reserved information to the ARM-specific show_mem.  It was
added to the generic implementation by commit
49abd8c28046adf77c5ce1949549aa64d7221881 "lib/show_mem.c: add cma
reserved information".

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 arch/arm/mm/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 2495c8c..da77507 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -22,6 +22,7 @@
 #include <linux/memblock.h>
 #include <linux/dma-contiguous.h>
 #include <linux/sizes.h>
+#include <linux/cma.h>
 
 #include <asm/cp15.h>
 #include <asm/mach-types.h>
@@ -130,6 +131,9 @@ void show_mem(unsigned int filter)
 	printk("%d pages of RAM\n", total);
 	printk("%d free pages\n", free);
 	printk("%d reserved pages\n", reserved);
+#ifdef CONFIG_CMA
+	printk("%lu cma reserved pages\n", totalcma_pages);
+#endif
 	printk("%d slab pages\n", slab);
 	printk("%d pages shared\n", shared);
 	printk("%d pages swap cached\n", cached);
-- 
1.9.1
