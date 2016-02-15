From: shaun.ren@linux.com (Shaun Ren)
Date: Mon, 15 Feb 2016 10:58:53 -0800
Subject: [PATCH v5 RESEND 7/8] Staging: rts5208: rtsx_transport.c: Remove
 unnecessary parentheses
In-Reply-To: <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
References: <1455250080-9897-1-git-send-email-shaun.ren@linux.com>
 <1455562734-10863-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455562734-10863-8-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes all unnecessary parentheses found by checkpatch.pl.

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
Changes since v3
  * Fixed patch conflicts due to commit 9a66d05d82db
    ("Staging: rts5208: fix check for dma mapping error"), and
    commit b3232842dbef ("Staging: rts5208: remove unnecessary parantheses")

 drivers/staging/rts5208/rtsx_transport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index aadef51..c604576 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -194,7 +194,7 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		/* set the result so the higher layers expect this data */
 		srb->result = SAM_STAT_CHECK_CONDITION;
 		memcpy(srb->sense_buffer,
-		       (unsigned char *)&(chip->sense_buffer[SCSI_LUN(srb)]),
+		       (unsigned char *)&chip->sense_buffer[SCSI_LUN(srb)],
 		       sizeof(struct sense_data_t));
 	}
 
@@ -368,7 +368,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 
 	spin_unlock_irq(&rtsx->reg_lock);
 
-	sg_cnt = dma_map_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	sg_cnt = dma_map_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	resid = size;
 	sg_ptr = sg;
@@ -482,7 +482,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	dma_unmap_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
@@ -532,7 +532,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 
 	spin_unlock_irq(&rtsx->reg_lock);
 
-	buf_cnt = dma_map_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	buf_cnt = dma_map_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	sg_ptr = sg;
 
@@ -630,7 +630,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	dma_unmap_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
@@ -714,7 +714,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_single(&(rtsx->pci->dev), addr, len, dma_dir);
+	dma_unmap_single(&rtsx->pci->dev, addr, len, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
-- 
2.7.1
