From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Sep 2012 10:05:10 +0800
Subject: [PATCH] media: mx1_camera: mark the driver BROKEN
Message-ID: <1348193110-8413-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mx1_camera driver has been broken for a few release cycles since
commit 6bd0812 (dmaengine: imx-dma: merge old dma-v1.c with imx-dma.c).
It seems there is no one even compile tested it since then, as doing
so will end up with the following error.

  CC      drivers/media/platform/soc_camera/mx1_camera.o
In file included from drivers/media/platform/soc_camera/mx1_camera.c:44:0:
arch/arm/mach-imx/include/mach/dma-mx1-mx2.h:8:25: fatal error: mach/dma-v1.h: No such file or directory

It seems there is no one being interested in bringing it back to
work [1] so far.  Let's mark it BROKEN.

[1] https://lkml.org/lkml/2012/2/9/171

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/media/platform/soc_camera/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/soc_camera/Kconfig b/drivers/media/platform/soc_camera/Kconfig
index 9afe1e7..cb6791e 100644
--- a/drivers/media/platform/soc_camera/Kconfig
+++ b/drivers/media/platform/soc_camera/Kconfig
@@ -19,6 +19,7 @@ config MX1_VIDEO
 
 config VIDEO_MX1
 	tristate "i.MX1/i.MXL CMOS Sensor Interface driver"
+	depends on BROKEN
 	depends on VIDEO_DEV && ARCH_MX1 && SOC_CAMERA
 	select FIQ
 	select VIDEOBUF_DMA_CONTIG
-- 
1.7.9.5
