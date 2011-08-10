From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Aug 2011 14:16:49 +0200
Subject: [PATCH 04/19] mach-ks8695: move GPIO driver to GPIO subsystem
Message-ID: <1312978609-18202-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

As per example from the other ARM boards, push the KS8695 GPIO
driver down to the GPIO subsystem so it can be consolidated.

Cc: zeal <zealcook@gmail.com>
Cc: Daniel Silverstone <dsilvers@simtec.co.uk>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ks8695/Makefile                      |    2 +-
 drivers/gpio/Makefile                              |    1 +
 .../gpio.c => drivers/gpio/gpio-ks8695.c           |    0
 3 files changed, 2 insertions(+), 1 deletions(-)
 rename arch/arm/mach-ks8695/gpio.c => drivers/gpio/gpio-ks8695.c (100%)

diff --git a/arch/arm/mach-ks8695/Makefile b/arch/arm/mach-ks8695/Makefile
index 7e3e816..853efd9 100644
--- a/arch/arm/mach-ks8695/Makefile
+++ b/arch/arm/mach-ks8695/Makefile
@@ -3,7 +3,7 @@
 # Makefile for KS8695 architecture support
 #
 
-obj-y				:= cpu.o irq.o time.o gpio.o devices.o
+obj-y				:= cpu.o irq.o time.o devices.o
 obj-m				:=
 obj-n				:=
 obj-				:=
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 9588948..27295cb 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_EXYNOS4)	+= gpio-exynos4.o
 obj-$(CONFIG_GPIO_IT8761E)	+= gpio-it8761e.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
+obj-$(CONFIG_MACH_KS8695)	+= gpio-ks8695.o
 obj-$(CONFIG_GPIO_LANGWELL)	+= gpio-langwell.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
diff --git a/arch/arm/mach-ks8695/gpio.c b/drivers/gpio/gpio-ks8695.c
similarity index 100%
rename from arch/arm/mach-ks8695/gpio.c
rename to drivers/gpio/gpio-ks8695.c
-- 
1.7.3.2
