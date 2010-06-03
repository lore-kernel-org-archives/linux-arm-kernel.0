From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu,  3 Jun 2010 03:44:00 +0200
Subject: [PATCH] pxa/z2: Fix includes in battery driver
Message-ID: <1275529440-31121-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove redundant includes and add slab.h to fix problem with building.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/power/z2_battery.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/power/z2_battery.c b/drivers/power/z2_battery.c
index 9cca465..85064a9 100644
--- a/drivers/power/z2_battery.c
+++ b/drivers/power/z2_battery.c
@@ -9,19 +9,13 @@
  *
  */
 
-#include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/power_supply.h>
-#include <linux/i2c.h>
-#include <linux/spinlock.h>
-#include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <asm/irq.h>
-#include <asm/mach/irq.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
 #include <linux/z2_battery.h>
 
 #define	Z2_DEFAULT_NAME	"Z2"
-- 
1.7.0
