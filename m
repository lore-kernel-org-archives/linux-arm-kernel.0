From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 22:17:47 +0100
Subject: [PATCH 7/7] [media] marvell-ccic needs VIDEOBUF2_DMA_SG
In-Reply-To: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
References: <1422479867-3370921-1-git-send-email-arnd@arndb.de>
Message-ID: <1422479867-3370921-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vb2_dma_sg_memops pointer is only valid if VIDEOBUF2_DMA_SG is
set, so we should select that to avoid this build error:

drivers/built-in.o: In function `mcam_v4l_open':
:(.text+0x388d00): undefined reference to `vb2_dma_sg_memops'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 drivers/media/platform/marvell-ccic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/marvell-ccic/Kconfig b/drivers/media/platform/marvell-ccic/Kconfig
index 7ac0f13c98be..4bf5bd1e90d6 100644
--- a/drivers/media/platform/marvell-ccic/Kconfig
+++ b/drivers/media/platform/marvell-ccic/Kconfig
@@ -5,6 +5,7 @@ config VIDEO_CAFE_CCIC
 	select VIDEO_OV7670
 	select VIDEOBUF2_VMALLOC
 	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_DMA_SG
 	---help---
 	  This is a video4linux2 driver for the Marvell 88ALP01 integrated
 	  CMOS camera controller.  This is the controller found on first-
-- 
2.1.0.rc2
