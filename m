From: subash.rp@samsung.com (Subash Patel)
Date: Tue, 11 Jun 2013 18:51:01 +0530
Subject: [PATCH] ARM: exynos: change the PHYSMEM_BITS and SECTION_SIZE
Message-ID: <1370956861-18710-1-git-send-email-subash.rp@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On exynos5440 there is DRAM on the 36-bit address range. Hence
this patch converts the MAX_PHYSMEM_BITS macro to 36 if LPAE is
enabled for the ARM architecture.

The conventional section size on exynos is 256M due to sparsemem.
Since exynos5440 has memory in multiples of 1G in 32-bit and 36-bit
range, this has now been modified to 31.

Signed-off-by: Subash Patel <subash.rp@samsung.com>
---
 arch/arm/mach-exynos/include/mach/memory.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/memory.h b/arch/arm/mach-exynos/include/mach/memory.h
index 374ef2c..2a4cdb7 100644
--- a/arch/arm/mach-exynos/include/mach/memory.h
+++ b/arch/arm/mach-exynos/include/mach/memory.h
@@ -15,8 +15,13 @@
 
 #define PLAT_PHYS_OFFSET		UL(0x40000000)
 
+#ifndef CONFIG_ARM_LPAE
 /* Maximum of 256MiB in one bank */
 #define MAX_PHYSMEM_BITS	32
 #define SECTION_SIZE_BITS	28
+#else
+#define MAX_PHYSMEM_BITS	36
+#define SECTION_SIZE_BITS	31
+#endif
 
 #endif /* __ASM_ARCH_MEMORY_H */
-- 
1.7.10.4
