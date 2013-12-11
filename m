From: vikas.sajjan@linaro.org (Vikas Sajjan)
Date: Wed, 11 Dec 2013 16:25:16 +0545
Subject: [PATCH 2/2] ARM: EXYNOS: Add CMU virtual addresses for exynos5260
In-Reply-To: <1386758416-31065-1-git-send-email-vikas.sajjan@linaro.org>
References: <1386758416-31065-1-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <1386758416-31065-3-git-send-email-vikas.sajjan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Young-Gun Jang <yg1004.jang@samsung.com>

Adds CMU virtual addresses for exynos5260.

Change-Id: Ia4f4eda96187d8d9e1edfc1a6b025af56d3bc43e
Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
---
 arch/arm/mach-exynos/common.c                  | 65 ++++++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h        | 14 ++++++
 arch/arm/mach-exynos/include/mach/regs-clock.h | 17 +++++++
 arch/arm/plat-samsung/include/plat/map-s5p.h   | 16 +++++++
 4 files changed, 112 insertions(+)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 70da5c4..350b730 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -332,6 +332,71 @@ static struct map_desc exynos5260_iodesc[] __initdata = {
 		.length		= SZ_16K,
 		.type		= MT_DEVICE,
 	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_TOP,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_TOP),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_PERI,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_PERI),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_EGL,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_EGL),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_KFC,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_KFC),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_G2D,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_G2D),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_MIF,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_MIF),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_MFC,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_MFC),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_G3D,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_G3D),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_FSYS,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_FSYS),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_AUD,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_AUD),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_ISP,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_ISP),
+		.length		= SZ_8K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_GSCL,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_GSCL),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)EXYNOS5260_VA_CMU_DISP,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_CMU_DISP),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)S3C_VA_WATCHDOG,
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_WATCHDOG),
 		.length		= SZ_4K,
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index cc190b9..fa1b565 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -48,6 +48,20 @@
 #define EXYNOS5260_PA_SYS_DISP				0x14540000
 #define EXYNOS5260_PA_SYS_AUD				0x128F0000
 
+#define EXYNOS5260_PA_CMU_TOP                          0x10010000
+#define EXYNOS5260_PA_CMU_PERI                         0x10200000
+#define EXYNOS5260_PA_CMU_EGL                          0x10600000
+#define EXYNOS5260_PA_CMU_KFC                          0x10700000
+#define EXYNOS5260_PA_CMU_G2D                          0x10A00000
+#define EXYNOS5260_PA_CMU_MIF                          0x10CE0000
+#define EXYNOS5260_PA_CMU_MFC                          0x11090000
+#define EXYNOS5260_PA_CMU_G3D                          0x11830000
+#define EXYNOS5260_PA_CMU_FSYS                         0x122E0000
+#define EXYNOS5260_PA_CMU_AUD                          0x128C0000
+#define EXYNOS5260_PA_CMU_ISP                          0x133C0000
+#define EXYNOS5260_PA_CMU_GSCL                         0x13F00000
+#define EXYNOS5260_PA_CMU_DISP                         0x14550000
+
 #define EXYNOS_PA_CHIPID		0x10000000
 
 #define EXYNOS4_PA_SYSCON		0x10010000
diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
index d36ad76..1c568d0 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -365,6 +365,23 @@
 
 /* Compatibility defines and inclusion */
 
+
+/* For EXYNOS5260 */
+#define EXYNOS_CLKREG_TOP(x)                    (EXYNOS5260_VA_CMU_TOP + (x))
+#define EXYNOS_CLKREG_PERI(x)                   (EXYNOS5260_VA_CMU_PERI + (x))
+#define EXYNOS_CLKREG_EGL(x)                    (EXYNOS5260_VA_CMU_EGL + (x))
+#define EXYNOS_CLKREG_KFC(x)                    (EXYNOS5260_VA_CMU_KFC + (x))
+#define EXYNOS_CLKREG_G2D(x)                    (EXYNOS5260_VA_CMU_G2D + (x))
+#define EXYNOS_CLKREG_MIF(x)                    (EXYNOS5260_VA_CMU_MIF + (x))
+#define EXYNOS_CLKREG_MFC(x)                    (EXYNOS5260_VA_CMU_MFC + (x))
+#define EXYNOS_CLKREG_G3D(x)                    (EXYNOS5260_VA_CMU_G3D + (x))
+#define EXYNOS_CLKREG_FSYS(x)                   (EXYNOS5260_VA_CMU_FSYS + (x))
+#define EXYNOS_CLKREG_AUD(x)                    (EXYNOS5260_VA_CMU_AUD + (x))
+#define EXYNOS_CLKREG_ISP(x)                    (EXYNOS5260_VA_CMU_ISP + (x))
+#define EXYNOS_CLKREG_GSCL(x)                   (EXYNOS5260_VA_CMU_GSCL + (x))
+#define EXYNOS_CLKREG_DISP(x)                   (EXYNOS5260_VA_CMU_DISP + (x))
+
+
 #include <mach/regs-pmu.h>
 
 #define S5P_EPLL_CON				EXYNOS4_EPLL_CON0
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index c2d7fcf..32966c8 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -72,6 +72,22 @@
 #define EXYNOS5260_VA_SYS_GSCL          S3C_ADDR(0x02870000)
 #define EXYNOS5260_VA_SYS_DISP          S3C_ADDR(0x02874000)
 
+
+#define EXYNOS5260_VA_CMU_TOP           (S5P_VA_CMU + (SZ_4K * 1))
+#define EXYNOS5260_VA_CMU_PERI          (S5P_VA_CMU + (SZ_4K * 2))
+#define EXYNOS5260_VA_CMU_EGL           (S5P_VA_CMU + (SZ_4K * 3))
+#define EXYNOS5260_VA_CMU_KFC           (S5P_VA_CMU + (SZ_4K * 5))
+#define EXYNOS5260_VA_CMU_G2D           (S5P_VA_CMU + (SZ_4K * 7))
+#define EXYNOS5260_VA_CMU_MIF           (S5P_VA_CMU + (SZ_4K * 8))
+#define EXYNOS5260_VA_CMU_MFC           (S5P_VA_CMU + (SZ_4K * 10))
+#define EXYNOS5260_VA_CMU_G3D           (S5P_VA_CMU + (SZ_4K * 11))
+#define EXYNOS5260_VA_CMU_FSYS          (S5P_VA_CMU + (SZ_4K * 13))
+#define EXYNOS5260_VA_CMU_AUD           (S5P_VA_CMU + (SZ_4K * 14))
+#define EXYNOS5260_VA_CMU_ISP           (S5P_VA_CMU + (SZ_4K * 15))
+#define EXYNOS5260_VA_CMU_GSCL          (S5P_VA_CMU + (SZ_4K * 17))
+#define EXYNOS5260_VA_CMU_DISP          (S5P_VA_CMU + (SZ_4K * 18))
+
+
 #include <plat/map-s3c.h>
 
 #endif /* __ASM_PLAT_MAP_S5P_H */
-- 
1.7.12.4
