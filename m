From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 07 Oct 2011 12:20:14 +0800
Subject: [PATCH] ARM: SAMSUNG: s3c-dma-ops needs export.h for EXPORT_SYMBOL
Message-ID: <1317961214.16109.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix below build warning:
  CC      arch/arm/plat-samsung/s3c-dma-ops.o
arch/arm/plat-samsung/s3c-dma-ops.c:130: warning: data definition has no type or storage class
arch/arm/plat-samsung/s3c-dma-ops.c:130: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
arch/arm/plat-samsung/s3c-dma-ops.c:130: warning: parameter names (without types) in function declaration

And fix the build error:
ERROR: "s3c_dma_get_ops" [drivers/spi/spi-s3c64xx.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This can be reproduced by "make s3c6400_defconfig;make" on linux-next 20111006.
 arch/arm/plat-samsung/s3c-dma-ops.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/s3c-dma-ops.c b/arch/arm/plat-samsung/s3c-dma-ops.c
index 582333c..7814949 100644
--- a/arch/arm/plat-samsung/s3c-dma-ops.c
+++ b/arch/arm/plat-samsung/s3c-dma-ops.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/export.h>
 
 #include <mach/dma.h>
 
-- 
1.7.4.1
