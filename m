From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Tue, 21 Nov 2017 11:58:04 +0000
Subject: [RFC 8/9] arm64: increase sparsemem MAX_PHYSMEM_BITS to 52
In-Reply-To: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
References: <1511265485-27163-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1511265485-27163-9-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sparsemem is used to store page structs and other information for each
physical page in the system. In order to support 52-bit physical memory,
increase MAX_PHYSMEM_BITS to 52 when 52-bit physical memory is
configured. If it is not configured, then the kernel can't use 52-bit
memory, so leave MAX_PHYSMEM bits at 48 in that case.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/sparsemem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 74a9d301819f..b299929fe56c 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -17,7 +17,7 @@
 #define __ASM_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
-#define MAX_PHYSMEM_BITS	48
+#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
 #define SECTION_SIZE_BITS	30
 #endif
 
-- 
2.1.4
