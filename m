From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 Feb 2012 15:26:00 +0100
Subject: [PATCH v3 16/21] ARM: at91: finally drop at91_sys_read/write
In-Reply-To: <cover.1330006537.git.nicolas.ferre@atmel.com>
References: <cover.1330006537.git.nicolas.ferre@atmel.com>
Message-ID: <8c428b8d3316faa88cae80473bb67565561fb446.1330006537.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Remove at91_sys_read/write() from io.h file. This function
is not used anymore and was a stopper on the way to single
zImage kernel for AT91.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/io.h |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/io.h b/arch/arm/mach-at91/include/mach/io.h
index 4ca09ef..4003001 100644
--- a/arch/arm/mach-at91/include/mach/io.h
+++ b/arch/arm/mach-at91/include/mach/io.h
@@ -28,22 +28,4 @@
 #define __io(a)		__typesafe_io(a)
 #define __mem_pci(a)	(a)
 
-#ifndef __ASSEMBLY__
-
-static inline unsigned int at91_sys_read(unsigned int reg_offset)
-{
-	void __iomem *addr = (void __iomem *)AT91_VA_BASE_SYS;
-
-	return __raw_readl(addr + reg_offset);
-}
-
-static inline void at91_sys_write(unsigned int reg_offset, unsigned long value)
-{
-	void __iomem *addr = (void __iomem *)AT91_VA_BASE_SYS;
-
-	__raw_writel(value, addr + reg_offset);
-}
-
-#endif
-
 #endif
-- 
1.7.9
