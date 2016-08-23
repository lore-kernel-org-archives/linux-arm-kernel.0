From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 23 Aug 2016 11:20:16 +0530
Subject: [PATCH] ARM: EXYNOS: Remove unused DMC offset and its mapping
Message-ID: <1471931416-15991-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently there is no user of DMC SFR offsets, so we can safely remove
mapping of its SFR address space and cleanup related offset macros from
mach-exynos.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/exynos.c                | 10 ----------
 arch/arm/mach-exynos/include/mach/map.h      |  3 ---
 arch/arm/plat-samsung/include/plat/map-s5p.h |  3 ---
 3 files changed, 16 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index acabf0b..139d1ef 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -39,16 +39,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
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
index c48ba4f..85d610d 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -20,9 +20,6 @@
 
 #define EXYNOS4_PA_CMU			0x10030000
 
-#define EXYNOS4_PA_DMC0			0x10400000
-#define EXYNOS4_PA_DMC1			0x10410000
-
 #define EXYNOS4_PA_COREPERI		0x10500000
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index b63aeeb..9a80bf6 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -16,9 +16,6 @@
 #define S5P_VA_CHIPID		S3C_ADDR(0x02000000)
 #define S5P_VA_CMU		S3C_ADDR(0x02100000)
 
-#define S5P_VA_DMC0		S3C_ADDR(0x02440000)
-#define S5P_VA_DMC1		S3C_ADDR(0x02480000)
-
 #define S5P_VA_COREPERI_BASE	S3C_ADDR(0x02800000)
 #define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
 #define S5P_VA_SCU		S5P_VA_COREPERI(0x0)
-- 
2.4.5
