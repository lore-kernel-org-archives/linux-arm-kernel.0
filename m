From: lameli67@gmail.com (Mikhail Shvetsov)
Date: Thu,  7 Dec 2017 10:47:08 +0300
Subject: [PATCH 1/1] codestyle issue fixed drivers/staging/vc04_services
Message-ID: <40d794a2bd0dd9dbb3add85c79b9b314ccbb480a.1512631936.git.lameli67@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike <lameli67@gmail.com>

Signed-off-by: Mike <lameli67@gmail.com>
---
 .../interface/vchiq_arm/vchiq_kern_lib.c           | 64 ++++++++++++----------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
index 34f746db19cd..d21bb154f78c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
@@ -65,10 +65,10 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 	unsigned int size, VCHIQ_BULK_DIR_T dir);
 
 /****************************************************************************
-*
-*   vchiq_initialise
-*
-***************************************************************************/
+ *
+ *   vchiq_initialise
+ *
+ ***************************************************************************/
 #define VCHIQ_INIT_RETRIES 10
 VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 {
@@ -80,7 +80,9 @@ VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 	vchiq_log_trace(vchiq_core_log_level, "%s called", __func__);
 
 	/* VideoCore may not be ready due to boot up timing.
-	   It may never be ready if kernel and firmware are mismatched, so don't block forever. */
+	 * It may never be ready if kernel and firmware are mismatched, so don't
+	 * block forever.
+	 */
 	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
 		state = vchiq_get_state();
 		if (state)
@@ -93,7 +95,8 @@ VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 		goto failed;
 	} else if (i > 0) {
 		vchiq_log_warning(vchiq_core_log_level,
-			"%s: videocore initialized after %d retries\n", __func__, i);
+			"%s: videocore initialized after %d retries\n",
+			__func__, i);
 	}
 
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
@@ -121,10 +124,10 @@ VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 EXPORT_SYMBOL(vchiq_initialise);
 
 /****************************************************************************
-*
-*   vchiq_shutdown
-*
-***************************************************************************/
+ *
+ *   vchiq_shutdown
+ *
+ ***************************************************************************/
 
 VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
 {
@@ -169,10 +172,10 @@ VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
 EXPORT_SYMBOL(vchiq_shutdown);
 
 /****************************************************************************
-*
-*   vchiq_is_connected
-*
-***************************************************************************/
+ *
+ *   vchiq_is_connected
+ *
+ ***************************************************************************/
 
 static int vchiq_is_connected(VCHIQ_INSTANCE_T instance)
 {
@@ -180,10 +183,10 @@ static int vchiq_is_connected(VCHIQ_INSTANCE_T instance)
 }
 
 /****************************************************************************
-*
-*   vchiq_connect
-*
-***************************************************************************/
+ *
+ *   vchiq_connect
+ *
+ ***************************************************************************/
 
 VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
 {
@@ -215,10 +218,10 @@ VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
 EXPORT_SYMBOL(vchiq_connect);
 
 /****************************************************************************
-*
-*   vchiq_add_service
-*
-***************************************************************************/
+ *
+ *   vchiq_add_service
+ *
+ ***************************************************************************/
 
 VCHIQ_STATUS_T vchiq_add_service(
 	VCHIQ_INSTANCE_T              instance,
@@ -260,10 +263,10 @@ VCHIQ_STATUS_T vchiq_add_service(
 EXPORT_SYMBOL(vchiq_add_service);
 
 /****************************************************************************
-*
-*   vchiq_open_service
-*
-***************************************************************************/
+ *
+ *   vchiq_open_service
+ *
+ ***************************************************************************/
 
 VCHIQ_STATUS_T vchiq_open_service(
 	VCHIQ_INSTANCE_T              instance,
@@ -414,8 +417,9 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
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
@@ -441,7 +445,9 @@ vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 
 		if (bulk) {
 			/* Cancel the signal when the transfer
-			 ** completes. */
+			 *
+			 * completes.
+			 */
 			spin_lock(&bulk_waiter_spinlock);
 			bulk->userdata = NULL;
 			spin_unlock(&bulk_waiter_spinlock);
-- 
2.13.6 (Apple Git-96)
