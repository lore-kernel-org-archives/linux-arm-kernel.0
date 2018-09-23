From: qader.aymen@gmail.com (Aymen Qader)
Date: Sun, 23 Sep 2018 14:07:27 +0100
Subject: [PATCH 1/5] staging: vc04_services: Fix "space prohibited"
Message-ID: <20180923130733.4128-1-qader.aymen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the checkpatch.pl error:

ERROR: space prohibited after/before that open/closed parenthesis

in the interface/vchi directory.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 .../vc04_services/interface/vchi/vchi.h       | 106 +++++++++---------
 .../vc04_services/interface/vchi/vchi_cfg.h   |   2 +-
 2 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 66a3a060fad2..ffb8caaacaea 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -98,7 +98,7 @@ typedef struct vchi_msg_vector_ex {
 #define VCHI_VEC_HANDLE(h,o,l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
 
 // Macros to manipulate 'FOURCC' values
-#define MAKE_FOURCC(x) ((int32_t)( (x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3] ))
+#define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
 #define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF,(x >> 16) & 0xFF,(x >> 8) & 0xFF, x & 0xFF
 
 // Opaque service information
@@ -154,25 +154,25 @@ typedef struct service_info_tag {
 extern "C" {
 #endif
 
-extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection( const VCHI_CONNECTION_API_T * function_table,
+extern /*@observer@*/ VCHI_CONNECTION_T * vchi_create_connection(const VCHI_CONNECTION_API_T * function_table,
                                                    const VCHI_MESSAGE_DRIVER_T * low_level);
 
 // Routine used to initialise the vchi on both local + remote connections
-extern int32_t vchi_initialise( VCHI_INSTANCE_T *instance_handle );
+extern int32_t vchi_initialise(VCHI_INSTANCE_T *instance_handle);
 
-extern int32_t vchi_exit( void );
+extern int32_t vchi_exit(void);
 
-extern int32_t vchi_connect( VCHI_CONNECTION_T **connections,
+extern int32_t vchi_connect(VCHI_CONNECTION_T **connections,
                              const uint32_t num_connections,
-                             VCHI_INSTANCE_T instance_handle );
+                             VCHI_INSTANCE_T instance_handle);
 
 //When this is called, ensure that all services have no data pending.
 //Bulk transfers can remain 'queued'
-extern int32_t vchi_disconnect( VCHI_INSTANCE_T instance_handle );
+extern int32_t vchi_disconnect(VCHI_INSTANCE_T instance_handle);
 
 // Global control over bulk CRC checking
-extern int32_t vchi_crc_control( VCHI_CONNECTION_T *connection,
-                                 VCHI_CRC_CONTROL_T control );
+extern int32_t vchi_crc_control(VCHI_CONNECTION_T *connection,
+                                 VCHI_CRC_CONTROL_T control);
 
 // helper functions
 extern void * vchi_allocate_buffer(VCHI_SERVICE_HANDLE_T handle, uint32_t *length);
@@ -183,32 +183,32 @@ extern uint32_t vchi_current_time(VCHI_INSTANCE_T instance_handle);
  Global service API
  *****************************************************************************/
 // Routine to create a named service
-extern int32_t vchi_service_create( VCHI_INSTANCE_T instance_handle,
+extern int32_t vchi_service_create(VCHI_INSTANCE_T instance_handle,
                                     SERVICE_CREATION_T *setup,
-                                    VCHI_SERVICE_HANDLE_T *handle );
+                                    VCHI_SERVICE_HANDLE_T *handle);
 
 // Routine to destroy a service
-extern int32_t vchi_service_destroy( const VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_service_destroy(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to open a named service
-extern int32_t vchi_service_open( VCHI_INSTANCE_T instance_handle,
+extern int32_t vchi_service_open(VCHI_INSTANCE_T instance_handle,
                                   SERVICE_CREATION_T *setup,
                                   VCHI_SERVICE_HANDLE_T *handle);
 
-extern int32_t vchi_get_peer_version( const VCHI_SERVICE_HANDLE_T handle,
-                                      short *peer_version );
+extern int32_t vchi_get_peer_version(const VCHI_SERVICE_HANDLE_T handle,
+                                      short *peer_version);
 
 // Routine to close a named service
-extern int32_t vchi_service_close( const VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_service_close(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to increment ref count on a named service
-extern int32_t vchi_service_use( const VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_service_use(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to decrement ref count on a named service
-extern int32_t vchi_service_release( const VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_service_release(const VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to set a control option for a named service
-extern int32_t vchi_service_set_option( const VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_service_set_option(const VCHI_SERVICE_HANDLE_T handle,
 					VCHI_SERVICE_OPTION_T option,
 					int value);
 
@@ -226,128 +226,128 @@ vchi_queue_user_message(VCHI_SERVICE_HANDLE_T handle,
 
 // Routine to receive a msg from a service
 // Dequeue is equivalent to hold, copy into client buffer, release
-extern int32_t vchi_msg_dequeue( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_msg_dequeue(VCHI_SERVICE_HANDLE_T handle,
                                  void *data,
                                  uint32_t max_data_size_to_read,
                                  uint32_t *actual_msg_size,
-                                 VCHI_FLAGS_T flags );
+                                 VCHI_FLAGS_T flags);
 
 // Routine to look at a message in place.
 // The message is not dequeued, so a subsequent call to peek or dequeue
 // will return the same message.
-extern int32_t vchi_msg_peek( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_msg_peek(VCHI_SERVICE_HANDLE_T handle,
                               void **data,
                               uint32_t *msg_size,
-                              VCHI_FLAGS_T flags );
+                              VCHI_FLAGS_T flags);
 
 // Routine to remove a message after it has been read in place with peek
 // The first message on the queue is dequeued.
-extern int32_t vchi_msg_remove( VCHI_SERVICE_HANDLE_T handle );
+extern int32_t vchi_msg_remove(VCHI_SERVICE_HANDLE_T handle);
 
 // Routine to look at a message in place.
 // The message is dequeued, so the caller is left holding it; the descriptor is
 // filled in and must be released when the user has finished with the message.
-extern int32_t vchi_msg_hold( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_msg_hold(VCHI_SERVICE_HANDLE_T handle,
                               void **data,        // } may be NULL, as info can be
                               uint32_t *msg_size, // } obtained from HELD_MSG_T
                               VCHI_FLAGS_T flags,
-                              VCHI_HELD_MSG_T *message_descriptor );
+                              VCHI_HELD_MSG_T *message_descriptor);
 
 // Initialise an iterator to look through messages in place
-extern int32_t vchi_msg_look_ahead( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_msg_look_ahead(VCHI_SERVICE_HANDLE_T handle,
                                     VCHI_MSG_ITER_T *iter,
-                                    VCHI_FLAGS_T flags );
+                                    VCHI_FLAGS_T flags);
 
 /******************************************************************************
  Global service support API - operations on held messages and message iterators
  *****************************************************************************/
 
 // Routine to get the address of a held message
-extern void *vchi_held_msg_ptr( const VCHI_HELD_MSG_T *message );
+extern void *vchi_held_msg_ptr(const VCHI_HELD_MSG_T *message);
 
 // Routine to get the size of a held message
-extern int32_t vchi_held_msg_size( const VCHI_HELD_MSG_T *message );
+extern int32_t vchi_held_msg_size(const VCHI_HELD_MSG_T *message);
 
 // Routine to get the transmit timestamp as written into the header by the peer
-extern uint32_t vchi_held_msg_tx_timestamp( const VCHI_HELD_MSG_T *message );
+extern uint32_t vchi_held_msg_tx_timestamp(const VCHI_HELD_MSG_T *message);
 
 // Routine to get the reception timestamp, written as we parsed the header
-extern uint32_t vchi_held_msg_rx_timestamp( const VCHI_HELD_MSG_T *message );
+extern uint32_t vchi_held_msg_rx_timestamp(const VCHI_HELD_MSG_T *message);
 
 // Routine to release a held message after it has been processed
-extern int32_t vchi_held_msg_release( VCHI_HELD_MSG_T *message );
+extern int32_t vchi_held_msg_release(VCHI_HELD_MSG_T *message);
 
 // Indicates whether the iterator has a next message.
-extern int32_t vchi_msg_iter_has_next( const VCHI_MSG_ITER_T *iter );
+extern int32_t vchi_msg_iter_has_next(const VCHI_MSG_ITER_T *iter);
 
 // Return the pointer and length for the next message and advance the iterator.
-extern int32_t vchi_msg_iter_next( VCHI_MSG_ITER_T *iter,
+extern int32_t vchi_msg_iter_next(VCHI_MSG_ITER_T *iter,
                                    void **data,
-                                   uint32_t *msg_size );
+                                   uint32_t *msg_size);
 
 // Remove the last message returned by vchi_msg_iter_next.
 // Can only be called once after each call to vchi_msg_iter_next.
-extern int32_t vchi_msg_iter_remove( VCHI_MSG_ITER_T *iter );
+extern int32_t vchi_msg_iter_remove(VCHI_MSG_ITER_T *iter);
 
 // Hold the last message returned by vchi_msg_iter_next.
 // Can only be called once after each call to vchi_msg_iter_next.
-extern int32_t vchi_msg_iter_hold( VCHI_MSG_ITER_T *iter,
-                                   VCHI_HELD_MSG_T *message );
+extern int32_t vchi_msg_iter_hold(VCHI_MSG_ITER_T *iter,
+                                   VCHI_HELD_MSG_T *message);
 
 // Return information for the next message, and hold it, advancing the iterator.
-extern int32_t vchi_msg_iter_hold_next( VCHI_MSG_ITER_T *iter,
+extern int32_t vchi_msg_iter_hold_next(VCHI_MSG_ITER_T *iter,
                                         void **data,        // } may be NULL
                                         uint32_t *msg_size, // }
-                                        VCHI_HELD_MSG_T *message );
+                                        VCHI_HELD_MSG_T *message);
 
 /******************************************************************************
  Global bulk API
  *****************************************************************************/
 
 // Routine to prepare interface for a transfer from the other side
-extern int32_t vchi_bulk_queue_receive( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_bulk_queue_receive(VCHI_SERVICE_HANDLE_T handle,
                                         void *data_dst,
                                         uint32_t data_size,
                                         VCHI_FLAGS_T flags,
-                                        void *transfer_handle );
+                                        void *transfer_handle);
 
 // Prepare interface for a transfer from the other side into relocatable memory.
-int32_t vchi_bulk_queue_receive_reloc( const VCHI_SERVICE_HANDLE_T handle,
+int32_t vchi_bulk_queue_receive_reloc(const VCHI_SERVICE_HANDLE_T handle,
                                        VCHI_MEM_HANDLE_T h_dst,
                                        uint32_t offset,
                                        uint32_t data_size,
                                        const VCHI_FLAGS_T flags,
-                                       void * const bulk_handle );
+                                       void * const bulk_handle);
 
 // Routine to queue up data ready for transfer to the other (once they have signalled they are ready)
-extern int32_t vchi_bulk_queue_transmit( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_bulk_queue_transmit(VCHI_SERVICE_HANDLE_T handle,
                                          const void *data_src,
                                          uint32_t data_size,
                                          VCHI_FLAGS_T flags,
-                                         void *transfer_handle );
+                                         void *transfer_handle);
 
 /******************************************************************************
  Configuration plumbing
  *****************************************************************************/
 
 // function prototypes for the different mid layers (the state info gives the different physical connections)
-extern const VCHI_CONNECTION_API_T *single_get_func_table( void );
-//extern const VCHI_CONNECTION_API_T *local_server_get_func_table( void );
-//extern const VCHI_CONNECTION_API_T *local_client_get_func_table( void );
+extern const VCHI_CONNECTION_API_T *single_get_func_table(void);
+//extern const VCHI_CONNECTION_API_T *local_server_get_func_table(void);
+//extern const VCHI_CONNECTION_API_T *local_client_get_func_table(void);
 
 // declare all message drivers here
-const VCHI_MESSAGE_DRIVER_T *vchi_mphi_message_driver_func_table( void );
+const VCHI_MESSAGE_DRIVER_T *vchi_mphi_message_driver_func_table(void);
 
 #ifdef __cplusplus
 }
 #endif
 
-extern int32_t vchi_bulk_queue_transmit_reloc( VCHI_SERVICE_HANDLE_T handle,
+extern int32_t vchi_bulk_queue_transmit_reloc(VCHI_SERVICE_HANDLE_T handle,
                                                VCHI_MEM_HANDLE_T h_src,
                                                uint32_t offset,
                                                uint32_t data_size,
                                                VCHI_FLAGS_T flags,
-                                               void *transfer_handle );
+                                               void *transfer_handle);
 #endif /* VCHI_H_ */
 
 /****************************** End of file **********************************/
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
index b6f42b86f206..0d3c468c3504 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
@@ -138,7 +138,7 @@
  * can guarantee this by enabling unaligned transmits).
  * Not API. */
 #ifndef VCHI_MIN_BULK_SIZE
-#  define VCHI_MIN_BULK_SIZE    ( VCHI_MAX_MSG_SIZE / 2 < 4096 ? VCHI_MAX_MSG_SIZE / 2 : 4096 )
+#  define VCHI_MIN_BULK_SIZE    (VCHI_MAX_MSG_SIZE / 2 < 4096 ? VCHI_MAX_MSG_SIZE / 2 : 4096)
 #endif
 
 /* Maximum size of bulk transmission chunks, for each interface type. A trade-off between
-- 
2.17.1
