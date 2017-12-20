From: lameli67@gmail.com (Mikhail Shvetsov)
Date: Wed, 20 Dec 2017 15:30:15 +0300
Subject: [PATCH 2/3] staging: vchiq_arm: Fixing code style of comments
In-Reply-To: <8bfad6214b83ee325888705c9f5a194cb6899caf.1513772223.git.lameli67@gmail.com>
References: <8bfad6214b83ee325888705c9f5a194cb6899caf.1513772223.git.lameli67@gmail.com>
Message-ID: <61ee74d056199ede7370480fe0dc3a188e5f6ae7.1513772223.git.lameli67@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes checkpatch.pl warnings:

WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments should align the * on each line
WARNING: Block comments use * on subsequent lines

Signed-off-by: Mikhail Shvetsov <lameli67@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_kern_lib.c       | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
index 6152596d23ea..3c9f97d60019 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
@@ -75,7 +75,9 @@ VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 	vchiq_log_trace(vchiq_core_log_level, "%s called", __func__);
 
 	/* VideoCore may not be ready due to boot up timing.
-	   It may never be ready if kernel and firmware are mismatched, so don't block forever. */
+	 * It may never be ready if kernel and firmware are mismatched,so don't
+	 * block forever.
+	 */
 	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
 		state = vchiq_get_state();
 		if (state)
@@ -379,8 +381,9 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 			if ((bulk->data != data) ||
 				(bulk->size != size)) {
 				/* This is not a retry of the previous one.
-				** Cancel the signal when the transfer
-				** completes. */
+				 * Cancel the signal when the transfer
+				 * completes.
+				 */
 				spin_lock(&bulk_waiter_spinlock);
 				bulk->userdata = NULL;
 				spin_unlock(&bulk_waiter_spinlock);
@@ -406,7 +409,8 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 
 		if (bulk) {
 			/* Cancel the signal when the transfer
-			 ** completes. */
+			 * completes.
+			 */
 			spin_lock(&bulk_waiter_spinlock);
 			bulk->userdata = NULL;
 			spin_unlock(&bulk_waiter_spinlock);
-- 
2.11.0
