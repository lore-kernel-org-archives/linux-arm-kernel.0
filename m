From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 27 Mar 2012 14:56:05 +0530
Subject: [PATCH 4/4] ARM: Exynos5: Add PDMA and MDMA physical base address
 defines
In-Reply-To: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
References: <1332840365-24827-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1332840365-24827-5-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PDMA and MDMA physical base address macros which is require for Exynos5
of_dev_auxdata setup.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/include/mach/map.h |    5 +++++
 arch/arm/mach-exynos/mach-exynos5-dt.c  |    3 ++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 024d38f..37d93fd 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -90,6 +90,11 @@
 #define EXYNOS4_PA_PDMA0		0x12680000
 #define EXYNOS4_PA_PDMA1		0x12690000
 
+#define EXYNOS5_PA_PDMA0		0x121A0000
+#define EXYNOS5_PA_PDMA1		0x121B0000
+#define EXYNOS5_PA_MDMA0		0x10800000
+#define EXYNOS5_PA_MDMA1		0x11C10000
+
 #define EXYNOS4_PA_SYSMMU_MDMA		0x10A40000
 #define EXYNOS4_PA_SYSMMU_SSS		0x10A50000
 #define EXYNOS4_PA_SYSMMU_FIMC0		0x11A20000
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 0d26f50..cdc3a26 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -45,7 +45,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"exynos4210-uart.3", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
-	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.2", NULL),
+	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA0, "dma-pl330.2", NULL),
+	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA0, "dma-pl330.3", NULL),
 	{},
 };
 
-- 
1.6.6.rc2
