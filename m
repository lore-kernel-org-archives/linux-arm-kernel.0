From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 1 May 2017 21:27:39 +0200
Subject: [PATCH 1/3] soc-knav_dma: Use seq_putc() in dma_debug_show_channels()
In-Reply-To: <eddc35f7-a04b-42f5-ad8b-d345ca0b57b4@users.sourceforge.net>
References: <eddc35f7-a04b-42f5-ad8b-d345ca0b57b4@users.sourceforge.net>
Message-ID: <54a54866-6828-1ae5-6524-ca3f0dc4ab33@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 May 2017 20:55:55 +0200

A single character (line break) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/soc/ti/knav_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index ecebe2eecc3a..a66671a93199 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -333,7 +333,7 @@ static void dma_debug_show_channels(struct seq_file *s,
 			chan->cfg.u.rx.thresh);
 		for (i = 0; i < KNAV_DMA_FDQ_PER_CHAN; i++)
 			seq_printf(s, "[%d]", chan->cfg.u.rx.fdq[i]);
-		seq_printf(s, "\n");
+		seq_putc(s, '\n');
 	}
 }
 
-- 
2.12.2
