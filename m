From: Zubair.Kakakhel@imgtec.com (Zubair Lutfullah Kakakhel)
Date: Wed, 16 Jul 2014 16:51:31 +0100
Subject: [PATCH 3/4] x86: use generic dma-contiguous.h
In-Reply-To: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Message-ID: <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma-contiguous.h is now in asm-generic. Use that to avoid code
repetition in x86.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/x86/include/asm/Kbuild           |  1 +
 arch/x86/include/asm/dma-contiguous.h | 12 ------------
 2 files changed, 1 insertion(+), 12 deletions(-)
 delete mode 100644 arch/x86/include/asm/dma-contiguous.h

diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 3bf000f..d55a210 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -6,6 +6,7 @@ genhdr-y += unistd_x32.h
 
 generic-y += clkdev.h
 generic-y += cputime.h
+generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
 generic-y += scatterlist.h
diff --git a/arch/x86/include/asm/dma-contiguous.h b/arch/x86/include/asm/dma-contiguous.h
deleted file mode 100644
index b4b38ba..0000000
--- a/arch/x86/include/asm/dma-contiguous.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef ASMX86_DMA_CONTIGUOUS_H
-#define ASMX86_DMA_CONTIGUOUS_H
-
-#ifdef __KERNEL__
-
-#include <linux/types.h>
-
-static inline void
-dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
-
-#endif
-#endif
-- 
1.9.1
