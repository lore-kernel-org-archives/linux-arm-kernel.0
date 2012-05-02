From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue,  1 May 2012 22:07:45 -0700
Subject: [PATCH 6/7] ARM: Exynos5: Add AUXDATA support for MSHC controllers
In-Reply-To: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1335935266-25289-7-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entries if MSHC controllers in AUXDATA table for correct device name
initialization.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 00e25fc..4a060f1 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -72,6 +72,14 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"s3c2440-i2c.0", NULL),
 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
 				"s3c2440-i2c.1", NULL),
+	OF_DEV_AUXDATA("synopsis,dw-mshc-exynos5250", 0x12200000,
+				"dw_mmc.0", NULL),
+	OF_DEV_AUXDATA("synopsis,dw-mshc-exynos5250", 0x12210000,
+				"dw_mmc.1", NULL),
+	OF_DEV_AUXDATA("synopsis,dw-mshc-exynos5250", 0x12220000,
+				"dw_mmc.2", NULL),
+	OF_DEV_AUXDATA("synopsis,dw-mshc-exynos5250", 0x12230000,
+				"dw_mmc.3", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
-- 
1.7.5.4
