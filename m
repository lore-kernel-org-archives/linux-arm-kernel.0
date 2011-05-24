From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 24 May 2011 23:06:52 +0200
Subject: [PATCH 1/4] gpio: move U300 GPIO driver to drivers/gpio
Message-ID: <1306271212-28945-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This moves the U300 GPIO driver out of arch/arm/mach-u300 and into
the desired location indicated by the subsystem maintainer.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u300/Makefile                        |    2 +-
 drivers/gpio/Makefile                              |    1 +
 .../mach-u300/gpio.c => drivers/gpio/gpio-u300.c   |    0
 3 files changed, 2 insertions(+), 1 deletions(-)
 rename arch/arm/mach-u300/gpio.c => drivers/gpio/gpio-u300.c (100%)

diff --git a/arch/arm/mach-u300/Makefile b/arch/arm/mach-u300/Makefile
index fab46fe..8fd354a 100644
--- a/arch/arm/mach-u300/Makefile
+++ b/arch/arm/mach-u300/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel, U300 machine.
 #
 
-obj-y		:= core.o clock.o timer.o gpio.o padmux.o
+obj-y		:= core.o clock.o timer.o padmux.o
 obj-m		:=
 obj-n		:=
 obj-		:=
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index becef59..7245d7d 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_GPIO_WM831X)	+= wm831x-gpio.o
 obj-$(CONFIG_GPIO_WM8350)	+= wm8350-gpiolib.o
 obj-$(CONFIG_GPIO_WM8994)	+= wm8994-gpio.o
 obj-$(CONFIG_GPIO_SCH)		+= sch_gpio.o
+obj-$(CONFIG_MACH_U300)		+= gpio-u300.o
 obj-$(CONFIG_GPIO_RDC321X)	+= rdc321x-gpio.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= janz-ttl.o
 obj-$(CONFIG_GPIO_SX150X)	+= sx150x.o
diff --git a/arch/arm/mach-u300/gpio.c b/drivers/gpio/gpio-u300.c
similarity index 100%
rename from arch/arm/mach-u300/gpio.c
rename to drivers/gpio/gpio-u300.c
-- 
1.7.3.2
