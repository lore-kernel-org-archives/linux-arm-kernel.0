From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 29 Oct 2012 18:46:13 +0530
Subject: [PATCH] ARM: Exynos5: Remove static io-remapping for gic and combiner
Message-ID: <1351516573-393-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The physical base address of GIC and Interrupt Combiner is obtained from
device tree and then remapped during initialization. So remove the
static io-remapping for GIC and combiner.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 5a305f0..5c75815 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -256,25 +256,10 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 		.length		= SZ_64K,
 		.type		= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_COMBINER_BASE,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_COMBINER),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S3C_VA_UART,
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_UART),
 		.length		= SZ_512K,
 		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GIC_CPU,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_GIC_CPU),
-		.length		= SZ_8K,
-		.type		= MT_DEVICE,
-	}, {
-		.virtual	= (unsigned long)S5P_VA_GIC_DIST,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_GIC_DIST),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
 	},
 };
 
-- 
1.6.6.rc2
