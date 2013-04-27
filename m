From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 27 Apr 2013 09:06:38 +0400
Subject: [PATCH] media: coda: Fix compile breakage
Message-ID: <1367039198-28639-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds GENERIC_ALLOCATOR, if "coda" is selected.

drivers/built-in.o: In function `coda_remove':
:(.text+0x110634): undefined reference to `gen_pool_free'
drivers/built-in.o: In function `coda_probe':
:(.text+0x1107d4): undefined reference to `of_get_named_gen_pool'
:(.text+0x1108b8): undefined reference to `gen_pool_alloc'
:(.text+0x1108d0): undefined reference to `gen_pool_virt_to_phys'
:(.text+0x110918): undefined reference to `dev_get_gen_pool'

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/media/platform/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0cbe1ff..414a769 100644
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
1.8.1.5
