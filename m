From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Oct 2010 10:00:46 +0100
Subject: [RFC PATCH 13/18] ARM: LPAE: ensure dma_addr_t is the same size as
	phys_addr_t
In-Reply-To: <20101025085812.25275.55757.stgit@e102109-lin.cambridge.arm.com>
References: <20101025085812.25275.55757.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20101025090046.25275.80297.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Now that phys_addr_t can be 64-bit on ARM, we must ensure that dma_addr_t
is sufficiently large to hold physical addresses.

This patch uses the types.h implementation in asm-generic to define the
dma_addr_t type as the same width as phys_addr_t.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/types.h |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
index 345df01..039dd8f 100644
--- a/arch/arm/include/asm/types.h
+++ b/arch/arm/include/asm/types.h
@@ -1,28 +1,13 @@
 #ifndef __ASM_ARM_TYPES_H
 #define __ASM_ARM_TYPES_H
 
-#include <asm-generic/int-ll64.h>
+#include <asm-generic/types.h>
 
-#ifndef __ASSEMBLY__
-
-typedef unsigned short umode_t;
-
-#endif /* __ASSEMBLY__ */
-
-/*
- * These aren't exported outside the kernel to avoid name space clashes
- */
 #ifdef __KERNEL__
-
 #define BITS_PER_LONG 32
 
 #ifndef __ASSEMBLY__
-
-/* Dma addresses are 32-bits wide.  */
-
-typedef u32 dma_addr_t;
-typedef u32 dma64_addr_t;
-
+typedef dma_addr_t dma64_addr_t;
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
