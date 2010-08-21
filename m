From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Aug 2010 09:07:07 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix on build warning regarding VMALLOC_END type
Message-ID: <1282349227-2581-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix this warning:

arch/arm/mm/init.c: In function 'mem_init':
arch/arm/mm/init.c:644: warning: format '%08lx' expects type
'long unsigned int', but argument 12 has type 'unsigned int'

Reported-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s3c64xx/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s5p6440/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s5p6442/include/mach/vmalloc.h |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/vmalloc.h b/arch/arm/mach-s3c2410/include/mach/vmalloc.h
index 315b007..dc3b34c 100644
--- a/arch/arm/mach-s3c2410/include/mach/vmalloc.h
+++ b/arch/arm/mach-s3c2410/include/mach/vmalloc.h
@@ -15,6 +15,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	  (0xE0000000)
+#define VMALLOC_END	(0xE0000000UL)
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s3c64xx/include/mach/vmalloc.h b/arch/arm/mach-s3c64xx/include/mach/vmalloc.h
index 7411ef3..f0a0fa2 100644
--- a/arch/arm/mach-s3c64xx/include/mach/vmalloc.h
+++ b/arch/arm/mach-s3c64xx/include/mach/vmalloc.h
@@ -15,6 +15,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	  (0xE0000000)
+#define VMALLOC_END	(0xE0000000UL)
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5p6440/include/mach/vmalloc.h b/arch/arm/mach-s5p6440/include/mach/vmalloc.h
index 16df257..8217b99 100644
--- a/arch/arm/mach-s5p6440/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5p6440/include/mach/vmalloc.h
@@ -12,6 +12,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	  (0xE0000000)
+#define VMALLOC_END	(0xE0000000UL)
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s5p6442/include/mach/vmalloc.h b/arch/arm/mach-s5p6442/include/mach/vmalloc.h
index be33336..b9fd9aa 100644
--- a/arch/arm/mach-s5p6442/include/mach/vmalloc.h
+++ b/arch/arm/mach-s5p6442/include/mach/vmalloc.h
@@ -12,6 +12,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	  (0xE0000000)
+#define VMALLOC_END	(0xE0000000UL)
 
 #endif /* __ASM_ARCH_VMALLOC_H */
-- 
1.6.2.5
