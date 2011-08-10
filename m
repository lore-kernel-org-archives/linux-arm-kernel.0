From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 10 Aug 2011 14:18:25 +0200
Subject: [PATCH 16/19] mach-pnx4008: move PNX4008 GPIO driver to GPIO subsystem
Message-ID: <1312978705-18605-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

As per example from the other ARM boards, push the PNX4008
GPIO driver down to the GPIO subsystem so it can be consolidated.

Cc: Vitaly Wool <vitalywool@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-pnx4008/Makefile                     |    2 +-
 drivers/gpio/Makefile                              |    1 +
 .../gpio.c => drivers/gpio/gpio-pnx4008.c          |    0
 3 files changed, 2 insertions(+), 1 deletions(-)
 rename arch/arm/mach-pnx4008/gpio.c => drivers/gpio/gpio-pnx4008.c (100%)

diff --git a/arch/arm/mach-pnx4008/Makefile b/arch/arm/mach-pnx4008/Makefile
index 777564c..5e2e211 100644
--- a/arch/arm/mach-pnx4008/Makefile
+++ b/arch/arm/mach-pnx4008/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y			:= core.o irq.o time.o clock.o gpio.o serial.o dma.o i2c.o
+obj-y			:= core.o irq.o time.o clock.o serial.o dma.o i2c.o
 obj-m			:=
 obj-n			:=
 obj-			:=
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 6640e1d..7f846bf 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
 obj-$(CONFIG_GPIO_PCH)		+= gpio-pch.o
 obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
+obj-$(CONFIG_ARCH_PNX4008)	+= gpio-pnx4008.o
 obj-$(CONFIG_PLAT_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 
diff --git a/arch/arm/mach-pnx4008/gpio.c b/drivers/gpio/gpio-pnx4008.c
similarity index 100%
rename from arch/arm/mach-pnx4008/gpio.c
rename to drivers/gpio/gpio-pnx4008.c
-- 
1.7.3.2
