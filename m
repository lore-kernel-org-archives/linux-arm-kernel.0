From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:26:17 +0100
Subject: [PATCH] ARM: imx: fix missing include of common.h
Message-ID: <1465406777-336-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning by including ../common.h to provide
the protoype for mxc_register_gpio() :

arch/arm/mach-imx/devices/platform-gpio-mxc.c:11:24: warning: symbol 'mxc_register_gpio' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-imx/devices/platform-gpio-mxc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/devices/platform-gpio-mxc.c b/arch/arm/mach-imx/devices/platform-gpio-mxc.c
index 26483fa..cd1fe69 100644
--- a/arch/arm/mach-imx/devices/platform-gpio-mxc.c
+++ b/arch/arm/mach-imx/devices/platform-gpio-mxc.c
@@ -7,6 +7,7 @@
  * Free Software Foundation.
  */
 #include "devices-common.h"
+#include "../common.h"
 
 struct platform_device *__init mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high)
-- 
2.8.1
