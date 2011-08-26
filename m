From: hatim.rv@samsung.com (Hatim Ali)
Date: Fri, 26 Aug 2011 12:09:07 +0530
Subject: [PATCH 2/2] ARM: EXYNOS4: Update consistent DMA size to 8MB
In-Reply-To: <1314340747-13816-1-git-send-email-hatim.rv@samsung.com>
References: <1314340747-13816-1-git-send-email-hatim.rv@samsung.com>
Message-ID: <1314340747-13816-3-git-send-email-hatim.rv@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the consistent DMA allocation to 8MB to support the
TVOUT driver.

NOTE: Once CMA support is merged into mainline, we will use it for memory
allocation.

Signed-off-by: Hatim Ali <hatim.rv@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/memory.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/memory.h b/arch/arm/mach-exynos4/include/mach/memory.h
index 374ef2c..33da4bb 100644
--- a/arch/arm/mach-exynos4/include/mach/memory.h
+++ b/arch/arm/mach-exynos4/include/mach/memory.h
@@ -14,6 +14,7 @@
 #define __ASM_ARCH_MEMORY_H __FILE__
 
 #define PLAT_PHYS_OFFSET		UL(0x40000000)
+#define CONSISTENT_DMA_SIZE		SZ_8M
 
 /* Maximum of 256MiB in one bank */
 #define MAX_PHYSMEM_BITS	32
-- 
1.7.2.3
