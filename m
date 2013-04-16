From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 17 Apr 2013 00:23:59 +0200
Subject: [PATCH 1/2] pinctrl: s3c64xx: Fix build error caused by undefined
 chained_irq_enter
In-Reply-To: <20130416163331.GP26958@opensource.wolfsonmicro.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <20130416163331.GP26958@opensource.wolfsonmicro.com>
Message-ID: <30362001.FF4K7WsZvh@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit de88cbb7 moved definitions of chained_irq_enter and
chained_irq_exit to a generic header, which must be now included instead
of the legacy arch-specific one.

This patch fixes build error caused by including the legacy header
leading to undefined chained_irq_enter and chained_irq_exit symbols.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/pinctrl-s3c64xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-s3c64xx.c b/drivers/pinctrl/pinctrl-s3c64xx.c
index b5d1c4a..89143c9 100644
--- a/drivers/pinctrl/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/pinctrl-s3c64xx.c
@@ -22,11 +22,10 @@
 #include <linux/irq.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 
-#include <asm/mach/irq.h>
-
 #include "pinctrl-samsung.h"
 
 #define NUM_EINT0		28
-- 
1.8.1.5
