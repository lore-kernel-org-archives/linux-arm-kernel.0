From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Sep 2013 10:11:00 +0200
Subject: [PATCH 1/2] ARM: mmp: delete the custom GPIO header
Message-ID: <1380183060-27366-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMP sub-architecture appears to have a custom <mach/gpio.h>
for no reason whatsoever. The file became completely empty
after Haojian removed the remaining content in
commit 157d2644cb0c1e71a18baaffca56d2b1d0ebf10f
"ARM: pxa: change gpio to platform device".

Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Haojian, I'm seeking an ACK for this patch so I can take it
through the GPIO tree.
---
 arch/arm/Kconfig                      | 1 -
 arch/arm/mach-mmp/include/mach/gpio.h | 8 --------
 2 files changed, 9 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f7714d..3950a12 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -559,7 +559,6 @@ config ARCH_MMP
 	select GPIO_PXA
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
-	select NEED_MACH_GPIO_H
 	select PINCTRL
 	select PLAT_PXA
 	select SPARSE_IRQ
diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
deleted file mode 100644
index 13219eb..0000000
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef __ASM_MACH_GPIO_H
-#define __ASM_MACH_GPIO_H
-
-#include <asm-generic/gpio.h>
-
-#include <mach/cputype.h>
-
-#endif /* __ASM_MACH_GPIO_H */
-- 
1.8.3.1
