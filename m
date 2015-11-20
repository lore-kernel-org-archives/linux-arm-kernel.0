From: michal.morawiec@tieto.com (Michal Morawiec)
Date: Sat, 21 Nov 2015 00:39:41 +0100
Subject: [PATCH 1/1] soc: ti: knav_qmss_queue: Fix linking RAM setup for queue
 managers
Message-ID: <1448062781-6708-1-git-send-email-michal.1.morawiec.ext@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure linking RAM for both queue managers also in case
when only linking RAM 0 is specified in device tree.

Signed-off-by: Michal Morawiec <michal.1.morawiec.ext@nokia.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6d8646d..a809c30 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1173,7 +1173,7 @@ static int knav_queue_setup_link_ram(struct knav_device *kdev)
 
 		block++;
 		if (!block->size)
-			return 0;
+			continue;
 
 		dev_dbg(kdev->dev, "linkram1: phys:%x, virt:%p, size:%x\n",
 			block->phys, block->virt, block->size);
-- 
2.4.6
