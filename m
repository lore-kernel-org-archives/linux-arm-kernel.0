From: kishore.p@techveda.org (kishore.p at techveda.org)
Date: Sat, 23 Dec 2017 20:16:59 +0530
Subject: [PATCH] staging: vc04_services: Fix platform_no_drv_owner.cocci
 warnings.
Message-ID: <1514040419-27841-1-git-send-email-kishore.p@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kishore KP <kishore.p@techveda.org>

Removed .owner field initialization, platform core does it automatically.
Pointed out by Coccinelle.

Signed-off-by: Kishore KP <kishore.p@techveda.org>
Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
---
Note:
- Patch was compile tested and built(ARCH=arm) on linux-next
  (latest).
- No build issues reported.
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 8f2d508..50a5f29 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -443,7 +443,6 @@ static int snd_bcm2835_alsa_resume(struct platform_device *pdev)
 #endif
 	.driver = {
 		.name = "bcm2835_audio",
-		.owner = THIS_MODULE,
 		.of_match_table = snd_bcm2835_of_match_table,
 	},
 };
-- 
1.9.1
