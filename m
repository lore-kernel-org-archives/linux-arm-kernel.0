From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  5 Mar 2015 13:11:19 +0100
Subject: [PATCH v2 2/9] ARM: at91: remove unused at91_ioremap_matrix and header
In-Reply-To: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425557486-3534-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91_ioremap_matrix and the at91_matrix.h header are not used anymore, remove
them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/generic.h                  |  4 ----
 arch/arm/mach-at91/include/mach/at91_matrix.h | 23 -----------------------
 arch/arm/mach-at91/setup.c                    | 10 ----------
 3 files changed, 37 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_matrix.h

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 583369ffc284..2b396c4e1fc1 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -25,10 +25,6 @@ extern void at91rm9200_timer_init(void);
 extern void at91rm9200_idle(void);
 extern void at91sam9_idle(void);
 
-/* Matrix */
-extern void at91_ioremap_matrix(u32 base_addr);
-
-
 #ifdef CONFIG_PM
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9260_pm_init(void);
diff --git a/arch/arm/mach-at91/include/mach/at91_matrix.h b/arch/arm/mach-at91/include/mach/at91_matrix.h
deleted file mode 100644
index f8996c954131..000000000000
--- a/arch/arm/mach-at91/include/mach/at91_matrix.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- *
- * Under GPLv2
- */
-
-#ifndef __MACH_AT91_MATRIX_H__
-#define __MACH_AT91_MATRIX_H__
-
-#ifndef __ASSEMBLY__
-extern void __iomem *at91_matrix_base;
-
-#define at91_matrix_read(field) \
-	__raw_readl(at91_matrix_base + field)
-
-#define at91_matrix_write(field, value) \
-	__raw_writel(value, at91_matrix_base + field)
-
-#else
-.extern at91_matrix_base
-#endif
-
-#endif /* __MACH_AT91_MATRIX_H__ */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 4e58bc90ed21..ef778f33c488 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -318,13 +318,3 @@ void __init at91_alt_map_io(void)
 		pr_info("AT91: Detected soc subtype: %s\n",
 			at91_get_soc_subtype(&at91_soc_initdata));
 }
-
-void __iomem *at91_matrix_base;
-EXPORT_SYMBOL_GPL(at91_matrix_base);
-
-void __init at91_ioremap_matrix(u32 base_addr)
-{
-	at91_matrix_base = ioremap(base_addr, 512);
-	if (!at91_matrix_base)
-		panic(pr_fmt("Impossible to ioremap at91_matrix_base\n"));
-}
-- 
2.1.0
