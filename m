From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 28 Jun 2012 20:41:30 +0530
Subject: [PATCHv11 4/6] i2c: omap: Remove the definition of SYSS_RESETDONE_MASK
In-Reply-To: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340896292-12112-5-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the definition of SYSS_RESETDONE_MASK and use the
one in omap_hwmod.h.

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
- Add Felipe's reviewed by tag

 drivers/i2c/busses/i2c-omap.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6d05f18..4bbf288 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -43,6 +43,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <plat/omap_hwmod.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -158,9 +159,6 @@ enum {
 #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
 #endif
 
-/* OCP_SYSSTATUS bit definitions */
-#define SYSS_RESETDONE_MASK		(1 << 0)
-
 /* OCP_SYSCONFIG bit definitions */
 #define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
 #define SYSC_SIDLEMODE_MASK		(0x3 << 3)
-- 
1.7.5.4
