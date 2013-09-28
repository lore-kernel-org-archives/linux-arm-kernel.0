From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 28 Sep 2013 20:21:35 +0200
Subject: [PATCH 3/5] [media] s3c-camif: Use CONFIG_ARCH_S3C64XX to check for
 S3C64xx support
In-Reply-To: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
References: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1380392497-27406-3-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since CONFIG_PLAT_S3C64XX is going to be removed, this patch modifies
the Kconfig entry of s3c-camif driver to use the proper way of checking
for S3C64xx support - CONFIG_ARCH_S3C64XX.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/media/platform/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index c7caf94..eb70dda 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -112,7 +112,7 @@ config VIDEO_OMAP3_DEBUG
 config VIDEO_S3C_CAMIF
 	tristate "Samsung S3C24XX/S3C64XX SoC Camera Interface driver"
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API
-	depends on (PLAT_S3C64XX || PLAT_S3C24XX) && PM_RUNTIME
+	depends on (ARCH_S3C64XX || PLAT_S3C24XX) && PM_RUNTIME
 	select VIDEOBUF2_DMA_CONTIG
 	---help---
 	  This is a v4l2 driver for s3c24xx and s3c64xx SoC series camera
-- 
1.8.3.2
