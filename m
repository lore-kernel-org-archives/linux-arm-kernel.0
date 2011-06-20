From: chaos.youn@samsung.com (Changhwan Youn)
Date: Mon, 20 Jun 2011 16:34:12 +0900
Subject: [PATCH 1/7] ARM: EXYNOS4: Add external GIC io memory mapping
In-Reply-To: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
References: <1308555258-4322-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <1308555258-4322-2-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds external GIC io memory mapping
to support external GIC on EXYNOS4.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
---
 arch/arm/mach-exynos4/cpu.c              |   10 ++++++++++
 arch/arm/mach-exynos4/include/mach/map.h |    5 +++--
 arch/arm/plat-s5p/include/plat/map-s5p.h |    5 +++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 1196f39..6a1ed74 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -107,6 +107,16 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_AUDSS),
 		.length		= SZ_1K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GIC_CPU),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_GIC_DIST),
+		.length		= SZ_64K,
+		.type		= MT_DEVICE,
 	},
 };
 
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 57d8074..9d5d797 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -61,10 +61,11 @@
 
 #define EXYNOS4_PA_COMBINER		0x10448000
 
+#define EXYNOS4_PA_GIC_CPU		0x10480000
+#define EXYNOS4_PA_GIC_DIST		0x10490000
+
 #define EXYNOS4_PA_COREPERI		0x10500000
-#define EXYNOS4_PA_GIC_CPU		0x10500100
 #define EXYNOS4_PA_TWD			0x10500600
-#define EXYNOS4_PA_GIC_DIST		0x10501000
 #define EXYNOS4_PA_L2CC			0x10502000
 
 #define EXYNOS4_PA_MDMA			0x10810000
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index daa4a44..264df2d 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -35,9 +35,10 @@
 #define S5P_VA_COREPERI_BASE	S3C_ADDR(0x02800000)
 #define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
 #define S5P_VA_SCU		S5P_VA_COREPERI(0x0)
-#define S5P_VA_GIC_CPU		S5P_VA_COREPERI(0x100)
 #define S5P_VA_TWD		S5P_VA_COREPERI(0x600)
-#define S5P_VA_GIC_DIST		S5P_VA_COREPERI(0x1000)
+
+#define S5P_VA_GIC_CPU		S3C_ADDR(0x02810000)
+#define S5P_VA_GIC_DIST		S3C_ADDR(0x02820000)
 
 #define S3C_VA_USB_HSPHY	S3C_ADDR(0x02900000)
 #define S5P_VA_AUDSS		S3C_ADDR(0x02A00000)
-- 
1.7.1
