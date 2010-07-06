From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  6 Jul 2010 13:36:47 +0900
Subject: [PATCH] ARM: S5PV210: Fix on SECTION_SIZE_BITS on S5PV210/S5PC110.
Message-ID: <1278391007-11144-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes on SECTION_SIZE_BITS for Sparsemem on S5PV210/S5PC110.
Because smallest size of a bank on S5PV210/S5PC110 is aligned by 16MB.
So each section's maximum size should be 16MB.

Reported-by: Kyongho Cho <pullip.cho@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/memory.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/memory.h b/arch/arm/mach-s5pv210/include/mach/memory.h
index 379117e..4a372d8 100644
--- a/arch/arm/mach-s5pv210/include/mach/memory.h
+++ b/arch/arm/mach-s5pv210/include/mach/memory.h
@@ -16,8 +16,12 @@
 #define PHYS_OFFSET		UL(0x20000000)
 #define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
 
-/* Maximum of 256MiB in one bank */
+/* Sparsemem support. Each section is a maximum of 16MB.
+ * Because there are many different memory type on S5PC110(MCP),
+ * and there is a case that having 80MB, 128MB or 256MB in one
+ * bank.
+*/
 #define MAX_PHYSMEM_BITS	32
-#define SECTION_SIZE_BITS	28
+#define SECTION_SIZE_BITS	24
 
 #endif /* __ASM_ARCH_MEMORY_H */
-- 
1.6.2.5
