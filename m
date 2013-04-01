From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Apr 2013 20:01:13 +0800
Subject: [PATCH] staging: rts5139: device_reset() can be static
Message-ID: <1364817673-21256-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function device_reset() is only used in rts51x_scsi.c, so make it be
static.  Otherwise, it will have a name collision with the new added
reset API.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/staging/rts5139/rts51x_scsi.c |    2 +-
 drivers/staging/rts5139/rts51x_scsi.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rts5139/rts51x_scsi.c b/drivers/staging/rts5139/rts51x_scsi.c
index 052911c..b58f1df 100644
--- a/drivers/staging/rts5139/rts51x_scsi.c
+++ b/drivers/staging/rts5139/rts51x_scsi.c
@@ -2072,7 +2072,7 @@ int command_abort(struct scsi_cmnd *srb)
 
 /* This invokes the transport reset mechanism to reset the state of the
  * device */
-int device_reset(struct scsi_cmnd *srb)
+static int device_reset(struct scsi_cmnd *srb)
 {
 	int result = 0;
 
diff --git a/drivers/staging/rts5139/rts51x_scsi.h b/drivers/staging/rts5139/rts51x_scsi.h
index cdfe550..3a52136 100644
--- a/drivers/staging/rts5139/rts51x_scsi.h
+++ b/drivers/staging/rts5139/rts51x_scsi.h
@@ -151,7 +151,6 @@ int proc_info(struct Scsi_Host *host, char *buffer,
 	      char **start, off_t offset, int length, int inout);
 int queuecommand(struct Scsi_Host *, struct scsi_cmnd *);
 int command_abort(struct scsi_cmnd *srb);
-int device_reset(struct scsi_cmnd *srb);
 int bus_reset(struct scsi_cmnd *srb);
 
 #endif /* __RTS51X_SCSI_H */
-- 
1.7.9.5
