From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 29 Nov 2011 14:52:49 +0100
Subject: [PATCH] ARM: u300: delete memory.h
Message-ID: <1322574769-20453-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Last merge window the memory maps for U300 were simplified so
we can now safely delete memory.h.

Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                         |    2 +-
 arch/arm/mach-u300/include/mach/memory.h |   19 -------------------
 arch/arm/mach-u300/u300.c                |    2 +-
 3 files changed, 2 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/mach-u300/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..3ce67eb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -892,7 +892,7 @@ config ARCH_U300
 	select HAVE_MACH_CLKDEV
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
-	select NEED_MACH_MEMORY_H
+	select NO_MACH_MEMORY_H
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
diff --git a/arch/arm/mach-u300/include/mach/memory.h b/arch/arm/mach-u300/include/mach/memory.h
deleted file mode 100644
index c808f34..0000000
--- a/arch/arm/mach-u300/include/mach/memory.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- *
- * arch/arm/mach-u300/include/mach/memory.h
- *
- *
- * Copyright (C) 2007-2009 ST-Ericsson AB
- * License terms: GNU General Public License (GPL) version 2
- * Memory virtual/physical mapping constants.
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- * Author: Jonas Aaberg <jonas.aberg@stericsson.com>
- */
-
-#ifndef __MACH_MEMORY_H
-#define __MACH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET	UL(0x48000000)
-#define BOOT_PARAMS_OFFSET	0x100
-
-#endif
diff --git a/arch/arm/mach-u300/u300.c b/arch/arm/mach-u300/u300.c
index 89422ee..b200312 100644
--- a/arch/arm/mach-u300/u300.c
+++ b/arch/arm/mach-u300/u300.c
@@ -46,7 +46,7 @@ static void __init u300_init_machine(void)
 
 MACHINE_START(U300, MACH_U300_STRING)
 	/* Maintainer: Linus Walleij <linus.walleij@stericsson.com> */
-	.atag_offset	= BOOT_PARAMS_OFFSET,
+	.atag_offset	= 0x100,
 	.map_io		= u300_map_io,
 	.init_irq	= u300_init_irq,
 	.timer		= &u300_timer,
-- 
1.7.3.2
