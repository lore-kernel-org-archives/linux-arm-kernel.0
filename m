From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 May 2013 16:55:41 -0300
Subject: [PATCH 1/2] ARM: imx: irq-common: Include header to avoid sparse
 warning
Message-ID: <1369425342-20153-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following sparse warning:

arch/arm/mach-imx/irq-common.c:24:5: warning: symbol 'mxc_set_irq_fiq' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/irq-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/irq-common.c b/arch/arm/mach-imx/irq-common.c
index 4b34f52..0a920d1 100644
--- a/arch/arm/mach-imx/irq-common.c
+++ b/arch/arm/mach-imx/irq-common.c
@@ -18,6 +18,7 @@
 
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/platform_data/asoc-imx-ssi.h>
 
 #include "irq-common.h"
 
-- 
1.8.1.2
