From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 25 Jul 2012 17:36:49 +0530
Subject: [PATCH] ARM: EXYNOS: Add static mapping for EXYNOS Audio Subsystem
Message-ID: <1343218009-30400-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CMU of EXYNOS can't control Audio Subsystem's clocks because
AUDSS SFRs aren't located in CMU. But AUDSS is a kind of CMU for
Audio Subsystem and need to use clock framework. This mapping
address will be used for AUDSS clock control.

Signed-off-by: sangsu4u.park <sangsu4u.park@samsung.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-exynos/common.c                |    5 +++++
 arch/arm/mach-exynos/include/mach/map.h      |    1 +
 arch/arm/plat-samsung/include/plat/map-s5p.h |    2 ++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 4eb39cd..4070c79 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -109,6 +109,11 @@ static struct map_desc exynos_iodesc[] __initdata = {
 		.pfn		= __phys_to_pfn(EXYNOS_PA_CHIPID),
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (unsigned long)S5P_VA_AUDSS,
+		.pfn		= __phys_to_pfn(EXYNOS_PA_AUDSS),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
 	},
 };
 
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 5cf7d91..9c044a0 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -39,6 +39,7 @@
 
 #define EXYNOS4_PA_G2D			0x12800000
 
+#define EXYNOS_PA_AUDSS			0x03810000
 #define EXYNOS_PA_I2S0			0x03830000
 #define EXYNOS4_PA_I2S1			0xE2100000
 #define EXYNOS4_PA_I2S2			0xE2A00000
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index c2d7bda..3558277 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -40,6 +40,8 @@
 #define S5P_VA_GIC_CPU		S3C_ADDR(0x02810000)
 #define S5P_VA_GIC_DIST		S3C_ADDR(0x02820000)
 
+#define S5P_VA_AUDSS		S3C_ADDR(0x02910000)
+
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
 #define VA_VIC1			VA_VIC(1)
-- 
1.7.4.4
