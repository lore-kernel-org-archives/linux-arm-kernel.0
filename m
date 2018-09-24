From: qader.aymen@gmail.com (Aymen Qader)
Date: Mon, 24 Sep 2018 18:35:46 +0100
Subject: [PATCH v4 3/4] staging: vc04_services: Remove unused macros
In-Reply-To: <20180924173547.23393-1-qader.aymen@gmail.com>
References: <20180924173547.23393-1-qader.aymen@gmail.com>
Message-ID: <20180924173547.23393-4-qader.aymen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the macros and structs associated with the
"vchi_msg_queuev_ex" function, which was previously removed in 49bec49.
Also fixes the checkpatch.pl errors:

ERROR: Macros with complex values should be enclosed in parentheses
ERROR: space required after that ','

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 .../vc04_services/interface/vchi/vchi.h       | 38 -------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index cb2582a4eb6a..f96676227ddc 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -60,46 +60,8 @@ struct vchi_version {
 #define VCHI_VERSION(v_) { v_, v_ }
 #define VCHI_VERSION_EX(v_, m_) { v_, m_ }
 
-typedef enum {
-   VCHI_VEC_POINTER,
-   VCHI_VEC_HANDLE,
-   VCHI_VEC_LIST
-} VCHI_MSG_VECTOR_TYPE_T;
-
-typedef struct vchi_msg_vector_ex {
-
-   VCHI_MSG_VECTOR_TYPE_T type;
-   union {
-      // a memory handle
-	struct {
-		VCHI_MEM_HANDLE_T handle;
-		uint32_t offset;
-		int32_t vec_len;
-	} handle;
-
-      // an ordinary data pointer
-	struct {
-		const void *vec_base;
-		int32_t vec_len;
-      } ptr;
-
-      // a nested vector list
-	struct {
-		struct vchi_msg_vector_ex *vec;
-		uint32_t vec_len;
-	} list;
-   } u;
-} VCHI_MSG_VECTOR_EX_T;
-
-// Construct an entry in a msg vector for a pointer (p) of length (l)
-#define VCHI_VEC_POINTER(p,l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
-
-// Construct an entry in a msg vector for a message handle (h), starting at offset (o) of length (l)
-#define VCHI_VEC_HANDLE(h,o,l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
-
 // Macros to manipulate 'FOURCC' values
 #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
-#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF,(x >> 16) & 0xFF,(x >> 8) & 0xFF, x & 0xFF
 
 // Opaque service information
 struct opaque_vchi_service_t;
-- 
2.17.1
