From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 28 Jun 2016 18:25:10 +0900
Subject: [PATCH] ARM: uniphier: remove empty DT machine descriptor
Message-ID: <1467105910-5081-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the initial support of mach-uniphier, this has always been
just empty.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/Makefile   |  1 -
 arch/arm/mach-uniphier/uniphier.c | 30 ------------------------------
 2 files changed, 31 deletions(-)
 delete mode 100644 arch/arm/mach-uniphier/uniphier.c

diff --git a/arch/arm/mach-uniphier/Makefile b/arch/arm/mach-uniphier/Makefile
index 1233f9b..396afe1 100644
--- a/arch/arm/mach-uniphier/Makefile
+++ b/arch/arm/mach-uniphier/Makefile
@@ -1,2 +1 @@
-obj-y			:= uniphier.o
 obj-$(CONFIG_SMP)	+= platsmp.o headsmp.o
diff --git a/arch/arm/mach-uniphier/uniphier.c b/arch/arm/mach-uniphier/uniphier.c
deleted file mode 100644
index 9be10ef..0000000
--- a/arch/arm/mach-uniphier/uniphier.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <asm/mach/arch.h>
-
-static const char * const uniphier_dt_compat[] __initconst = {
-	"socionext,ph1-sld3",
-	"socionext,ph1-ld4",
-	"socionext,ph1-pro4",
-	"socionext,ph1-sld8",
-	"socionext,ph1-pro5",
-	"socionext,proxstream2",
-	"socionext,ph1-ld6b",
-	NULL,
-};
-
-DT_MACHINE_START(UNIPHIER, "Socionext UniPhier")
-	.dt_compat	= uniphier_dt_compat,
-MACHINE_END
-- 
1.9.1
