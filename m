From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 31 Dec 2016 23:06:17 +0100
Subject: [PATCH 6/6] staging: vchiq_arm: Delete an unnecessary return
 statement in two functions
In-Reply-To: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
References: <5acd65e7-0b5d-0972-5e1a-6e87d71dc1a4@users.sourceforge.net>
Message-ID: <c504d800-d04f-525d-7d0a-1969c69d9a22@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 31 Dec 2016 22:05:19 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in affected functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 05a00914dba0..6fe0c72246a2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2121,7 +2121,6 @@ vchiq_platform_check_suspend(VCHIQ_STATE_T *state)
 
 out:
 	vchiq_log_trace(vchiq_susp_log_level, "%s exit", __func__);
-	return;
 }
 
 
@@ -2306,7 +2305,6 @@ vchiq_check_suspend(VCHIQ_STATE_T *state)
 
 out:
 	vchiq_log_trace(vchiq_susp_log_level, "%s exit", __func__);
-	return;
 }
 
 
-- 
2.11.0
