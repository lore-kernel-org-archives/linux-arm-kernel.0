From: adrien.descamps@gmail.com (Adrien Descamps)
Date: Tue, 17 Jan 2017 19:57:08 +0100
Subject: [PATCH] Fix coding style errors "open brace go on the same line"
Message-ID: <1484679428-2802-1-git-send-email-adrien.descamps@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Open braces for enum, union and struct go on the same line.

Signed-off-by: Adrien Descamps <adrien.descamps@gmail.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 .../interface/vchi/connections/connection.h            |  3 +--
 .../interface/vchi/message_drivers/message.h           |  9 +++------
 drivers/staging/vc04_services/interface/vchi/vchi.h    | 18 ++++++------------
 .../staging/vc04_services/interface/vchi/vchi_common.h |  9 +++------
 .../vc04_services/interface/vchiq_arm/vchiq_debugfs.h  |  3 +--
 5 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/connections/connection.h b/drivers/staging/vc04_services/interface/vchi/connections/connection.h
index fef6ac3..e793cdf 100644
--- a/drivers/staging/vc04_services/interface/vchi/connections/connection.h
+++ b/drivers/staging/vc04_services/interface/vchi/connections/connection.h
@@ -217,8 +217,7 @@ typedef void   (*VCHI_BUFFER_FREE)(VCHI_CONNECTION_SERVICE_HANDLE_T service_hand
  System driver struct
  *****************************************************************************/
 
-struct opaque_vchi_connection_api_t
-{
+struct opaque_vchi_connection_api_t {
    // Routine to init the connection
    VCHI_CONNECTION_INIT_T                      init;
 
diff --git a/drivers/staging/vc04_services/interface/vchi/message_drivers/message.h b/drivers/staging/vc04_services/interface/vchi/message_drivers/message.h
index 8b3f767..a7740a4 100644
--- a/drivers/staging/vc04_services/interface/vchi/message_drivers/message.h
+++ b/drivers/staging/vc04_services/interface/vchi/message_drivers/message.h
@@ -53,14 +53,12 @@ typedef enum message_event_type {
    MESSAGE_EVENT_MSG_DISCARDED
 } MESSAGE_EVENT_TYPE_T;
 
-typedef enum vchi_msg_flags
-{
+typedef enum vchi_msg_flags {
    VCHI_MSG_FLAGS_NONE                  = 0x0,
    VCHI_MSG_FLAGS_TERMINATE_DMA         = 0x1
 } VCHI_MSG_FLAGS_T;
 
-typedef enum message_tx_channel
-{
+typedef enum message_tx_channel {
    MESSAGE_TX_CHANNEL_MESSAGE           = 0,
    MESSAGE_TX_CHANNEL_BULK              = 1 // drivers may provide multiple bulk channels, from 1 upwards
 } MESSAGE_TX_CHANNEL_T;
@@ -69,8 +67,7 @@ typedef enum message_tx_channel
 #define MESSAGE_TX_CHANNEL_BULK_PREV(c) (MESSAGE_TX_CHANNEL_BULK+((c)-MESSAGE_TX_CHANNEL_BULK+VCHI_MAX_BULK_TX_CHANNELS_PER_CONNECTION-1)%VCHI_MAX_BULK_TX_CHANNELS_PER_CONNECTION)
 #define MESSAGE_TX_CHANNEL_BULK_NEXT(c) (MESSAGE_TX_CHANNEL_BULK+((c)-MESSAGE_TX_CHANNEL_BULK+1)%VCHI_MAX_BULK_TX_CHANNELS_PER_CONNECTION)
 
-typedef enum message_rx_channel
-{
+typedef enum message_rx_channel {
    MESSAGE_RX_CHANNEL_MESSAGE           = 0,
    MESSAGE_RX_CHANNEL_BULK              = 1 // drivers may provide multiple bulk channels, from 1 upwards
 } MESSAGE_RX_CHANNEL_T;
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index d693728..44169d6 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -61,8 +61,7 @@ struct vchi_version {
 #define VCHI_VERSION(v_) { v_, v_ }
 #define VCHI_VERSION_EX(v_, m_) { v_, m_ }
 
-typedef enum
-{
+typedef enum {
    VCHI_VEC_POINTER,
    VCHI_VEC_HANDLE,
    VCHI_VEC_LIST
@@ -71,26 +70,22 @@ typedef enum
 typedef struct vchi_msg_vector_ex {
 
    VCHI_MSG_VECTOR_TYPE_T type;
-   union
-   {
+   union {
       // a memory handle
-      struct
-      {
+      struct {
          VCHI_MEM_HANDLE_T handle;
          uint32_t offset;
          int32_t vec_len;
       } handle;
 
       // an ordinary data pointer
-      struct
-      {
+      struct {
          const void *vec_base;
          int32_t vec_len;
       } ptr;
 
       // a nested vector list
-      struct
-      {
+      struct {
          struct vchi_msg_vector_ex *vec;
          uint32_t vec_len;
       } list;
@@ -114,8 +109,7 @@ struct opaque_vchi_service_t;
 
 // Descriptor for a held message. Allocated by client, initialised by vchi_msg_hold,
 // vchi_msg_iter_hold or vchi_msg_iter_hold_next. Fields are for internal VCHI use only.
-typedef struct
-{
+typedef struct {
    struct opaque_vchi_service_t *service;
    void *message;
 } VCHI_HELD_MSG_T;
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_common.h b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
index d535a72..3f7d843 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_common.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
@@ -36,8 +36,7 @@
 
 
 //flags used when sending messages (must be bitmapped)
-typedef enum
-{
+typedef enum {
    VCHI_FLAGS_NONE                      = 0x0,
    VCHI_FLAGS_BLOCK_UNTIL_OP_COMPLETE   = 0x1,   // waits for message to be received, or sent (NB. not the same as being seen on other side)
    VCHI_FLAGS_CALLBACK_WHEN_OP_COMPLETE = 0x2,   // run a callback when message sent
@@ -62,8 +61,7 @@ typedef enum {
 } VCHI_CRC_CONTROL_T;
 
 //callback reasons when an event occurs on a service
-typedef enum
-{
+typedef enum {
    VCHI_CALLBACK_REASON_MIN,
 
    //This indicates that there is data available
@@ -111,8 +109,7 @@ typedef enum
 } VCHI_CALLBACK_REASON_T;
 
 // service control options
-typedef enum
-{
+typedef enum {
    VCHI_SERVICE_OPTION_MIN,
 
    VCHI_SERVICE_OPTION_TRACE,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
index 4d6a378..1d95e3d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
@@ -36,8 +36,7 @@
 
 #include "vchiq_core.h"
 
-typedef struct vchiq_debugfs_node_struct
-{
+typedef struct vchiq_debugfs_node_struct {
     struct dentry *dentry;
 } VCHIQ_DEBUGFS_NODE_T;
 
-- 
2.1.4
