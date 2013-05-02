From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  2 May 2013 17:16:24 +0200
Subject: [PATCH, RFC 20/22] media: coda: select GENERIC_ALLOCATOR
In-Reply-To: <1367507786-505303-1-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
Message-ID: <1367507786-505303-21-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The coda driver uses the generic allocator to get at the
"iram" memory, so add the necessary dependency to avoid:

drivers/built-in.o: In function `coda_remove':
 :(.text+0x2ab680): undefined reference to `gen_pool_free'
drivers/built-in.o: In function `coda_probe':
:(.text+0x2ad168): undefined reference to `of_get_named_gen_pool'
:(.text+0x2ad188): undefined reference to `dev_get_gen_pool'
:(.text+0x2ad220): undefined reference to `gen_pool_alloc'
:(.text+0x2ad2ec): undefined reference to `gen_pool_virt_to_phys'

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0494d27..4608d03 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -145,6 +145,7 @@ config VIDEO_CODA
 	depends on VIDEO_DEV && VIDEO_V4L2 && ARCH_MXC
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
+	select GENERIC_ALLOCATOR
 	---help---
 	   Coda is a range of video codec IPs that supports
 	   H.264, MPEG-4, and other video formats.
-- 
1.8.1.2
