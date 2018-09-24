From: qader.aymen@gmail.com (Aymen Qader)
Date: Mon, 24 Sep 2018 18:27:41 +0100
Subject: [PATCH v3 2/4] staging: vc04_services: Use tabs instead of spaces
In-Reply-To: <20180924172743.21153-1-qader.aymen@gmail.com>
References: <20180923140620.14583-1-qader.aymen@gmail.com>
 <20180924172743.21153-1-qader.aymen@gmail.com>
Message-ID: <20180924172743.21153-3-qader.aymen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the checkpatch.pl error:

ERROR: code indent should use tabs where possible

in the interface/vchi directory

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 .../vc04_services/interface/vchi/vchi.h       | 116 +++++++++---------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index ffb8caaacaea..cb2582a4eb6a 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -71,23 +71,23 @@ typedef struct vchi_msg_vector_ex {
    VCHI_MSG_VECTOR_TYPE_T type;
    union {
       // a memory handle
-      struct {
-         VCHI_MEM_HANDLE_T handle;
-         uint32_t offset;
-         int32_t vec_len;
-      } handle;
+	struct {
+		VCHI_MEM_HANDLE_T handle;
+		uint32_t offset;
+		int32_t vec_len;
+	} handle;
 
       // an ordinary data pointer
-      struct {
-         const void *vec_base;
-         int32_t vec_len;
+	struct {
+		const void *vec_base;
+		int32_t vec_len;
       } ptr;
 
       // a nested vector list
-      struct {
-         struct vchi_msg_vector_ex *vec;
-         uint32_t vec_len;
-      } list;
+	struct {
+		struct vchi_msg_vector_ex *vec;
+		uint32_t vec_len;
+	} list;
    } u;
 } VCHI_MSG_VECTOR_EX_T;
 
@@ -155,7 +155,7 @@ extern "C" {
 #endif
 
 extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
-                                                   const VCHI_MESSAGE_DRIVER_T * low_level);
+								 const VCHI_MESSAGE_DRIVER_T * low_level);
 
 // Routine used to initialise the vchi on both local + remote connections
 extern int32_t vchi_initialise(VCHI_INSTANCE_T *instance_handle);
@@ -163,8 +163,8 @@ extern int32_t vchi_initialise(VCHI_INSTANCE_T *instance_handle);
 extern int32_t vchi_exit(void);
 
 extern int32_t vchi_connect(VCHI_CONNECTION_T **connections,
-                             const uint32_t num_connections,
-                             VCHI_INSTANCE_T instance_handle);
+			    const uint32_t num_connections,
+			    VCHI_INSTANCE_T instance_handle);
 
 //When this is called, ensure that all services have no data pending.
 //Bulk transfers can remain 'queued'
@@ -172,7 +172,7 @@ extern int32_t vchi_disconnect(VCHI_INSTANCE_T instance_handle);
 
 // Global control over bulk CRC checking
 extern int32_t vchi_crc_control(VCHI_CONNECTION_T *connection,
-                                 VCHI_CRC_CONTROL_T control);
+				VCHI_CRC_CONTROL_T control);
 
 // helper functions
 extern void * vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
@@ -184,19 +184,19 @@ extern uint32_t vchi_current_time(VCHI_INSTANCE_T instance_handle);
  *****************************************************************************/
 // Routine to create a named service
 extern int32_t vchi_service_create(VCHI_INSTANCE_T instance_handle,
-                                    SERVICE_CREATION_T *setup,
-                                    VCHI_SERVICE_HANDLE_T *handle);
+				   SERVICE_CREATION_T *setup,
+				   VCHI_SERVICE_HANDLE_T *handle);
 
 // Routine to destroy a service
 extern int32_t vchi_service_destroy(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to open a named service
 extern int32_t vchi_service_open(VCHI_INSTANCE_T instance_handle,
-                                  SERVICE_CREATION_T *setup,
-                                  VCHI_SERVICE_HANDLE_T *handle);
+				 SERVICE_CREATION_T *setup,
+				 VCHI_SERVICE_HANDLE_T *handle);
 
 extern int32_t vchi_get_peer_version(const VCHI_SERVICE_HANDLE_T handle,
-                                      short *peer_version);
+				     short *peer_version);
 
 // Routine to close a named service
 extern int32_t vchi_service_close(const VCHI_SERVICE_HANDLE_T handle);
@@ -227,18 +227,18 @@ vchi_queue_user_message(VCHI_SERVICE_HANDLE_T handle,
 // Routine to receive a msg from a service
 // Dequeue is equivalent to hold, copy into client buffer, release
 extern int32_t vchi_msg_dequeue(VCHI_SERVICE_HANDLE_T handle,
-                                 void *data,
-                                 uint32_t max_data_size_to_read,
-                                 uint32_t *actual_msg_size,
-                                 VCHI_FLAGS_T flags);
+				void *data,
+				uint32_t max_data_size_to_read,
+				uint32_t *actual_msg_size,
+				VCHI_FLAGS_T flags);
 
 // Routine to look at a message in place.
 // The message is not dequeued, so a subsequent call to peek or dequeue
 // will return the same message.
 extern int32_t vchi_msg_peek(VCHI_SERVICE_HANDLE_T handle,
-                              void **data,
-                              uint32_t *msg_size,
-                              VCHI_FLAGS_T flags);
+			     void **data,
+			     uint32_t *msg_size,
+			     VCHI_FLAGS_T flags);
 
 // Routine to remove a message after it has been read in place with peek
 // The first message on the queue is dequeued.
@@ -248,15 +248,15 @@ extern int32_t vchi_msg_remove(VCHI_SERVICE_HANDLE_T handle);
 // The message is dequeued, so the caller is left holding it; the descriptor is
 // filled in and must be released when the user has finished with the message.
 extern int32_t vchi_msg_hold(VCHI_SERVICE_HANDLE_T handle,
-                              void **data,        // } may be NULL, as info can be
-                              uint32_t *msg_size, // } obtained from HELD_MSG_T
-                              VCHI_FLAGS_T flags,
-                              VCHI_HELD_MSG_T *message_descriptor);
+			     void **data,        // } may be NULL, as info can be
+			     uint32_t *msg_size, // } obtained from HELD_MSG_T
+			     VCHI_FLAGS_T flags,
+			     VCHI_HELD_MSG_T *message_descriptor);
 
 // Initialise an iterator to look through messages in place
 extern int32_t vchi_msg_look_ahead(VCHI_SERVICE_HANDLE_T handle,
-                                    VCHI_MSG_ITER_T *iter,
-                                    VCHI_FLAGS_T flags);
+				   VCHI_MSG_ITER_T *iter,
+				   VCHI_FLAGS_T flags);
 
 /******************************************************************************
  Global service support API - operations on held messages and message iterators
@@ -282,8 +282,8 @@ extern int32_t vchi_msg_iter_has_next(const VCHI_MSG_ITER_T *iter);
 
 // Return the pointer and length for the next message and advance the iterator.
 extern int32_t vchi_msg_iter_next(VCHI_MSG_ITER_T *iter,
-                                   void **data,
-                                   uint32_t *msg_size);
+				  void **data,
+				  uint32_t *msg_size);
 
 // Remove the last message returned by vchi_msg_iter_next.
 // Can only be called once after each call to vchi_msg_iter_next.
@@ -292,13 +292,13 @@ extern int32_t vchi_msg_iter_remove(VCHI_MSG_ITER_T *iter);
 // Hold the last message returned by vchi_msg_iter_next.
 // Can only be called once after each call to vchi_msg_iter_next.
 extern int32_t vchi_msg_iter_hold(VCHI_MSG_ITER_T *iter,
-                                   VCHI_HELD_MSG_T *message);
+				  VCHI_HELD_MSG_T *message);
 
 // Return information for the next message, and hold it, advancing the iterator.
 extern int32_t vchi_msg_iter_hold_next(VCHI_MSG_ITER_T *iter,
-                                        void **data,        // } may be NULL
-                                        uint32_t *msg_size, // }
-                                        VCHI_HELD_MSG_T *message);
+				       void **data,        // } may be NULL
+				       uint32_t *msg_size, // }
+				       VCHI_HELD_MSG_T *message);
 
 /******************************************************************************
  Global bulk API
@@ -306,25 +306,25 @@ extern int32_t vchi_msg_iter_hold_next(VCHI_MSG_ITER_T *iter,
 
 // Routine to prepare interface for a transfer from the other side
 extern int32_t vchi_bulk_queue_receive(VCHI_SERVICE_HANDLE_T handle,
-                                        void *data_dst,
-                                        uint32_t data_size,
-                                        VCHI_FLAGS_T flags,
-                                        void *transfer_handle);
+				       void *data_dst,
+				       uint32_t data_size,
+				       VCHI_FLAGS_T flags,
+				       void *transfer_handle);
 
 // Prepare interface for a transfer from the other side into relocatable memory.
 int32_t vchi_bulk_queue_receive_reloc(const VCHI_SERVICE_HANDLE_T handle,
-                                       VCHI_MEM_HANDLE_T h_dst,
-                                       uint32_t offset,
-                                       uint32_t data_size,
-                                       const VCHI_FLAGS_T flags,
-                                       void * const bulk_handle);
+				      VCHI_MEM_HANDLE_T h_dst,
+				      uint32_t offset,
+				      uint32_t data_size,
+				      const VCHI_FLAGS_T flags,
+				      void * const bulk_handle);
 
 // Routine to queue up data ready for transfer to the other (once they have signalled they are ready)
 extern int32_t vchi_bulk_queue_transmit(VCHI_SERVICE_HANDLE_T handle,
-                                         const void *data_src,
-                                         uint32_t data_size,
-                                         VCHI_FLAGS_T flags,
-                                         void *transfer_handle);
+					const void *data_src,
+					uint32_t data_size,
+					VCHI_FLAGS_T flags,
+					void *transfer_handle);
 
 /******************************************************************************
  Configuration plumbing
@@ -343,11 +343,11 @@ const VCHI_MESSAGE_DRIVER_T *vchi_mphi_message_driver_func_table(void);
 #endif
 
 extern int32_t vchi_bulk_queue_transmit_reloc(VCHI_SERVICE_HANDLE_T handle,
-                                               VCHI_MEM_HANDLE_T h_src,
-                                               uint32_t offset,
-                                               uint32_t data_size,
-                                               VCHI_FLAGS_T flags,
-                                               void *transfer_handle);
+					      VCHI_MEM_HANDLE_T h_src,
+					      uint32_t offset,
+					      uint32_t data_size,
+					      VCHI_FLAGS_T flags,
+					      void *transfer_handle);
 #endif /* VCHI_H_ */
 
 /****************************** End of file **********************************/
-- 
2.17.1
