From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 19 Aug 2010 10:19:51 +0900
Subject: [PATCH] ARM: S5PC210/S5PC110: VMALLOC_END should be unsigned long
Message-ID: <20100819011951.GA29229@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Silences following build warning:

arch/arm/mm/init.c: In function 'mem_init':
arch/arm/mm/init.c:644: warning: format '%08lx' expects type 'long
unsigned int', but argument 12 has type 'unsigned int'

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

diff --git a/arch/arm/mach-s5pv210/include/mach/vmalloc.h b/arch/arm/mach-s5pv210/include/mach/vmalloc.h
index 58f515e..5b4c69b 100644
--- a/arch/arm/mach-s5pv210/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5pv210/include/mach/vmalloc.h
@@ -17,6 +17,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H __FILE__
 
-#define VMALLOC_END	  (0xE0000000)
+#define VMALLOC_END	  (0xE0000000UL)
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/vmalloc.h b/arch/arm/mach-s5pv310/include/mach/vmalloc.h
index 3f565eb..5bf4345 100644
--- a/arch/arm/mach-s5pv310/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5pv310/include/mach/vmalloc.h
@@ -17,6 +17,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H __FILE__
 
-#define VMALLOC_END	  (0xF0000000)
+#define VMALLOC_END	  (0xF0000000UL)
 
 #endif /* __ASM_ARCH_VMALLOC_H */
