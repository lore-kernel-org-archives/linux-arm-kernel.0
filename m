From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 22 Oct 2010 15:21:40 +0900
Subject: [PATCH V2 2/4] ARM: S3C: Change VMALLOC_END to use more
	vmalloc()/ioremap() area
Message-ID: <1287728500-12849-1-git-send-email-kgene.kim@samsung.com>
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

 arch/arm/mach-s3c2410/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s3c24a0/include/mach/vmalloc.h |    2 +-
 arch/arm/mach-s3c64xx/include/mach/vmalloc.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/vmalloc.h b/arch/arm/mach-s3c2410/include/mach/vmalloc.h
index 54297eb..4093bc9 100644
--- a/arch/arm/mach-s3c2410/include/mach/vmalloc.h
+++ b/arch/arm/mach-s3c2410/include/mach/vmalloc.h
@@ -15,6 +15,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	0xE0000000UL
+#define VMALLOC_END	0xF6000000UL
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s3c24a0/include/mach/vmalloc.h b/arch/arm/mach-s3c24a0/include/mach/vmalloc.h
index 9146568..29d0002 100644
--- a/arch/arm/mach-s3c24a0/include/mach/vmalloc.h
+++ b/arch/arm/mach-s3c24a0/include/mach/vmalloc.h
@@ -12,6 +12,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	  (0xe0000000UL)
+#define VMALLOC_END	0xF6000000UL
 
 #endif /* __ASM_ARCH_VMALLOC_H */
diff --git a/arch/arm/mach-s3c64xx/include/mach/vmalloc.h b/arch/arm/mach-s3c64xx/include/mach/vmalloc.h
index bc0e913..0df9597 100644
--- a/arch/arm/mach-s3c64xx/include/mach/vmalloc.h
+++ b/arch/arm/mach-s3c64xx/include/mach/vmalloc.h
@@ -15,6 +15,6 @@
 #ifndef __ASM_ARCH_VMALLOC_H
 #define __ASM_ARCH_VMALLOC_H
 
-#define VMALLOC_END	0xE0000000UL
+#define VMALLOC_END	0xF6000000UL
 
 #endif /* __ASM_ARCH_VMALLOC_H */
-- 
1.6.2.5
