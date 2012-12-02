From: axel.lin@ingics.com (Axel Lin)
Date: Sun, 02 Dec 2012 23:32:19 +0800
Subject: [PATCH] ARM: sunxi: Include linux/delay.h
Message-ID: <1354462339.24917.0.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes below build error:

  CC      arch/arm/mach-sunxi/sunxi.o
arch/arm/mach-sunxi/sunxi.c: In function 'sunxi_restart':
arch/arm/mach-sunxi/sunxi.c:55:3: error: implicit declaration of function 'mdelay' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-sunxi/sunxi.o] Error 1
make: *** [arch/arm/mach-sunxi] Error 2

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 arch/arm/mach-sunxi/sunxi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index dc634ae..fba8d6e 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-- 
1.7.9.5
