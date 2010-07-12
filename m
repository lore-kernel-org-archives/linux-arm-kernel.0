From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 12 Jul 2010 15:31:09 +0900
Subject: [PATCH] ARM: S5PV210: Fix on MAX_PHYSMEM_BITS on S5PV210/S5PC110.
Message-ID: <1278916269-31040-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes on MAX_PHYSMEM_BITS for Sparsemem on S5PV210/S5PC110.
Because physical memory can be located from 0x20000000 to 0x7fffffff,
so MAX_PHYSMEM_BITS is 31 and not 32.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
NOTE:
Russell pointed this out from mailing list. So added him to 'Reported-by'.
If any problem about this, please kindly let me know.
Thanks.

 arch/arm/mach-s5pv210/include/mach/memory.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/memory.h b/arch/arm/mach-s5pv210/include/mach/memory.h
index 379117e..d503e0c 100644
--- a/arch/arm/mach-s5pv210/include/mach/memory.h
+++ b/arch/arm/mach-s5pv210/include/mach/memory.h
@@ -16,8 +16,13 @@
 #define PHYS_OFFSET		UL(0x20000000)
 #define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
 
-/* Maximum of 256MiB in one bank */
-#define MAX_PHYSMEM_BITS	32
+/*
+ * Sparsemem support
+ * Physical memory can be located from 0x20000000 to 0x7fffffff,
+ * so MAX_PHYSMEM_BITS is 31.
+ */
+
+#define MAX_PHYSMEM_BITS	31
 #define SECTION_SIZE_BITS	28
 
 #endif /* __ASM_ARCH_MEMORY_H */
-- 
1.6.2.5
