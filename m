From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 22 Oct 2010 15:21:49 +0900
Subject: [PATCH V2 3/4] ARM: S5P: Change VMALLOC_END to use more
	vmalloc()/ioremap() area
Message-ID: <1287728509-12885-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes VMALLOC_END from 0xE0000000 to 0xF6000000, because
some systems want to use more vmalloc()/ioremap() area and now don't use
from at 0xE0000000 to 0xF6000000 (the start of Samsung SoCs' VA space)

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- According to S3C_ADDR_BASE, fixed

 arch/arm/mach-s5p6442/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s5p64x0/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s5pc100/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s5pv210/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s5pv310/include/mach/vmalloc.h |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s5p6442/include/mach/vmalloc.h b/arch/arm/mach-s5p6442/include/mach/vmalloc.h
index f5c83f0..a337ba2 100644
--- a/arch/arm/mach-s5p6442/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5p6442/include/mach/vmalloc.h
@@ -12,6 +12,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	0xE0000000UL
+#define VMALLOC_END	0xF6000000UL
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/vmalloc.h b/arch/arm/mach-s5p64x0/include/mach/vmalloc.h
index 97a9df3..3371d93 100644
--- a/arch/arm/mach-s5p64x0/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5p64x0/include/mach/vmalloc.h
@@ -15,6 +15,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	0xE0000000UL
+#define VMALLOC_END	0xF6000000UL
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/vmalloc.h b/arch/arm/mach-s5pc100/include/mach/vmalloc.h
index be9df79..6218c55 100644
--- a/arch/arm/mach-s5pc100/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5pc100/include/mach/vmalloc.h
@@ -12,6 +12,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	  (0xe0000000UL)
+#define VMALLOC_END	0xF6000000UL
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5pv210/include/mach/vmalloc.h b/arch/arm/mach-s5pv210/include/mach/vmalloc.h
index df9a288..6507a4b 100644
--- a/arch/arm/mach-s5pv210/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5pv210/include/mach/vmalloc.h
@@ -17,6 +17,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H __FILE__
 
-#define VMALLOC_END	(0xE0000000UL)
+#define VMALLOC_END	0xF6000000UL
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5pv310/include/mach/vmalloc.h b/arch/arm/mach-s5pv310/include/mach/vmalloc.h
index 256f221..2f10840 100644
--- a/arch/arm/mach-s5pv310/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5pv310/include/mach/vmalloc.h
@@ -17,6 +17,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H __FILE__
 
-#define VMALLOC_END	(0xF0000000UL)
+#define VMALLOC_END	0xF6000000UL
 
 #endif /* __ASM_ARCH_VMALLOC_H */
-- 
1.6.2.5
