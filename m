From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 17 May 2012 22:05:33 +0530
Subject: [PATCH 2/3] ARM: Exynos5: Add AUXDATA support for MSHC controllers
In-Reply-To: <1337272534-30370-1-git-send-email-thomas.abraham@linaro.org>
References: <1337272534-30370-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1337272534-30370-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entries if MSHC controllers in AUXDATA table for correct device name
initialization.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/include/mach/map.h |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c  |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index cf7d200..1f3e61a 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -129,6 +129,7 @@
 
 #define EXYNOS4_PA_HSMMC(x)		(0x12510000 + ((x) * 0x10000))
 #define EXYNOS4_PA_DWMCI		0x12550000
+#define EXYNOS5_PA_DWMCI(x)		(0x12200000 + ((x) * 0x10000))
 
 #define EXYNOS4_PA_SATA			0x12560000
 #define EXYNOS4_PA_SATAPHY		0x125D0000
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 00e25fc..2cb0c6a 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -72,6 +72,14 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"s3c2440-i2c.0", NULL),
 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
 				"s3c2440-i2c.1", NULL),
+	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI(0),
+				"dw_mmc.0", NULL),
+	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI(1),
+				"dw_mmc.1", NULL),
+	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI(2),
+				"dw_mmc.2", NULL),
+	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI(3),
+				"dw_mmc.3", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
-- 
1.6.6.rc2
