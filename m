From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 21:58:45 +0530
Subject: [PATCH 27/28] serial: sh: use DMA_COMPLETE for dma completion status
In-Reply-To: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
References: <1381940926-25564-1-git-send-email-vinod.koul@intel.com>
Message-ID: <1381940926-25564-28-git-send-email-vinod.koul@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Greg, pls ack this as it has depedency on my tree

 drivers/tty/serial/sh-sci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5377502..7d8103c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1433,7 +1433,7 @@ static void work_fn_rx(struct work_struct *work)
 	desc = s->desc_rx[new];
 
 	if (dma_async_is_tx_complete(s->chan_rx, s->active_rx, NULL, NULL) !=
-	    DMA_SUCCESS) {
+	    DMA_COMPLETE) {
 		/* Handle incomplete DMA receive */
 		struct dma_chan *chan = s->chan_rx;
 		struct shdma_desc *sh_desc = container_of(desc,
-- 
1.7.0.4
