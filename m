From: andrealmeid@riseup.net (andrealmeid at riseup.net)
Date: Tue, 13 Nov 2018 16:58:34 -0200
Subject: [PATCH v3 1/2] staging: vchi: change type 'int32_t' to 's32'
In-Reply-To: <20181113185835.14429-1-andrealmeid@riseup.net>
References: <20181113185835.14429-1-andrealmeid@riseup.net>
Message-ID: <20181113185835.14429-2-andrealmeid@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andr? Almeida <andrealmeid@riseup.net>

As one can see in a typedef at linux/types.h:103, s32 and int32_t are
both a 32 bits signed integer. s32 is preferred because it is defined
by the kernel maintainers and it prevents portability issues. Changed
to meet checkpatch criteria.

Signed-off-by: Andr? Almeida <andrealmeid@riseup.net>
---
 drivers/staging/vc04_services/interface/vchi/vchi_mh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
index 198bd076b666..40c760d493a1 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
@@ -36,7 +36,7 @@
 
 #include <linux/types.h>
 
-typedef int32_t VCHI_MEM_HANDLE_T;
+typedef s32 VCHI_MEM_HANDLE_T;
 #define VCHI_MEM_HANDLE_INVALID 0
 
 #endif
-- 
2.19.1
