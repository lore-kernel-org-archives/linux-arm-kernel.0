From: attila@kinali.ch (Attila Kinali)
Date: Fri,  6 Jul 2012 13:09:52 +0200
Subject: [PATCH] ARM: dma: mxs-dma: Export missing symbols from mxs-dma.c
In-Reply-To: <20120706105252.GC12558@shlinux2.ap.freescale.net>
References: <20120706105252.GC12558@shlinux2.ap.freescale.net>
Message-ID: <1341572992-12319-1-git-send-email-attila@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxs-dma.c provides two functions mxs_dma_is_apbh and mxs_dma_is_apbx
which are used at least in mxs-mmc.c. Building mxs-mmc as module
fails due to those two symbols not being exported.

Signed-off-by: Attila Kinali <attila@kinali.ch>
---
 drivers/dma/mxs-dma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index c96ab15..0437f49 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -201,6 +201,7 @@ int mxs_dma_is_apbh(struct dma_chan *chan)
 
 	return dma_is_apbh(mxs_dma);
 }
+EXPORT_SYMBOL(mxs_dma_is_apbh);
 
 int mxs_dma_is_apbx(struct dma_chan *chan)
 {
@@ -209,6 +210,7 @@ int mxs_dma_is_apbx(struct dma_chan *chan)
 
 	return !dma_is_apbh(mxs_dma);
 }
+EXPORT_SYMBOL(mxs_dma_is_apbx);
 
 static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
 {
@@ -779,3 +781,4 @@ static int __init mxs_dma_module_init(void)
 	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
 }
 subsys_initcall(mxs_dma_module_init);
+
-- 
1.7.10
