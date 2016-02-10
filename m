From: shaun.ren@linux.com (Shaun Ren)
Date: Tue,  9 Feb 2016 18:45:25 -0800
Subject: [PATCH v3 6/9] Staging: rts5208: rtsx_transport.c: Fix label naming
 convention
In-Reply-To: <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
References: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
 <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
Message-ID: <1455072328-7033-7-git-send-email-shaun.ren@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the following naming convention issue in rtsx_transport.c,
as reported by checkpatch.pl:

CHECK: Avoid CamelCase: <Handle_Errors>

Signed-off-by: Shaun Ren <shaun.ren@linux.com>
---
Changes since v2
 * Update patch to reflect the changes made in PATCH 1/9 (block comments)

 drivers/staging/rts5208/rtsx_transport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 14321c0..ea00347 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -170,14 +170,14 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
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
@@ -197,7 +197,7 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 
 	return;
 
-Handle_Errors:
+handle_errors:
 	return;
 }
 
-- 
2.7.0
