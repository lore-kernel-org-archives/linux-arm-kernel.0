From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Oct 2012 21:40:20 +0200
Subject: [PATCH] gpio: clps711x: localise <mach/gpio.h> header
Message-ID: <1350330020-23240-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit adding the CLPS711x driver also added <mach/gpio.h>
to the CLPS711x, and we want to get rid of all <mach/*>
headers for the future. It turns out that the one macro defined
in the file was only used in the GPIO driver itself, so just
delete it and copy the macro into the driver.

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-clps711x/include/mach/gpio.h | 13 -------------
 drivers/gpio/gpio-clps711x.c               |  1 +
 2 files changed, 1 insertion(+), 13 deletions(-)
 delete mode 100644 arch/arm/mach-clps711x/include/mach/gpio.h

diff --git a/arch/arm/mach-clps711x/include/mach/gpio.h b/arch/arm/mach-clps711x/include/mach/gpio.h
deleted file mode 100644
index 8ac6889..0000000
--- a/arch/arm/mach-clps711x/include/mach/gpio.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- *  This file contains the CLPS711X GPIO definitions.
- *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-/* Simple helper for convert port & pin to GPIO number */
-#define CLPS711X_GPIO(port, bit)	((port) * 8 + (bit))
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index ea21822..604b8ba 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -20,6 +20,7 @@
 
 #define CLPS711X_GPIO_PORTS	5
 #define CLPS711X_GPIO_NAME	"gpio-clps711x"
+#define CLPS711X_GPIO(port, bit)	((port) * 8 + (bit))
 
 struct clps711x_gpio {
 	struct gpio_chip	chip[CLPS711X_GPIO_PORTS];
-- 
1.7.11.7
