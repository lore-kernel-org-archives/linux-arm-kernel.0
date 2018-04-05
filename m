From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Thu,  5 Apr 2018 16:29:34 -0400
Subject: [PATCH v2 07/19] media: exymos4-is: allow compile test for EXYNOS
 FIMC-LITE
In-Reply-To: <cover.1522959716.git.mchehab@s-opensource.com>
References: <cover.1522959716.git.mchehab@s-opensource.com>
Message-ID: <fb51c9ebb76438c554855cc6543651a8c1cb7aa6.1522959716.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's nothing that prevents building this driver with
COMPILE_TEST. So, enable it.

While here, make the Kconfig dependency cleaner by removing
the unneeded if block.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/exynos4-is/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
index 7b2c49e5a592..c8e5ad8f8294 100644
--- a/drivers/media/platform/exynos4-is/Kconfig
+++ b/drivers/media/platform/exynos4-is/Kconfig
@@ -41,11 +41,10 @@ config VIDEO_S5P_MIPI_CSIS
 	  To compile this driver as a module, choose M here: the
 	  module will be called s5p-csis.
 
-if SOC_EXYNOS4412 || SOC_EXYNOS5250
-
 config VIDEO_EXYNOS_FIMC_LITE
 	tristate "EXYNOS FIMC-LITE camera interface driver"
 	depends on I2C
+	depends on SOC_EXYNOS4412 || SOC_EXYNOS5250 || COMPILE_TEST
 	depends on HAS_DMA
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEO_EXYNOS4_IS_COMMON
@@ -55,7 +54,6 @@ config VIDEO_EXYNOS_FIMC_LITE
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called exynos-fimc-lite.
-endif
 
 config VIDEO_EXYNOS4_FIMC_IS
 	tristate "EXYNOS4x12 FIMC-IS (Imaging Subsystem) driver"
-- 
2.14.3
