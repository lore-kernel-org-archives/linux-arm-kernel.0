From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 23:17:03 +0100
Subject: [PATCH 07/12] firmware: arm_scpi: drop unnecessary type cast to
 scpi_shared_mem
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <293dff86-243d-0f26-d127-79353ea3b7c9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>
This patch drops the only present type cast of the SCPI payload pointer
to scpi_shared_mem inorder to align with other occurrences, IOW for
consistency.

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 4447af48..e02d5820 100644
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
2.15.1
