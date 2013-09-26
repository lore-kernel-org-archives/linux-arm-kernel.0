From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Sep 2013 10:11:17 +0200
Subject: [PATCH 2/2] ARM: pxa: delete the custom GPIO header
Message-ID: <1380183077-27407-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA sub-architecture appears to have a custom <mach/gpio.h>
for no reason whatsoever. The file became completely empty
after Haojian removed the remaining content in
commit 157d2644cb0c1e71a18baaffca56d2b1d0ebf10f
"ARM: pxa: change gpio to platform device".

That commit added these two lines:

However it seems like deleting the file has no effect
whatsoever on the kernel compilation.

Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Haojian et al, I'm seeking an ACK for this patch so I can take it
through the GPIO tree.
---
 arch/arm/Kconfig                      |  1 -
 arch/arm/mach-pxa/include/mach/gpio.h | 32 --------------------------------
 2 files changed, 33 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3950a12..1ced444 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -621,7 +621,6 @@ config ARCH_PXA
 	select GPIO_PXA
 	select HAVE_IDE
 	select MULTI_IRQ_HANDLER
-	select NEED_MACH_GPIO_H
 	select PLAT_PXA
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
deleted file mode 100644
index 0248e43..0000000
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * arch/arm/mach-pxa/include/mach/gpio.h
- *
- * PXA GPIO wrappers for arch-neutral GPIO calls
- *
- * Written by Philipp Zabel <philipp.zabel@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#ifndef __ASM_ARCH_PXA_GPIO_H
-#define __ASM_ARCH_PXA_GPIO_H
-
-#include <asm-generic/gpio.h>
-
-#include <mach/irqs.h>
-#include <mach/hardware.h>
-
-#endif
-- 
1.8.3.1
