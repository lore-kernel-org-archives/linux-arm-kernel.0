From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 25 Jun 2010 15:44:28 +0800
Subject: [PATCH 1/4] [ARM] Remove useless __mem_isa() definitions
In-Reply-To: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
References: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1277451871-15319-2-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.miao@canonical.com>

__mem_isa() is used nowhere, keeping it there will just add confusion.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/mach-davinci/include/mach/io.h  |    1 -
 arch/arm/mach-iop13xx/include/mach/io.h  |    1 -
 arch/arm/mach-ns9xxx/include/mach/io.h   |    1 -
 arch/arm/plat-stmp3xxx/include/mach/io.h |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/io.h b/arch/arm/mach-davinci/include/mach/io.h
index 62b0a90..84b4b17 100644
--- a/arch/arm/mach-davinci/include/mach/io.h
+++ b/arch/arm/mach-davinci/include/mach/io.h
@@ -19,7 +19,6 @@
  */
 #define __io(a)			__typesafe_io(a)
 #define __mem_pci(a)		(a)
-#define __mem_isa(a)		(a)
 
 #ifndef __ASSEMBLER__
 #define __arch_ioremap(p, s, t)	davinci_ioremap(p, s, t)
diff --git a/arch/arm/mach-iop13xx/include/mach/io.h b/arch/arm/mach-iop13xx/include/mach/io.h
index a6e0f9e..ccf69ed 100644
--- a/arch/arm/mach-iop13xx/include/mach/io.h
+++ b/arch/arm/mach-iop13xx/include/mach/io.h
@@ -23,7 +23,6 @@
 
 #define __io(a) __iop13xx_io(a)
 #define __mem_pci(a) (a)
-#define __mem_isa(a) (a)
 
 extern void __iomem * __iop13xx_io(unsigned long io_addr);
 extern void __iomem *__iop13xx_ioremap(unsigned long cookie, size_t size,
diff --git a/arch/arm/mach-ns9xxx/include/mach/io.h b/arch/arm/mach-ns9xxx/include/mach/io.h
index f08451d..c261d7b 100644
--- a/arch/arm/mach-ns9xxx/include/mach/io.h
+++ b/arch/arm/mach-ns9xxx/include/mach/io.h
@@ -15,6 +15,5 @@
 
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)    (a)
-#define __mem_isa(a)    (IO_BASE + (a))
 
 #endif /* ifndef __ASM_ARCH_IO_H */
diff --git a/arch/arm/plat-stmp3xxx/include/mach/io.h b/arch/arm/plat-stmp3xxx/include/mach/io.h
index d08b1b7..7aef4d9 100644
--- a/arch/arm/plat-stmp3xxx/include/mach/io.h
+++ b/arch/arm/plat-stmp3xxx/include/mach/io.h
@@ -20,6 +20,5 @@
 
 #define __io(a) 	__typesafe_io(a)
 #define __mem_pci(a)	(a)
-#define __mem_isa(a)	(a)
 
 #endif
-- 
1.7.1
