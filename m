From: shaun.ren@linux.com (Shaun Ren)
Date: Mon,  8 Feb 2016 17:31:18 -0800
Subject: [PATCH v2 2/9] Staging: rts5208: rtsx_transport.c: Align to open
 parenthesis
In-Reply-To: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1454981485-15686-3-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the alignment issue reported by checkpatch.pl:

CHECK: Alignment should match open parenthesis

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 61 ++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 3e3f6fb..67162f6 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -40,8 +40,11 @@
  */
 
 unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
-	unsigned int buflen, struct scsi_cmnd *srb, unsigned int *index,
-	unsigned int *offset, enum xfer_buf_dir dir)
+				       unsigned int buflen,
+				       struct scsi_cmnd *srb,
+				       unsigned int *index,
+				       unsigned int *offset,
+				     enum xfer_buf_dir dir)
 {
 	unsigned int cnt;
 
@@ -54,10 +57,10 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 		cnt = min(buflen, scsi_bufflen(srb) - *offset);
 		if (dir == TO_XFER_BUF)
 			memcpy((unsigned char *) scsi_sglist(srb) + *offset,
-					buffer, cnt);
+			       buffer, cnt);
 		else
 			memcpy(buffer, (unsigned char *) scsi_sglist(srb) +
-					*offset, cnt);
+			       *offset, cnt);
 		*offset += cnt;
 
 	/* Using scatter-gather.  We have to go through the list one entry
@@ -131,7 +134,7 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
  * SCSI residue.
  */
 void rtsx_stor_set_xfer_buf(unsigned char *buffer,
-	unsigned int buflen, struct scsi_cmnd *srb)
+			    unsigned int buflen, struct scsi_cmnd *srb)
 {
 	unsigned int index = 0, offset = 0;
 
@@ -142,7 +145,7 @@ void rtsx_stor_set_xfer_buf(unsigned char *buffer,
 }
 
 void rtsx_stor_get_xfer_buf(unsigned char *buffer,
-	unsigned int buflen, struct scsi_cmnd *srb)
+			    unsigned int buflen, struct scsi_cmnd *srb)
 {
 	unsigned int index = 0, offset = 0;
 
@@ -194,8 +197,8 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 		/* set the result so the higher layers expect this data */
 		srb->result = SAM_STAT_CHECK_CONDITION;
 		memcpy(srb->sense_buffer,
-			(unsigned char *)&(chip->sense_buffer[SCSI_LUN(srb)]),
-			sizeof(struct sense_data_t));
+		       (unsigned char *)&(chip->sense_buffer[SCSI_LUN(srb)]),
+		       sizeof(struct sense_data_t));
 	}
 
 	return;
@@ -209,7 +212,7 @@ Handle_Errors:
 }
 
 void rtsx_add_cmd(struct rtsx_chip *chip,
-		u8 cmd_type, u16 reg_addr, u8 mask, u8 data)
+		  u8 cmd_type, u16 reg_addr, u8 mask, u8 data)
 {
 	u32 *cb = (u32 *)(chip->host_cmds_ptr);
 	u32 val = 0;
@@ -328,9 +331,11 @@ static inline void rtsx_add_sg_tbl(
 }
 
 static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
-		struct scatterlist *sg, int num_sg, unsigned int *index,
-		unsigned int *offset, int size,
-		enum dma_data_direction dma_dir, int timeout)
+					     struct scatterlist *sg, int num_sg,
+					     unsigned int *index,
+					     unsigned int *offset, int size,
+					     enum dma_data_direction dma_dir,
+					     int timeout)
 {
 	struct rtsx_dev *rtsx = chip->rtsx;
 	struct completion trans_done;
@@ -492,8 +497,9 @@ out:
 }
 
 static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
-		struct scatterlist *sg, int num_sg,
-		enum dma_data_direction dma_dir, int timeout)
+				     struct scatterlist *sg, int num_sg,
+				     enum dma_data_direction dma_dir,
+				     int timeout)
 {
 	struct rtsx_dev *rtsx = chip->rtsx;
 	struct completion trans_done;
@@ -639,7 +645,8 @@ out:
 }
 
 static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
-		size_t len, enum dma_data_direction dma_dir, int timeout)
+			     size_t len, enum dma_data_direction dma_dir,
+			     int timeout)
 {
 	struct rtsx_dev *rtsx = chip->rtsx;
 	struct completion trans_done;
@@ -722,9 +729,9 @@ out:
 }
 
 int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
-		void *buf, size_t len, int use_sg, unsigned int *index,
-		unsigned int *offset, enum dma_data_direction dma_dir,
-		int timeout)
+			       void *buf, size_t len, int use_sg,
+			       unsigned int *index, unsigned int *offset,
+			       enum dma_data_direction dma_dir, int timeout)
 {
 	int err = 0;
 
@@ -732,11 +739,13 @@ int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
 	if (rtsx_chk_stat(chip, RTSX_STAT_ABORT))
 		return -EIO;
 
-	if (use_sg)
-		err = rtsx_transfer_sglist_adma_partial(chip, card,
-				(struct scatterlist *)buf, use_sg,
-				index, offset, (int)len, dma_dir, timeout);
-	else
+	if (use_sg) {
+		struct scatterlist *sg = (struct scatterlist *)buf;
+
+		err = rtsx_transfer_sglist_adma_partial(chip, card, sg, use_sg,
+							index, offset, (int)len,
+							dma_dir, timeout);
+	} else
 		err = rtsx_transfer_buf(chip, card,
 					buf, len, dma_dir, timeout);
 	if (err < 0) {
@@ -751,7 +760,7 @@ int rtsx_transfer_data_partial(struct rtsx_chip *chip, u8 card,
 }
 
 int rtsx_transfer_data(struct rtsx_chip *chip, u8 card, void *buf, size_t len,
-		int use_sg, enum dma_data_direction dma_dir, int timeout)
+		       int use_sg, enum dma_data_direction dma_dir, int timeout)
 {
 	int err = 0;
 
@@ -763,8 +772,8 @@ int rtsx_transfer_data(struct rtsx_chip *chip, u8 card, void *buf, size_t len,
 
 	if (use_sg) {
 		err = rtsx_transfer_sglist_adma(chip, card,
-				(struct scatterlist *)buf,
-				use_sg, dma_dir, timeout);
+						(struct scatterlist *)buf,
+						use_sg, dma_dir, timeout);
 	} else {
 		err = rtsx_transfer_buf(chip, card, buf, len, dma_dir, timeout);
 	}
-- 
2.7.0
