From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 15 Jan 2012 00:33:25 +0100
Subject: [PATCH] ARM: Fix regression caused by ARCH_NR_GPIOS removal
Message-ID: <201201150033.25885.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit 3dea19e826da3dd43b3dc308aca299c0b7263c6b (ARM: 7244/1:
mach-shmobile: Use CONFIG_ARCH_NR_GPIO) removed ARCH_NR_GPIOS
and introduced ARCH_NR_GPIO instead without changing the users
of that symbol.  As a result, the kernels including that commit
don't boot on my test-bed Mackerel board.

Fix the problem by defining ARCH_NR_GPIOS again.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/include/asm/gpio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/arm/include/asm/gpio.h
===================================================================
--- linux.orig/arch/arm/include/asm/gpio.h
+++ linux/arch/arm/include/asm/gpio.h
@@ -2,7 +2,7 @@
 #define _ARCH_ARM_GPIO_H
 
 #if CONFIG_ARCH_NR_GPIO > 0
-#define ARCH_NR_GPIO CONFIG_ARCH_NR_GPIO
+#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
 #endif
 
 /* not all ARM platforms necessarily support this API ... */
