From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:51 +0000
Subject: [PATCH 10/12] ARM: S3C24XX: Fix warnings in
	arch/arm/plat-s3c24xx/gpio.c
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1256732153-22027-10-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warnings from sparse in arch/arm/plat-s3c24xx/gpio.
due to the missing include of <mach/gpio-fns.h>

gpio.c:36:6: warning: symbol 's3c2410_gpio_cfgpin' was not declared. Should it be static?
gpio.c:84:14: warning: symbol 's3c2410_gpio_getcfg' was not declared. Should it be static?
gpio.c:103:6: warning: symbol 's3c2410_gpio_pullup' was not declared. Should it be static?
gpio.c:125:5: warning: symbol 's3c2410_gpio_getpull' was not declared. Should it be static?
gpio.c:138:6: warning: symbol 's3c2410_gpio_setpin' was not declared. Should it be static?
gpio.c:157:14: warning: symbol 's3c2410_gpio_getpin' was not declared. Should it be static?
gpio.c:184:5: warning: symbol 's3c2410_gpio_getirq' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c24xx/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/gpio.c b/arch/arm/plat-s3c24xx/gpio.c
index 95df059..5467470 100644
--- a/arch/arm/plat-s3c24xx/gpio.c
+++ b/arch/arm/plat-s3c24xx/gpio.c
@@ -29,6 +29,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/gpio-fns.h>
 #include <asm/irq.h>
 
 #include <mach/regs-gpio.h>
-- 
1.6.3.3
