From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Oct 2012 22:34:25 +0200
Subject: [PATCH] gpio: clps711x: delete local <mach/gpio.h> header
Message-ID: <1350333265-23760-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This header file is unused and we shall not add new headers
to the <mach/*> namespace. The macro may be reintroduced when
there is a user for it.

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-clps711x/include/mach/gpio.h | 13 -------------
 1 file changed, 13 deletions(-)
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
-- 
1.7.11.7
