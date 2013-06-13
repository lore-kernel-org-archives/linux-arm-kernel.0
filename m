From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 14 Jun 2013 00:45:50 +0200
Subject: [PATCH 2/3] pinctrl: s3c24xx: use correct header for chained_irq
 functions
In-Reply-To: <201306140044.15568.heiko@sntech.de>
References: <201306140044.15568.heiko@sntech.de>
Message-ID: <201306140045.51206.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

chained_irq_enter and chained_irq_exit moved to a real header under
linux/pinctrl instead of asm/.

Update the pinctrl driver to use the correct header and fix the build
error.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pinctrl/pinctrl-s3c24xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-s3c24xx.c b/drivers/pinctrl/pinctrl-s3c24xx.c
index c8b0399..24446da 100644
--- a/drivers/pinctrl/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/pinctrl-s3c24xx.c
@@ -19,12 +19,11 @@
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/of_irq.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 
-#include <asm/mach/irq.h>
-
 #include "pinctrl-samsung.h"
 
 #define NUM_EINT	24
-- 
1.7.10.4
