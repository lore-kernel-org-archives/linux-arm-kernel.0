From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Oct 2011 20:58:25 +0200
Subject: [PATCH] gpio: fix a build failure on KS8695 GPIO
Message-ID: <1319741905-11051-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@stericsson.com>

I screwed up by compiling that driver for the machine rather
than the arch. Correcting this fixes the build error.

Reported-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/gpio/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 19c5d27..f42309b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_EXYNOS4)	+= gpio-exynos4.o
 obj-$(CONFIG_GPIO_IT8761E)	+= gpio-it8761e.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
-obj-$(CONFIG_MACH_KS8695)	+= gpio-ks8695.o
+obj-$(CONFIG_ARCH_KS8695)	+= gpio-ks8695.o
 obj-$(CONFIG_GPIO_LANGWELL)	+= gpio-langwell.o
 obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
-- 
1.7.6.4
