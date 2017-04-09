From: geliangtang@gmail.com (Geliang Tang)
Date: Sun,  9 Apr 2017 09:34:05 +0800
Subject: [PATCH 09/12] [media] s5p-mfc: use setup_timer
In-Reply-To: <77c0fb26d214e023a99afc948c71d6edd9284205.1490953290.git.geliangtang@gmail.com>
References: <77c0fb26d214e023a99afc948c71d6edd9284205.1490953290.git.geliangtang@gmail.com>
Message-ID: <f35bda17a884852135983ab4128976b9c220a768.1490953290.git.geliangtang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use setup_timer() instead of init_timer() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index bb0a588..2c363aa 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1266,9 +1266,8 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 	dev->hw_lock = 0;
 	INIT_WORK(&dev->watchdog_work, s5p_mfc_watchdog_worker);
 	atomic_set(&dev->watchdog_cnt, 0);
-	init_timer(&dev->watchdog_timer);
-	dev->watchdog_timer.data = (unsigned long)dev;
-	dev->watchdog_timer.function = s5p_mfc_watchdog;
+	setup_timer(&dev->watchdog_timer, s5p_mfc_watchdog,
+		    (unsigned long)dev);
 
 	/* Initialize HW ops and commands based on MFC version */
 	s5p_mfc_init_hw_ops(dev);
-- 
2.9.3
