From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:30:42 -0400
Subject: [PATCH 10/10] ARM: ARM_DMA_ZONE_SIZE is no more
In-Reply-To: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309919442-20451-10-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One less dependency on mach/memory.h.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/dma.h |    2 --
 arch/arm/mm/init.c         |    4 ----
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index 1d34c11..04c162f 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_ARM_DMA_H
 #define __ASM_ARM_DMA_H
 
-#include <asm/memory.h>
-
 /*
  * This is the maximum virtual address which can be DMA'd from.
  */
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a14caff..d7d9011 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -35,11 +35,7 @@
 #include "mm.h"
 
 #ifdef CONFIG_ZONE_DMA
-#ifdef ARM_DMA_ZONE_SIZE
-unsigned long arm_dma_zone_size = ARM_DMA_ZONE_SIZE;
-#else
 unsigned long arm_dma_zone_size __read_mostly;
-#endif
 EXPORT_SYMBOL(arm_dma_zone_size);
 #endif
 
-- 
1.7.4
