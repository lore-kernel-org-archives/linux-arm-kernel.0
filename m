From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 17:16:02 +0000
Subject: [PATCH 09/15] media: coda: don't build on multiplatform
In-Reply-To: <1358788568-11137-1-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
Message-ID: <1358788568-11137-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coda video codec driver depends on a mach-imx or mach-mxs specific
header file "mach/iram.h". This is not available when building for
multiplatform, so let us disable this driver for v3.8 when building
multiplatform, and hopefully find a proper fix for v3.9.

drivers/media/platform/coda.c:27:23: fatal error: mach/iram.h: No such file or directory

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Javier Martin <javier.martin@vista-silicon.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-media at vger.kernel.org
---
 drivers/media/platform/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 3dcfea6..049d2b2 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -142,7 +142,7 @@ if V4L_MEM2MEM_DRIVERS
 
 config VIDEO_CODA
 	tristate "Chips&Media Coda multi-standard codec IP"
-	depends on VIDEO_DEV && VIDEO_V4L2 && ARCH_MXC
+	depends on VIDEO_DEV && VIDEO_V4L2 && ARCH_MXC && !ARCH_MULTIPLATFORM
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	select IRAM_ALLOC if SOC_IMX53
-- 
1.7.10.4
