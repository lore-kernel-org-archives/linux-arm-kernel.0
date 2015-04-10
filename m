From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Apr 2015 22:30:14 +0200
Subject: [PATCH] [media] exynos4_is: exynos4-fimc requires i2c
Message-ID: <19181630.veBMiO50KX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without i2c, we can get a build error:

drivers/media/platform/exynos4-is/fimc-is-i2c.c: In function 'fimc_is_i2c_probe':
drivers/media/platform/exynos4-is/fimc-is-i2c.c:58:8: error: implicit declaration of function 'i2c_add_adapter' [-Werror=implicit-function-declaration]

The dependency already exists for exynos-fimc-lite and s5p-fimc,
but is missing for exynos4-fimc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
index b7b2e472240a..40423c6c5324 100644
--- a/drivers/media/platform/exynos4-is/Kconfig
+++ b/drivers/media/platform/exynos4-is/Kconfig
@@ -57,6 +57,7 @@ endif
 
 config VIDEO_EXYNOS4_FIMC_IS
 	tristate "EXYNOS4x12 FIMC-IS (Imaging Subsystem) driver"
+	depends on I2C
 	depends on HAS_DMA
 	select VIDEOBUF2_DMA_CONTIG
 	depends on OF
