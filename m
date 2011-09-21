From: hatim.rv@samsung.com (Hatim Ali)
Date: Wed, 21 Sep 2011 11:14:19 +0530
Subject: [RESEND PATCH 2/3] ARM: EXYNOS4: Update consistent DMA size to 8MB
In-Reply-To: <1316583860-32510-1-git-send-email-hatim.rv@samsung.com>
References: <1316583860-32510-1-git-send-email-hatim.rv@samsung.com>
Message-ID: <1316583860-32510-3-git-send-email-hatim.rv@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the consistent DMA allocation to 8MB to support the
TVOUT driver.

NOTE: Once CMA support is merged into mainline, we will use it for memory
allocation.

Signed-off-by: Hatim Ali <hatim.rv@samsung.com>
---
 arch/arm/mach-exynos4/include/mach/memory.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/include/mach/memory.h b/arch/arm/mach-exynos4/include/mach/memory.h
index 374ef2c..7549742 100644
--- a/arch/arm/mach-exynos4/include/mach/memory.h
+++ b/arch/arm/mach-exynos4/include/mach/memory.h
@@ -15,6 +15,8 @@
 
 #define PLAT_PHYS_OFFSET		UL(0x40000000)
 
+#define CONSISTENT_DMA_SIZE		SZ_8M
+
 /* Maximum of 256MiB in one bank */
 #define MAX_PHYSMEM_BITS	32
 #define SECTION_SIZE_BITS	28
-- 
1.7.2.3
