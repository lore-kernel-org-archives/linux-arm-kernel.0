From: windsdaemon@gmail.com (Jing Wang)
Date: Tue, 20 Nov 2012 14:07:14 +0800
Subject: [PATCH 2/2] mmc/host/s3cmci: remove the excess "goto irq_out"
Message-ID: <1353391635-7691-1-git-send-email-windsdaemon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jing Wang <windsdaemon@gmail.com>

This patch delete excess "goto irq_out", because the function can run as normal without this.

Signed-off-by: Jing Wang <windsdaemon@gmail.com>
---
 drivers/mmc/host/s3cmci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 4638dda..e488e60 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -733,8 +733,6 @@ close_transfer:
 	clear_imask(host);
 	tasklet_schedule(&host->pio_tasklet);
 
-	goto irq_out;
-
 irq_out:
 	dbg(host, dbg_irq,
 	    "csta:0x%08x dsta:0x%08x fsta:0x%08x dcnt:0x%08x status:%s.\n",
-- 
1.7.9.5
