From: shaun.ren@linux.com (Shaun Ren)
Date: Mon,  8 Feb 2016 17:31:23 -0800
Subject: [PATCH v2 7/9] Staging: rts5208: rtsx_transport.c: Remove unnecessary
 parentheses
In-Reply-To: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1454981485-15686-8-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes all unnecessary parentheses found by checkpatch.pl.

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index ca209c6..fa062f6 100644
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
 
@@ -372,7 +372,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 
 	spin_unlock_irq(&rtsx->reg_lock);
 
-	sg_cnt = dma_map_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	sg_cnt = dma_map_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	resid = size;
 	sg_ptr = sg;
@@ -485,7 +485,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	dma_unmap_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
@@ -535,7 +535,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 
 	spin_unlock_irq(&rtsx->reg_lock);
 
-	buf_cnt = dma_map_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	buf_cnt = dma_map_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	sg_ptr = sg;
 
@@ -633,7 +633,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	dma_unmap_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
@@ -663,7 +663,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 	else
 		return -ENXIO;
 
-	addr = dma_map_single(&(rtsx->pci->dev), buf, len, dma_dir);
+	addr = dma_map_single(&rtsx->pci->dev, buf, len, dma_dir);
 	if (!addr)
 		return -ENOMEM;
 
@@ -717,7 +717,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_single(&(rtsx->pci->dev), addr, len, dma_dir);
+	dma_unmap_single(&rtsx->pci->dev, addr, len, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
-- 
2.7.0
