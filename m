From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:40 +0200
Subject: [PATCH v2 41/53] dmaengine: mv_xor: Remove device_control
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-42-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell XOR engine doesn't allow any operations that use to be defined in
device_control, it shouldn't need to be defined. Since it's going to be
deprecated, remove it altogether.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/mv_xor.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 394cbc5c93e3..a6a792e5f19a 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -978,14 +978,6 @@ out:
 	return err;
 }
 
-/* This driver does not implement any of the optional DMA operations. */
-static int
-mv_xor_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
-	       unsigned long arg)
-{
-	return -ENOSYS;
-}
-
 static int mv_xor_channel_remove(struct mv_xor_chan *mv_chan)
 {
 	struct dma_chan *chan, *_chan;
@@ -1044,7 +1036,6 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	dma_dev->device_free_chan_resources = mv_xor_free_chan_resources;
 	dma_dev->device_tx_status = mv_xor_status;
 	dma_dev->device_issue_pending = mv_xor_issue_pending;
-	dma_dev->device_control = mv_xor_control;
 	dma_dev->dev = &pdev->dev;
 
 	/* set prep routines based on capability */
-- 
2.1.1
