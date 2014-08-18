From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 18 Aug 2014 18:20:49 +0100
Subject: [PATCH] bus: arm-ccn: Fix warning message
Message-ID: <1408382449-13685-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A message warning a user about wrong vc value was printing
out port instead.

Reported-by: Drew Richardson <drew.richardson@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 3266f8f..6f550d9 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -662,7 +662,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 		}
 		if (e->num_vcs && vc >= e->num_vcs) {
 			dev_warn(ccn->dev, "Invalid vc %d for node/XP %d!\n",
-					port, node_xp);
+					vc, node_xp);
 			return -EINVAL;
 		}
 		valid = 1;
-- 
1.9.1
