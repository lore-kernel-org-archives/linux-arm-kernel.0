From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 18:52:23 +0200
Subject: [PATCH v2 09/11] dma: mmp_pdma: implement DMA_PAUSE and DMA_RESUME
In-Reply-To: <1376153545-14361-1-git-send-email-zonque@gmail.com>
References: <1376153545-14361-1-git-send-email-zonque@gmail.com>
Message-ID: <1376153545-14361-10-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed at least for audio operation.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 579f79a..7a0956b 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -659,6 +659,12 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
 		if (cfg->slave_id)
 			chan->drcmr = cfg->slave_id;
 		break;
+	case DMA_PAUSE:
+		disable_chan(chan->phy);
+		break;
+	case DMA_RESUME:
+		start_pending_queue(chan);
+		break;
 	default:
 		return -ENOSYS;
 	}
-- 
1.8.3.1
