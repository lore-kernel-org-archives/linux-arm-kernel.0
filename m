From: alexander@alemayhu.com (Alexander Alemayhu)
Date: Tue,  7 Feb 2017 12:53:08 +0100
Subject: [PATCH] staging: vc04_services: remove unused functions
Message-ID: <20170207115308.5208-1-alexander@alemayhu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looking at the history these calls were introduced in 71bad7f08641
(staging: add bcm2708 vchiq driver, 2013-07-02) and they were not
being used at all.

Discovered using sparse and fixes the following output:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c:816:1: warning: symbol 'vchi_readbuf_uint32' was not declared. Should it be static?
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c:827:1: warning: symbol 'vchi_writebuf_uint32' was not declared. Should it be static?
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c:841:1: warning: symbol 'vchi_readbuf_uint16' was not declared. Should it be static?
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c:852:1: warning: symbol 'vchi_writebuf_uint16' was not declared. Should it be static?

Signed-off-by: Alexander Alemayhu <alexander@alemayhu.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c | 48 ----------------------
 1 file changed, 48 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 48984abc3854..cd0c332210ca 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -808,54 +808,6 @@ int32_t vchi_get_peer_version(const VCHI_SERVICE_HANDLE_T handle, short *peer_ve
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
2.11.1
