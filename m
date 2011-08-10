From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Aug 2011 14:17:04 +0200
Subject: [PATCH 06/19] mach-ks8695: fix GPIO LEDs
Message-ID: <1312978624-18273-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Enabling the LEDs on the ks8695 doesn't even compile, fix it with
a proper include and also replace a <mach/gpio.h> with the proper
<linux/gpio.h>.

Cc: zeal <zealcook@gmail.com>
Cc: Daniel Silverstone <dsilvers@simtec.co.uk>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ks8695/devices.c |    1 +
 arch/arm/mach-ks8695/leds.c    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ks8695/devices.c b/arch/arm/mach-ks8695/devices.c
index b89fb6d..73bd638 100644
--- a/arch/arm/mach-ks8695/devices.c
+++ b/arch/arm/mach-ks8695/devices.c
@@ -20,6 +20,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-ks8695/leds.c b/arch/arm/mach-ks8695/leds.c
index 4bd7075..d6f6502 100644
--- a/arch/arm/mach-ks8695/leds.c
+++ b/arch/arm/mach-ks8695/leds.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/gpio.h>
 
 #include <asm/leds.h>
 #include <mach/devices.h>
-- 
1.7.3.2
