From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 12:19:28 +0200
Subject: [PATCH 10/12] dma: mmp_pdma: implement DMA_PAUSE and DMA_RESUME
In-Reply-To: <1375870770-14263-1-git-send-email-zonque@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
Message-ID: <1375870770-14263-11-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed at least for audio operation.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/dma/mmp_pdma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 7eb235b..c56da7c 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -658,6 +658,12 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
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
