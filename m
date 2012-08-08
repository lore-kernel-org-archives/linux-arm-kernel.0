From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  8 Aug 2012 10:06:16 -0300
Subject: [PATCH] ARM: plat-mxc: Remove unused imx_ioremap
Message-ID: <1344431176-10486-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx_ioremap is no longer used on imx platforms, so remove it.

As the EXPORT_SYMBOL_GPL is removed, it is also safe to remove the module.h header.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/system.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 1996c3e..3da78cf 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -21,7 +21,6 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/module.h>
 
 #include <mach/hardware.h>
 #include <mach/common.h>
@@ -29,9 +28,6 @@
 #include <asm/proc-fns.h>
 #include <asm/mach-types.h>
 
-void __iomem *(*imx_ioremap)(unsigned long, size_t, unsigned int) = NULL;
-EXPORT_SYMBOL_GPL(imx_ioremap);
-
 static void __iomem *wdog_base;
 
 /*
-- 
1.7.1
