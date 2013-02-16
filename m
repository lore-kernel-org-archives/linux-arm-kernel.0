From: andrea.adami@gmail.com (Andrea Adami)
Date: Sat, 16 Feb 2013 19:16:00 +0100
Subject: [RFC] ARM: sa1100: collie-battery.c: include platform_device.h
 directly
Message-ID: <1361038560-3690-1-git-send-email-andrea.adami@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial try to fix compilation error

linux/include/linux/mfd/mcp.h:22:16: error: field 'attached_device' has incomplete type
linux/include/linux/mfd/mcp.h:48:23: error: field 'drv' has incomplete type
linux/include/linux/mfd/ucb1x00.h:137:17: error: field 'dev' has incomplete type
linux/drivers/power/collie_battery.c:290:56: error: unknown type name 'pm_message_t'
linux/drivers/power/collie_battery.c:371:13: error: 'collie_bat_suspend' undeclared here (not in a function)
| make[4]: *** [drivers/power/collie_battery.o] Error 1
| make[3]: *** [drivers/power] Error 2

As seen in Arnd Bergmann patches on LAKML
[PATCH 7/9] ARM defconfigs: add missing inclusions of linux/platform_device.h
[PATCH 1/9] ARM: sa1100/assabet: include platform_device.h directly

Compilation is still not clean, two warnings:
linux/drivers/power/collie_battery.c:372:2: warning: initialization from incompatible pointer type [enabled by default]
linux/drivers/power/collie_battery.c:372:2: warning: (near initialization for 'collie_bat_driver.suspend') [enabled by default]

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 drivers/power/collie_battery.c            |      1 +
 drivers/video/logo/logo_linux_clut224.ppm | 232006 ++++++++++++++++++++++++++-
 2 files changed, 230404 insertions(+), 1603 deletions(-)

diff --git a/drivers/power/collie_battery.c b/drivers/power/collie_battery.c
index c58d0e3..52cbab3 100644
--- a/drivers/power/collie_battery.c
+++ b/drivers/power/collie_battery.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/power_supply.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
-- 
1.7.12.4
