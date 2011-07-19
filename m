From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 19 Jul 2011 12:09:56 +0800
Subject: [PATCH 1/1] ARM: mxs-dma: reset after disable channel
Message-ID: <1311048596-19932-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We met some channels in abnormal state after disable.
Reset it to get a clean state.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/dma/mxs-dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 88aad4f..5a24010 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -535,6 +535,7 @@ static int mxs_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	switch (cmd) {
 	case DMA_TERMINATE_ALL:
 		mxs_dma_disable_chan(mxs_chan);
+		mxs_dma_reset_chan(mxs_chan);
 		break;
 	case DMA_PAUSE:
 		mxs_dma_pause_chan(mxs_chan);
-- 
1.7.0.4
