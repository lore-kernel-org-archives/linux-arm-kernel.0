From: shaun.ren@linux.com (Shaun Ren)
Date: Mon,  8 Feb 2016 17:31:22 -0800
Subject: [PATCH v2 6/9] Staging: rts5208: rtsx_transport.c: Fix label naming
 convention
In-Reply-To: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1454981485-15686-7-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following naming convention issue in rtsx_transport.c,
as reported by checkpatch.pl:

CHECK: Avoid CamelCase: <Handle_Errors>

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 73302af..ca209c6 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -173,14 +173,14 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	if (rtsx_chk_stat(chip, RTSX_STAT_ABORT)) {
 		dev_dbg(rtsx_dev(chip), "-- command was aborted\n");
 		srb->result = DID_ABORT << 16;
-		goto Handle_Errors;
+		goto handle_errors;
 	}
 
 	/* if there is a transport error, reset and don't auto-sense */
 	if (result == TRANSPORT_ERROR) {
 		dev_dbg(rtsx_dev(chip), "-- transport indicates error, resetting\n");
 		srb->result = DID_ERROR << 16;
-		goto Handle_Errors;
+		goto handle_errors;
 	}
 
 	srb->result = SAM_STAT_GOOD;
@@ -204,7 +204,7 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	 * by issuing a port reset.  If that fails, try a class-specific
 	 * device reset.
 	 */
-Handle_Errors:
+handle_errors:
 	return;
 }
 
-- 
2.7.0
