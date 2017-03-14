From: jb@abbadie.fr (Jean-Baptiste Abbadie)
Date: Tue, 14 Mar 2017 20:14:20 +0100
Subject: [PATCH] staging: vc04_services: Remove unused functions
Message-ID: <20170314191420.5540-1-jb@abbadie.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These four functions are not used and report errors with sparse.

Signed-off-by: Jean-Baptiste Abbadie <jb@abbadie.fr>
---
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c | 50 ----------------------
 1 file changed, 50 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 46bb8bd7583b..8af95fc361ed 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -814,56 +814,6 @@ int32_t vchi_get_peer_version(const VCHI_SERVICE_HANDLE_T handle, short *peer_ve
 }
 EXPORT_SYMBOL(vchi_get_peer_version);
 
-/* ----------------------------------------------------------------------
- * read a uint32_t from buffer.
- * network format is defined to be little endian
- * -------------------------------------------------------------------- */
-uint32_t
-vchi_readbuf_uint32(const void *_ptr)
-{
-	const unsigned char *ptr = _ptr;
-	return ptr[0] | (ptr[1] << 8) | (ptr[2] << 16) | (ptr[3] << 24);
-}
-
-/* ----------------------------------------------------------------------
- * write a uint32_t to buffer.
- * network format is defined to be little endian
- * -------------------------------------------------------------------- */
-void
-vchi_writebuf_uint32(void *_ptr, uint32_t value)
-{
-	unsigned char *ptr = _ptr;
-
-	ptr[0] = (unsigned char)((value >> 0)  & 0xFF);
-	ptr[1] = (unsigned char)((value >> 8)  & 0xFF);
-	ptr[2] = (unsigned char)((value >> 16) & 0xFF);
-	ptr[3] = (unsigned char)((value >> 24) & 0xFF);
-}
-
-/* ----------------------------------------------------------------------
- * read a uint16_t from buffer.
- * network format is defined to be little endian
- * -------------------------------------------------------------------- */
-uint16_t
-vchi_readbuf_uint16(const void *_ptr)
-{
-	const unsigned char *ptr = _ptr;
-
-	return ptr[0] | (ptr[1] << 8);
-}
-
-/* ----------------------------------------------------------------------
- * write a uint16_t into the buffer.
- * network format is defined to be little endian
- * -------------------------------------------------------------------- */
-void
-vchi_writebuf_uint16(void *_ptr, uint16_t value)
-{
-	unsigned char *ptr = _ptr;
-	ptr[0] = (value >> 0)  & 0xFF;
-	ptr[1] = (value >> 8)  & 0xFF;
-}
-
 /***********************************************************
  * Name: vchi_service_use
  *
-- 
2.12.0
