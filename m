From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:18 +0900
Subject: [PATCH 02/21] ARM: shmobile: Remove obsolete sh-gpio.h
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <26449ecc21dd690f5bc686fbee8037587c77ac5e.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The last user of "sh-gpio.h" was removed in commit 1fa59bda21c7fa36
("ARM: shmobile: Remove legacy board code for Armadillo-800 EVA").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/sh-gpio.h | 29 -----------------------------
 1 file changed, 29 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/sh-gpio.h

diff --git a/arch/arm/mach-shmobile/sh-gpio.h b/arch/arm/mach-shmobile/sh-gpio.h
deleted file mode 100644
index 2c4141413db9..000000000000
--- a/arch/arm/mach-shmobile/sh-gpio.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Generic GPIO API and pinmux table support
- *
- * Copyright (c) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-
-/*
- * FIXME !!
- *
- * current gpio frame work doesn't have
- * the method to control only pull up/down/free.
- * this function should be replaced by correct gpio function
- */
-static inline void __init gpio_direction_none(void __iomem * addr)
-{
-	__raw_writeb(0x00, addr);
-}
-
-#endif /* __ASM_ARCH_GPIO_H */
-- 
2.1.4
