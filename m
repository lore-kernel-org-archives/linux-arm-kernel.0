From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 10:11:10 +0900
Subject: [PATCH 3/7] [media] s5p-fimc: Remove to support fimc for S5PC100
In-Reply-To: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1305162674-25860-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to removing ARCH_S5PC100, we don't need to support
fimc for S5PC100.

Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/media/video/s5p-fimc/fimc-core.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/media/video/s5p-fimc/fimc-core.c b/drivers/media/video/s5p-fimc/fimc-core.c
index dc91a85..89d59d6 100644
--- a/drivers/media/video/s5p-fimc/fimc-core.c
+++ b/drivers/media/video/s5p-fimc/fimc-core.c
@@ -1871,17 +1871,6 @@ static struct samsung_fimc_variant fimc2_variant_exynos4 = {
 	.pix_limit	 = &s5p_pix_limit[3],
 };
 
-/* S5PC100 */
-static struct samsung_fimc_driverdata fimc_drvdata_s5p = {
-	.variant = {
-		[0] = &fimc0_variant_s5p,
-		[1] = &fimc0_variant_s5p,
-		[2] = &fimc2_variant_s5p,
-	},
-	.num_entities = 3,
-	.lclk_frequency = 133000000UL,
-};
-
 /* S5PV210, S5PC110 */
 static struct samsung_fimc_driverdata fimc_drvdata_s5pv210 = {
 	.variant = {
@@ -1907,9 +1896,6 @@ static struct samsung_fimc_driverdata fimc_drvdata_exynos4 = {
 
 static struct platform_device_id fimc_driver_ids[] = {
 	{
-		.name		= "s5p-fimc",
-		.driver_data	= (unsigned long)&fimc_drvdata_s5p,
-	}, {
 		.name		= "s5pv210-fimc",
 		.driver_data	= (unsigned long)&fimc_drvdata_s5pv210,
 	}, {
-- 
1.7.1
