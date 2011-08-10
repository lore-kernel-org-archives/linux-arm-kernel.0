From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Aug 2011 14:17:11 +0200
Subject: [PATCH 07/19] mach-davinci: move GPIO driver to GPIO subsystem
Message-ID: <1312978631-18306-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

As per example from the other ARM boards, push the DaVinci GPIO
driver down to the GPIO subsystem so it can be consolidated.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/Makefile                     |    2 +-
 drivers/gpio/Makefile                              |    1 +
 .../gpio.c => drivers/gpio/gpio-davinci.c          |    0
 3 files changed, 2 insertions(+), 1 deletions(-)
 rename arch/arm/mach-davinci/gpio.c => drivers/gpio/gpio-davinci.c (100%)

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 0b87a1c..8f3c8ee 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -5,7 +5,7 @@
 
 # Common objects
 obj-y 			:= time.o clock.o serial.o io.o psc.o \
-			   gpio.o dma.o usb.o common.o sram.o aemif.o
+			   dma.o usb.o common.o sram.o aemif.o
 
 obj-$(CONFIG_DAVINCI_MUX)		+= mux.o
 
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 27295cb..a26fffa 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_GPIO_ADP5588)	+= gpio-adp5588.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_DA9052)	+= gpio-da9052.o
+obj-$(CONFIG_ARCH_DAVINCI)	+= gpio-davinci.o
 obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_EXYNOS4)	+= gpio-exynos4.o
 obj-$(CONFIG_GPIO_IT8761E)	+= gpio-it8761e.o
diff --git a/arch/arm/mach-davinci/gpio.c b/drivers/gpio/gpio-davinci.c
similarity index 100%
rename from arch/arm/mach-davinci/gpio.c
rename to drivers/gpio/gpio-davinci.c
-- 
1.7.3.2
