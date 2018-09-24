From: qader.aymen@gmail.com (Aymen Qader)
Date: Mon, 24 Sep 2018 18:27:43 +0100
Subject: [PATCH v3 4/4] staging: vc04_services: Remove spaces after '*'
In-Reply-To: <20180924172743.21153-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
 <20180924172743.21153-1-qader.aymen@gmail.com>
Message-ID: <20180924172743.21153-5-qader.aymen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the checkpatch.pl error:

ERROR: "foo * bar" should be "foo *bar"

in the interface/vchi directory

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index f96676227ddc..3fe19d72b3ab 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -116,8 +116,8 @@ typedef struct service_info_tag {
 extern "C" {
 #endif
 
-extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
-								 const VCHI_MESSAGE_DRIVER_T * low_level);
+extern /*@observer@*/ VCHI_CONNECTION_T *vchi_create_connection(const VCHI_CONNECTION_API_T *function_table,
+								 const VCHI_MESSAGE_DRIVER_T *low_level);
 
 // Routine used to initialise the vchi on both local + remote connections
 extern int32_t vchi_initialise(VCHI_INSTANCE_T *instance_handle);
@@ -137,7 +137,7 @@ extern int32_t vchi_crc_control(VCHI_CONNECTION_T *connection,
 				VCHI_CRC_CONTROL_T control);
 
 // helper functions
-extern void * vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
+extern void *vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
 extern void vchi_free_buffer(VCHI_SERVICE_HANDLE_T handle, void *address);
 extern uint32_t vchi_current_time(VCHI_INSTANCE_T instance_handle);
 
-- 
2.17.1
