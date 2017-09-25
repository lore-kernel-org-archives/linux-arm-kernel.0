From: marco.franchi@nxp.com (Marco Franchi)
Date: Mon, 25 Sep 2017 15:55:57 -0300
Subject: [PATCH 2/4] ARM: imx: 3ds-debugboard: Include "3ds_debugboard.h"
 header file
In-Reply-To: <1506365759-28768-1-git-send-email-marco.franchi@nxp.com>
References: <1506365759-28768-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1506365759-28768-2-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warning is seen with W=1:

warning: no previous prototype for ?mxc_expio_init? 
[-Wmissing-prototypes] int __init mxc_expio_init(u32 base, u32 intr_gpio)

Fix this warning by including "3ds_debugboard.h".

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
 arch/arm/mach-imx/3ds_debugboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/3ds_debugboard.c b/arch/arm/mach-imx/3ds_debugboard.c
index cda330c..0015abe 100644
--- a/arch/arm/mach-imx/3ds_debugboard.c
+++ b/arch/arm/mach-imx/3ds_debugboard.c
@@ -20,7 +20,7 @@
 #include <linux/smsc911x.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
-
+#include "3ds_debugboard.h"
 #include "hardware.h"
 
 /* LAN9217 ethernet base address */
-- 
2.7.4
