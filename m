From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu,  9 Jun 2016 13:10:26 +0100
Subject: [PATCH] ARM: imx: fix missing include of 3ds_debugboard.h
Message-ID: <1465474226-1838-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The declaration of mxc_expio_init() was not included from the
header file "3ds_debugboard.h", so include it to fix the warning:

arch/arm/mach-imx/3ds_debugboard.c:155:12: warning: symbol 'mxc_expio_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-imx/3ds_debugboard.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/3ds_debugboard.c b/arch/arm/mach-imx/3ds_debugboard.c
index cda330c..a3fdcaa 100644
--- a/arch/arm/mach-imx/3ds_debugboard.c
+++ b/arch/arm/mach-imx/3ds_debugboard.c
@@ -22,6 +22,7 @@
 #include <linux/regulator/fixed.h>
 
 #include "hardware.h"
+#include "3ds_debugboard.h"
 
 /* LAN9217 ethernet base address */
 #define LAN9217_BASE_ADDR(n)	(n + 0x0)
-- 
2.8.1
