From: shaun.ren@linux.com (Shaun Ren)
Date: Mon,  8 Feb 2016 17:31:17 -0800
Subject: [PATCH v2 1/9] Staging: rts5208: rtsx_transport.c: Fix comment style
 warnings
In-Reply-To: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1454981485-15686-2-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes all comment style warnings in rtsx_transport.c reported by
checkpatch.pl:

WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index f27491e..3e3f6fb 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -36,7 +36,8 @@
  * For non-scatter-gather transfers, srb->request_buffer points to the
  * transfer buffer itself and srb->request_bufflen is the buffer's length.)
  * Update the *index and *offset variables so that the next copy will
- * pick up from where this one left off. */
+ * pick up from where this one left off.
+ */
 
 unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 	unsigned int buflen, struct scsi_cmnd *srb, unsigned int *index,
@@ -45,7 +46,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 	unsigned int cnt;
 
 	/* If not using scatter-gather, just transfer the data directly.
-	 * Make certain it will fit in the available buffer space. */
+	 * Make certain it will fit in the available buffer space.
+	 */
 	if (scsi_sg_count(srb) == 0) {
 		if (*offset >= scsi_bufflen(srb))
 			return 0;
@@ -64,7 +66,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 	 * in kernel-addressable memory then kmap() will return its address.
 	 * If the page is not directly accessible -- such as a user buffer
 	 * located in high memory -- then kmap() will map it to a temporary
-	 * position in the kernel's virtual address space. */
+	 * position in the kernel's virtual address space.
+	 */
 	} else {
 		struct scatterlist *sg =
 				(struct scatterlist *) scsi_sglist(srb)
@@ -73,7 +76,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 		/* This loop handles a single s-g list entry, which may
 		 * include multiple pages.  Find the initial page structure
 		 * and the starting offset within the page, and update
-		 * the *offset and *index values for the next loop. */
+		 * the *offset and *index values for the next loop.
+		 */
 		cnt = 0;
 		while (cnt < buflen && *index < scsi_sg_count(srb)) {
 			struct page *page = sg_page(sg) +
@@ -97,7 +101,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 
 			/* Transfer the data for all the pages in this
 			 * s-g entry.  For each page: call kmap(), do the
-			 * transfer, and call kunmap() immediately after. */
+			 * transfer, and call kunmap() immediately after.
+			 */
 			while (sglen > 0) {
 				unsigned int plen = min(sglen, (unsigned int)
 						PAGE_SIZE - poff);
@@ -123,7 +128,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 }
 
 /* Store the contents of buffer into srb's transfer buffer and set the
-* SCSI residue. */
+ * SCSI residue.
+ */
 void rtsx_stor_set_xfer_buf(unsigned char *buffer,
 	unsigned int buflen, struct scsi_cmnd *srb)
 {
@@ -196,7 +202,8 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	/* Error and abort processing: try to resynchronize with the device
 	 * by issuing a port reset.  If that fails, try a class-specific
-	 * device reset. */
+	 * device reset.
+	 */
 Handle_Errors:
 	return;
 }
-- 
2.7.0
