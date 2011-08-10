From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Aug 2011 14:18:33 +0200
Subject: [PATCH 17/19] mach-pnx4008: rename GPIO header
Message-ID: <1312978714-18638-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The PNX4008 header file is using the generic gpio and gpiolib
namespace in <mach/gpio.h> yet the GPIO interface is not generic
at all so rename it to <mach/gpio-pnx4008.h>

Cc: Vitaly Wool <vitalywool@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../include/mach/{gpio.h => gpio-pnx4008.h}        |    0
 arch/arm/mach-pnx4008/serial.c                     |    2 +-
 drivers/gpio/gpio-pnx4008.c                        |    2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-pnx4008/include/mach/{gpio.h => gpio-pnx4008.h} (100%)

diff --git a/arch/arm/mach-pnx4008/include/mach/gpio.h b/arch/arm/mach-pnx4008/include/mach/gpio-pnx4008.h
similarity index 100%
rename from arch/arm/mach-pnx4008/include/mach/gpio.h
rename to arch/arm/mach-pnx4008/include/mach/gpio-pnx4008.h
diff --git a/arch/arm/mach-pnx4008/serial.c b/arch/arm/mach-pnx4008/serial.c
index eb29fac..374c138 100644
--- a/arch/arm/mach-pnx4008/serial.c
+++ b/arch/arm/mach-pnx4008/serial.c
@@ -9,7 +9,6 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/io.h>
@@ -20,6 +19,7 @@
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 
+#include <mach/gpio-pnx4008.h>
 #include <mach/clock.h>
 
 #define UART_3		0
diff --git a/drivers/gpio/gpio-pnx4008.c b/drivers/gpio/gpio-pnx4008.c
index eef531b..d3e71d3 100644
--- a/drivers/gpio/gpio-pnx4008.c
+++ b/drivers/gpio/gpio-pnx4008.c
@@ -13,13 +13,13 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/gpio.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
+#include <mach/gpio-pnx4008.h>
 
 /* register definitions */
 #define PIO_VA_BASE	IO_ADDRESS(PNX4008_PIO_BASE)
-- 
1.7.3.2
