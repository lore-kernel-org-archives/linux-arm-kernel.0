From: eballetbo@gmail.com (Enric Balletbo i Serra)
Date: Wed, 19 Dec 2012 10:48:46 +0100
Subject: [PATCH] staging: tidspbridge: Fix build breakage due to splitting CM
 functions.
Message-ID: <1355910526-29691-1-git-send-email-eballetbo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Commit ff4ae5d (ARM: OMAP2+: CM/hwmod: split CM functions into OMAP2, OMAP3-specific files)
resulted in a build breakage for tidspbridge driver.

   ...
   CC [M]  drivers/staging/tidspbridge/core/tiomap3430.o
   staging/tidspbridge/core/tiomap3430.c: In function ?bridge_brd_start?:
   staging/tidspbridge/core/tiomap3430.c:550:24: error: ?OMAP3430_CM_AUTOIDLE_PLL?
     undeclared (first use in this function)
   make[3]: *** [drivers/staging/tidspbridge/core/tiomap3430.o] Error 1
   ...

Fix this by including the appropriate header file.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 drivers/staging/tidspbridge/core/_tiomap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/tidspbridge/core/_tiomap.h b/drivers/staging/tidspbridge/core/_tiomap.h
index 543a127..b783bfa 100644
--- a/drivers/staging/tidspbridge/core/_tiomap.h
+++ b/drivers/staging/tidspbridge/core/_tiomap.h
@@ -31,7 +31,7 @@
  * driver should read or write to PRM/CM registers directly; they
  * should rely on OMAP core code to do this.
  */
-#include <mach-omap2/cm2xxx_3xxx.h>
+#include <mach-omap2/cm3xxx.h>
 #include <mach-omap2/prm-regbits-34xx.h>
 #include <mach-omap2/cm-regbits-34xx.h>
 #include <dspbridge/devdefs.h>
-- 
1.7.10.4
