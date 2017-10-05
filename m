From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu,  5 Oct 2017 12:11:50 +0100
Subject: [PATCH 1/2] firmware: arm_scpi: drop unnecessary type cast to
 scpi_shared_mem
Message-ID: <1507201911-27976-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch drops the only present type cast of the SCPI payload pointer
to scpi_shared_mem inorder to align with other occurrences, IOW for
consistency.

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index c923d1ebfa3e..a888970f1347 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -453,7 +453,7 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
 	unsigned long flags;
 	struct scpi_xfer *t = msg;
 	struct scpi_chan *ch = container_of(c, struct scpi_chan, cl);
-	struct scpi_shared_mem *mem = (struct scpi_shared_mem *)ch->tx_payload;
+	struct scpi_shared_mem *mem = ch->tx_payload;
 
 	if (t->tx_buf) {
 		if (scpi_info->is_legacy)
-- 
2.7.4
