From: eric@anholt.net (Eric Anholt)
Date: Wed,  7 Mar 2018 10:57:16 -0800
Subject: [PATCH v2 6/6] staging: vc04_services: Remove
 vchiq_queue_bulk_{transmit, receive}.
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
Message-ID: <20180307185716.17449-6-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are dead code, including in the downstream Raspberry Pi tree.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
v2: new patch while I was looking around the code.

 .../vc04_services/interface/vchiq_arm/vchiq_arm.c    | 20 --------------------
 .../vc04_services/interface/vchiq_arm/vchiq_if.h     | 10 ----------
 2 files changed, 30 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 8068c0308b34..24d456b0a6f0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -406,26 +406,6 @@ VCHIQ_STATUS_T vchiq_open_service(
 }
 EXPORT_SYMBOL(vchiq_open_service);
 
-VCHIQ_STATUS_T
-vchiq_queue_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle,
-	const void *data, unsigned int size, void *userdata)
-{
-	return vchiq_bulk_transfer(handle,
-		VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
-		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_TRANSMIT);
-}
-EXPORT_SYMBOL(vchiq_queue_bulk_transmit);
-
-VCHIQ_STATUS_T
-vchiq_queue_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
-	unsigned int size, void *userdata)
-{
-	return vchiq_bulk_transfer(handle,
-		VCHI_MEM_HANDLE_INVALID, data, size, userdata,
-		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_RECEIVE);
-}
-EXPORT_SYMBOL(vchiq_queue_bulk_receive);
-
 VCHIQ_STATUS_T
 vchiq_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle, const void *data,
 	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 0e270852900d..e4109a83e628 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -149,16 +149,6 @@ vchiq_queue_message(VCHIQ_SERVICE_HANDLE_T handle,
 		    size_t size);
 extern void           vchiq_release_message(VCHIQ_SERVICE_HANDLE_T service,
 	VCHIQ_HEADER_T *header);
-extern VCHIQ_STATUS_T vchiq_queue_bulk_transmit(VCHIQ_SERVICE_HANDLE_T service,
-	const void *data, unsigned int size, void *userdata);
-extern VCHIQ_STATUS_T vchiq_queue_bulk_receive(VCHIQ_SERVICE_HANDLE_T service,
-	void *data, unsigned int size, void *userdata);
-extern VCHIQ_STATUS_T vchiq_queue_bulk_transmit_handle(
-	VCHIQ_SERVICE_HANDLE_T service, VCHI_MEM_HANDLE_T handle,
-	const void *offset, unsigned int size, void *userdata);
-extern VCHIQ_STATUS_T vchiq_queue_bulk_receive_handle(
-	VCHIQ_SERVICE_HANDLE_T service, VCHI_MEM_HANDLE_T handle,
-	void *offset, unsigned int size, void *userdata);
 extern VCHIQ_STATUS_T vchiq_bulk_transmit(VCHIQ_SERVICE_HANDLE_T service,
 	const void *data, unsigned int size, void *userdata,
 	VCHIQ_BULK_MODE_T mode);
-- 
2.16.2
