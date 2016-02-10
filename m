From: shaun.ren@linux.com (Shaun Ren)
Date: Tue,  9 Feb 2016 18:45:22 -0800
Subject: [PATCH v3 3/9] Staging: rts5208: rtsx_transport.c: Remove spaces
 after casts
In-Reply-To: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
References: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
 <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455072328-7033-4-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes all spaces after casts in rtsx_transport.c, as reported
by checkpatch.pl:

CHECK: No space is necessary after a cast

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 17bea8a..57b1f46 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -56,10 +56,10 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 			return 0;
 		cnt = min(buflen, scsi_bufflen(srb) - *offset);
 		if (dir == TO_XFER_BUF)
-			memcpy((unsigned char *) scsi_sglist(srb) + *offset,
+			memcpy((unsigned char *)scsi_sglist(srb) + *offset,
 			       buffer, cnt);
 		else
-			memcpy(buffer, (unsigned char *) scsi_sglist(srb) +
+			memcpy(buffer, (unsigned char *)scsi_sglist(srb) +
 			       *offset, cnt);
 		*offset += cnt;
 
@@ -70,7 +70,7 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 	 */
 	} else {
 		struct scatterlist *sg =
-				(struct scatterlist *) scsi_sglist(srb)
+				(struct scatterlist *)scsi_sglist(srb)
 				+ *index;
 
 		/*
-- 
2.7.0
