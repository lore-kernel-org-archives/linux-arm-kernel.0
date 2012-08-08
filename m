From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 14:54:52 +0200
Subject: [PATCH 5/6] ARM: integrator: include <linux/export.h
In-Reply-To: <1344430493-5304-1-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
Message-ID: <1344430493-5304-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch, building integrator_defconfig results in:

arch/arm/mach-integrator/core.c:150:1: warning: data definition has no type or storage class [enabled by default]
arch/arm/mach-integrator/core.c:150:1: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL' [-Wimplicit-int]
arch/arm/mach-integrator/core.c:150:1: warning: parameter names (without types) in function declaration [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-integrator/core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index ebf680b..3fa6c51 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-- 
1.7.10
