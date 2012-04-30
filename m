From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 30 Apr 2012 12:14:30 -0700
Subject: [PATCH 20/20] ARM: Exynos5: Add AUXDATA for i2c controllers
In-Reply-To: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1335813270-13083-21-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use AUXDATA to set the device names for controller instances discovered
from device tree.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 4711c89..cf5d222 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -43,6 +43,10 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"exynos4210-uart.2", NULL),
 	OF_DEV_AUXDATA("samsung,exynos4210-uart", EXYNOS5_PA_UART3,
 				"exynos4210-uart.3", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(0),
+				"s3c2440-i2c.0", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(1),
+				"s3c2440-i2c.1", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_PDMA1, "dma-pl330.1", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS5_PA_MDMA1, "dma-pl330.2", NULL),
-- 
1.7.5.4
