From: kimbrownkd@gmail.com (Kimberly Brown)
Date: Wed, 24 Oct 2018 00:56:53 -0400
Subject: [PATCH v2] staging: mt7621-dma: Add braces around else branches
In-Reply-To: <20181023211142.GA2661@v>
References: <20181023211142.GA2661@v>
Message-ID: <20181024045653.GA2864@v>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add braces around else branches in conditional statements that include
branches with multiple statements. This style complies with the Linux
kernel coding style and improves consistency and readability. Issues found by
checkpatch.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
Changes in v2:
- Added people and mailing lists from get_maintainer.pl to the CC list
- Added Reviewed-by line

 drivers/staging/mt7621-dma/mtk-hsdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index df6ebf41bdea..35556f024aa1 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -418,8 +418,9 @@ static void mtk_hsdma_chan_done(struct mtk_hsdam_engine *hsdma,
 			vchan_cookie_complete(&desc->vdesc);
 			chan_issued = gdma_next_desc(chan);
 		}
-	} else
+	} else {
 		dev_dbg(hsdma->ddev.dev, "no desc to complete\n");
+	}
 
 	if (chan_issued)
 		set_bit(chan->id, &hsdma->chan_issued);
@@ -456,8 +457,9 @@ static void mtk_hsdma_issue_pending(struct dma_chan *c)
 		if (gdma_next_desc(chan)) {
 			set_bit(chan->id, &hsdma->chan_issued);
 			tasklet_schedule(&hsdma->task);
-		} else
+		} else {
 			dev_dbg(hsdma->ddev.dev, "no desc to issue\n");
+		}
 	}
 	spin_unlock_bh(&chan->vchan.lock);
 }
-- 
2.17.1
