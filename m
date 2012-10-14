From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 14 Oct 2012 15:13:10 -0300
Subject: [PATCH] lib: decompress_unlzo: Change include file name
Message-ID: <1350238390-1549-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 7c979cebc (lib/lzo: Rename lzo1x_decompress.c to lzo1x_decompress_safe.c) 
renamed lzo1x_decompress.c file, but missed to update lib/decompress_unlzo.c,
which breaks imx_v6_v7_defconfig build:

arch/arm/boot/compressed/../../../../lib/decompress_unlzo.c:34:34: fatal error: lzo/lzo1x_decompress.c: No such file or directory

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 lib/decompress_unlzo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/decompress_unlzo.c b/lib/decompress_unlzo.c
index 4531294..960183d 100644
--- a/lib/decompress_unlzo.c
+++ b/lib/decompress_unlzo.c
@@ -31,7 +31,7 @@
  */
 
 #ifdef STATIC
-#include "lzo/lzo1x_decompress.c"
+#include "lzo/lzo1x_decompress_safe.c"
 #else
 #include <linux/decompress/unlzo.h>
 #endif
-- 
1.7.9.5
