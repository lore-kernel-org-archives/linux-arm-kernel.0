From: shaun.ren@linux.com (Shaun Ren)
Date: Tue,  9 Feb 2016 18:45:26 -0800
Subject: [PATCH v3 7/9] Staging: rts5208: rtsx_transport.c: Remove unnecessary
 parentheses
In-Reply-To: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
References: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
 <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455072328-7033-8-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes all unnecessary parentheses found by checkpatch.pl.

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index ea00347..c956072 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -191,7 +191,7 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		/* set the result so the higher layers expect this data */
 		srb->result = SAM_STAT_CHECK_CONDITION;
 		memcpy(srb->sense_buffer,
-		       (unsigned char *)&(chip->sense_buffer[SCSI_LUN(srb)]),
+		       (unsigned char *)&chip->sense_buffer[SCSI_LUN(srb)],
 		       sizeof(struct sense_data_t));
 	}
 
@@ -365,7 +365,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 
 	spin_unlock_irq(&rtsx->reg_lock);
 
-	sg_cnt = dma_map_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	sg_cnt = dma_map_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	resid = size;
 	sg_ptr = sg;
@@ -479,7 +479,7 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	dma_unmap_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
@@ -529,7 +529,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 
 	spin_unlock_irq(&rtsx->reg_lock);
 
-	buf_cnt = dma_map_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	buf_cnt = dma_map_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	sg_ptr = sg;
 
@@ -627,7 +627,7 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_sg(&(rtsx->pci->dev), sg, num_sg, dma_dir);
+	dma_unmap_sg(&rtsx->pci->dev, sg, num_sg, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
@@ -657,7 +657,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 	else
 		return -ENXIO;
 
-	addr = dma_map_single(&(rtsx->pci->dev), buf, len, dma_dir);
+	addr = dma_map_single(&rtsx->pci->dev, buf, len, dma_dir);
 	if (!addr)
 		return -ENOMEM;
 
@@ -711,7 +711,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 out:
 	rtsx->done = NULL;
 	rtsx->trans_state = STATE_TRANS_NONE;
-	dma_unmap_single(&(rtsx->pci->dev), addr, len, dma_dir);
+	dma_unmap_single(&rtsx->pci->dev, addr, len, dma_dir);
 
 	if (err < 0)
 		rtsx_stop_cmd(chip, card);
-- 
2.7.0
