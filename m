From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 18:23:40 +0100
Subject: [PATCH] ARM: imx: fix missing includes
Message-ID: <1465406620-29671-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warnings by adding the include files
that define them:

arch/arm/mach-imx/devices/devices.c:25:15: warning: symbol 'mxc_aips_bus' was not declared. Should it be static?
arch/arm/mach-imx/devices/devices.c:29:15: warning: symbol 'mxc_ahb_bus' was not declared. Should it be static?
arch/arm/mach-imx/devices/devices.c:33:12: warning: symbol 'mxc_device_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-imx/devices/devices.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/devices/devices.c b/arch/arm/mach-imx/devices/devices.c
index 8eab544..3004517 100644
--- a/arch/arm/mach-imx/devices/devices.c
+++ b/arch/arm/mach-imx/devices/devices.c
@@ -22,6 +22,9 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 
+#include "../common.h"
+#include "devices-common.h"
+
 struct device mxc_aips_bus = {
 	.init_name	= "mxc_aips",
 };
-- 
2.8.1
