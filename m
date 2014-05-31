From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 31 May 2014 10:01:35 +0400
Subject: [PATCH 3/3] ARM: i.MX: tzic: Cleanup driver
In-Reply-To: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
References: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
Message-ID: <1401516095-31020-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes unused #include.
No functional changes.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/tzic.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 534431e..6eb4afb 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -9,10 +9,6 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/irqdomain.h>
@@ -22,8 +18,6 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
-#include "common.h"
-#include "hardware.h"
 #include "irq-common.h"
 
 /*
@@ -72,8 +66,6 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 
 	return 0;
 }
-#else
-#define tzic_set_irq_fiq NULL
 #endif
 
 static void tzic_irq_suspend(struct irq_data *d)
-- 
1.8.5.5
