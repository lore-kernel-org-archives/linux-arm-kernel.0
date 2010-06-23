From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Jun 2010 19:52:16 +0800
Subject: [PATCH 4/6] [ARM] Remove useless __mem_isa() definitions
In-Reply-To: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277293938-25804-5-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/mach-davinci/include/mach/io.h  |    1 -
 arch/arm/mach-iop13xx/include/mach/io.h  |    1 -
 arch/arm/mach-ns9xxx/include/mach/io.h   |    1 -
 arch/arm/plat-stmp3xxx/include/mach/io.h |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/io.h b/arch/arm/mach-davinci/include/mach/io.h
index 71d6a0d..078d939 100644
--- a/arch/arm/mach-davinci/include/mach/io.h
+++ b/arch/arm/mach-davinci/include/mach/io.h
@@ -16,7 +16,6 @@
  * drivers out there that might just work if we fake them...
  */
 #define __io(a)			__typesafe_io(a)
-#define __mem_isa(a)		(a)
 
 #ifndef __ASSEMBLER__
 #define __arch_ioremap(p, s, t)	davinci_ioremap(p, s, t)
diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
index c1387df..9a360c0 100644
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ b/arch/arm/mach-iop13xx/include/mach/io.h
@@ -20,7 +20,6 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a) __iop13xx_io(a)
-#define __mem_isa(a) (a)
 
 extern void __iomem * __iop13xx_io(unsigned long io_addr);
 extern void __iomem *__iop13xx_ioremap(unsigned long cookie, size_t size,
diff --git a/arch/arm/mach-ns9xxx/include/mach/io.h b/arch/arm/mach-ns9xxx/include/mach/io.h
index edb9cdd..11de350 100644
--- a/arch/arm/mach-ns9xxx/include/mach/io.h
+++ b/arch/arm/mach-ns9xxx/include/mach/io.h
@@ -12,6 +12,5 @@
 #define __ASM_ARCH_IO_H
 
 #define __io(a)		__typesafe_io(a)
-#define __mem_isa(a)    (IO_BASE + (a))
 
 #endif /* ifndef __ASM_ARCH_IO_H */
diff --git a/arch/arm/plat-stmp3xxx/include/mach/io.h b/arch/arm/plat-stmp3xxx/include/mach/io.h
index 73817a1..4649a7b 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/io.h
+++ b/arch/arm/plat-stmp3xxx/include/mach/io.h
@@ -17,6 +17,5 @@
 #define __ASM_ARM_ARCH_IO_H
 
 #define __io(a) 	__typesafe_io(a)
-#define __mem_isa(a)	(a)
 
 #endif
-- 
1.7.1
