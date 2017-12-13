From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Wed, 13 Dec 2017 17:07:23 +0000
Subject: [PATCH 08/10] arm64: increase sparsemem MAX_PHYSMEM_BITS to 52
In-Reply-To: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1513184845-8711-9-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sparsemem is used to store page structs and other information for each
physical page in the system. In order to support 52-bit physical memory,
increase MAX_PHYSMEM_BITS to 52 when 52-bit physical memory is
configured. If it is not configured, then the kernel can't use 52-bit
memory, so leave MAX_PHYSMEM_BITS at 48 in that case. (The kconfig
option to set ARM64_PA_BITS to 52 will be added in a later patch.)

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
