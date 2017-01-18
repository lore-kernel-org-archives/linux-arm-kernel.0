From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jan 2017 17:49:24 +0100
Subject: [PATCH] ARM: pxa: include linux/leds.h
Message-ID: <20170118164936.3832865-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the header is not included implicitly, we get a build failure:

arch/arm/mach-pxa/idp.c:205:22: error: field 'cdev' has incomplete type
  struct led_classdev     cdev;

This adds an explicit #include.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/idp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index d1db32b1a2c6..88e0068f92a8 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/leds.h>
 #include <linux/platform_device.h>
 #include <linux/fb.h>
 
-- 
2.9.0
