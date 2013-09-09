From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  9 Sep 2013 17:40:39 +0200
Subject: [PATCH 4/8] gpio: decouple the IOP GPIO driver from platform
Message-ID: <1378741239-12995-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the only dependence between the IOP GPIO
driver and the GENERIC_GPIO header in <mach/gpio.h>
and its common implementation in the <asm/*> namespace
by copying the one constant it is using into the driver
file.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-iop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-iop.c b/drivers/gpio/gpio-iop.c
index 697de6d..d4a170d 100644
--- a/drivers/gpio/gpio-iop.c
+++ b/drivers/gpio/gpio-iop.c
@@ -16,8 +16,8 @@
 #include <linux/errno.h>
 #include <linux/gpio.h>
 #include <linux/export.h>
-#include <asm/hardware/iop3xx.h>
-#include <mach/gpio.h>
+
+#define IOP3XX_N_GPIOS	8
 
 void gpio_line_config(int line, int direction)
 {
-- 
1.8.3.1
