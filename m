From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 May 2017 23:57:25 +0200
Subject: [PATCH 1/3] gpio: max732x: move header file out of I2C realm
In-Reply-To: <20170521215727.1243-1-wsa@the-dreams.de>
References: <20170521215727.1243-1-wsa@the-dreams.de>
Message-ID: <20170521215727.1243-2-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/mach-pxa/littleton.c                  | 2 +-
 drivers/gpio/gpio-max732x.c                    | 2 +-
 include/linux/{i2c => platform_data}/max732x.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{i2c => platform_data}/max732x.h (100%)

diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 051c554776a6e7..fae38fdc8d8e56 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -27,7 +27,7 @@
 #include <linux/i2c.h>
 #include <linux/leds.h>
 #include <linux/mfd/da903x.h>
-#include <linux/i2c/max732x.h>
+#include <linux/platform_data/max732x.h>
 #include <linux/i2c/pxa-i2c.h>
 
 #include <asm/types.h>
diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 4ea4c6a1313b13..7f4d26ce5f231a 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -20,7 +20,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/i2c/max732x.h>
+#include <linux/platform_data/max732x.h>
 #include <linux/of.h>
 
 
diff --git a/include/linux/i2c/max732x.h b/include/linux/platform_data/max732x.h
similarity index 100%
rename from include/linux/i2c/max732x.h
rename to include/linux/platform_data/max732x.h
-- 
2.11.0
