From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 21 Jan 2014 16:22:19 -0500
Subject: [PATCH 16/73] arm: include module.h in drivers/bus/omap_l3_smx.c
In-Reply-To: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1390339396-3479-17-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config OMAP_INTERCONNECT that this driver depends on (in
drivers/bus/Kconfig) is tristate.  So it can be a module.

Also there are module related setup calls within this driver.
Explicitly add module.h to includes so it won't be a build failure
when future cleanups are integrated and the implicit presence
of certain module prototypes disappears.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/bus/omap_l3_smx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index acc2164..8a61433 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -23,6 +23,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
-- 
1.8.4.1
