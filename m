From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Jun 2013 00:22:49 +0200
Subject: [PATCH 12/15] [media] davinci: vpfe_capture needs i2c
In-Reply-To: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
Message-ID: <1370038972-2318779-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vpfe_capture driver is implicitly built for three of the davinci
capture drivers but depends on i2c, so we need to add the dependency
in Kconfig for each driver using this.

 drivers/media/platform/davinci/vpfe_capture.c: In function 'vpfe_probe':
 drivers/media/platform/davinci/vpfe_capture.c:1934:2: error: implicit declaration of function 'i2c_get_adapter' [-Werror=implicit-function-declaration]
 drivers/media/platform/davinci/vpfe_capture.c:1934:11: warning: assignment makes pointer from integer without a cast [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
---
 drivers/media/platform/davinci/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/davinci/Kconfig b/drivers/media/platform/davinci/Kconfig
index afb3aec..02da88b 100644
--- a/drivers/media/platform/davinci/Kconfig
+++ b/drivers/media/platform/davinci/Kconfig
@@ -27,6 +27,7 @@ config VIDEO_DAVINCI_VPIF_CAPTURE
 config VIDEO_DM6446_CCDC
 	tristate "TI DM6446 CCDC video capture driver"
 	depends on VIDEO_V4L2 && (ARCH_DAVINCI || ARCH_OMAP3)
+	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
 	   Enables DaVinci CCD hw module. DaVinci CCDC hw interfaces
@@ -41,6 +42,7 @@ config VIDEO_DM6446_CCDC
 config VIDEO_DM355_CCDC
 	tristate "TI DM355 CCDC video capture driver"
 	depends on VIDEO_V4L2 && ARCH_DAVINCI
+	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
 	   Enables DM355 CCD hw module. DM355 CCDC hw interfaces
@@ -55,6 +57,7 @@ config VIDEO_DM355_CCDC
 config VIDEO_DM365_ISIF
 	tristate "TI DM365 ISIF video capture driver"
 	depends on VIDEO_V4L2 && ARCH_DAVINCI
+	depends on I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
 	   Enables ISIF hw module. This is the hardware module for
-- 
1.8.1.2
