From: kishore.p@techveda.org (kishore.p at techveda.org)
Date: Sat, 23 Dec 2017 20:36:00 +0530
Subject: [PATCH] staging: vc04_services: Prefer BUG_ON instead of if condition
 followed by BUG.
Message-ID: <1514041560-28001-1-git-send-email-kishore.p@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kishore KP <kishore.p@techveda.org>

Use BUG_ON instead of if condition followed by BUG.
Pointed out by Coccinelle.

Signed-off-by: Kishore KP <kishore.p@techveda.org>
Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
---
Note:
- Patch was compile tested and built(ARCH=arm) on linux-next
  (latest).
- No build issues reported.
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 315b49c..7116f61 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -224,8 +224,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 
 	platform_state   = (struct vchiq_2835_state *)state->platform_state;
 
-	if (!platform_state->inited)
-		BUG();
+	BUG_ON(!platform_state->inited);
 
 	return &platform_state->arm_state;
 }
-- 
1.9.1
