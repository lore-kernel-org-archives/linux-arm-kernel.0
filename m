From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 23 Aug 2016 11:31:16 +0530
Subject: [PATCH v2] ARM: EXYNOS: Remove unused DMC and CMU offset and its
 mapping
Message-ID: <1471932076-16528-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is no user of DMC and CMU SFR offsets we can safely remove
mapping of their SFR address space and cleanup related offset macros from
mach-exynos

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
Changes since v1:
 - Removed unused CMU register mapping and related SFR macros and updated
   commit message accordingly
 
 arch/arm/mach-exynos/exynos.c                | 15 ---------------
 arch/arm/mach-exynos/include/mach/map.h      |  5 -----
 arch/arm/plat-samsung/include/plat/map-s5p.h |  4 ----
 3 files changed, 24 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index acabf0b..757fc11 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -30,25 +30,10 @@
 
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
-		.virtual	= (unsigned long)S5P_VA_CMU,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
-		.length		= SZ_128K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_COREPERI_BASE,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_COREPERI),
 		.length		= SZ_8K,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_DMC0,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC0),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_DMC1,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_DMC1),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
 	},
 };
 
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c48ba4f..5fb0040 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -18,11 +18,6 @@
 
 #define EXYNOS_PA_CHIPID		0x10000000
 
-#define EXYNOS4_PA_CMU			0x10030000
-
-#define EXYNOS4_PA_DMC0			0x10400000
-#define EXYNOS4_PA_DMC1			0x10410000
-
 #define EXYNOS4_PA_COREPERI		0x10500000
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index b63aeeb..0fe2828 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -14,10 +14,6 @@
 #define __ASM_PLAT_MAP_S5P_H __FILE__
 
 #define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
-#define S5P_VA_CMU		S3C_ADDR(0x02100000)
-
-#define S5P_VA_DMC0		S3C_ADDR(0x02440000)
-#define S5P_VA_DMC1		S3C_ADDR(0x02480000)
 
 #define S5P_VA_COREPERI_BASE	S3C_ADDR(0x02800000)
 #define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
-- 
2.4.5
