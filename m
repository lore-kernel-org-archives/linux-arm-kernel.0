From: lameli67@gmail.com (Mikhail Shvetsov)
Date: Thu, 14 Dec 2017 23:40:04 +0300
Subject: [PATCH 2/3] staging: vchiq_arm: Fixing code style of comments
In-Reply-To: <cover.1513283180.git.lameli67@gmail.com>
References: <cover.1513283180.git.lameli67@gmail.com>
Message-ID: <772f34803fcc0f7ebfd39467326ca3ec93498ed5.1513283180.git.lameli67@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mikhail Shvetsov <lameli67@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_kern_lib.c       | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
index 4a40b9b31a5a..48f05062fc12 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
@@ -72,7 +72,9 @@ VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 	vchiq_log_trace(vchiq_core_log_level, "%s called", __func__);
 
 	/* VideoCore may not be ready due to boot up timing.
-	   It may never be ready if kernel and firmware are mismatched, so don't block forever. */
+	 * It may never be ready if kernel and firmware are mismatched, so don't
+	 * block forever.
+	 */
 	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
 		state = vchiq_get_state();
 		if (state)
@@ -381,8 +383,9 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
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
@@ -408,7 +411,8 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 
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
