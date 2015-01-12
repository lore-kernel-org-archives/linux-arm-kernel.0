From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Jan 2015 19:42:16 +0100
Subject: [PATCH 7/7] ARM: at91: remove useless at91rm9200_set_type()
In-Reply-To: <1421088136-10172-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421088136-10172-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421088136-10172-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since all rm9200 board files have been removed, there is no user of
at91rm9200_set_type() left. Remove it

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/generic.h |  1 -
 arch/arm/mach-at91/setup.c   | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index c10c2ddaae6d..54f3837a0a4d 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -21,7 +21,6 @@ extern void __init at91_init_sram(int bank, unsigned long base,
 				  unsigned int length);
 
  /* Processors */
-extern void __init at91rm9200_set_type(int type);
 extern void __init at91_dt_initialize(void);
 
  /* Timer */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index acb8d7724609..e3c21b458bb8 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -31,17 +31,6 @@ struct at91_init_soc __initdata at91_boot_soc;
 struct at91_socinfo at91_soc_initdata;
 EXPORT_SYMBOL(at91_soc_initdata);
 
-void __init at91rm9200_set_type(int type)
-{
-	if (type == ARCH_REVISON_9200_PQFP)
-		at91_soc_initdata.subtype = AT91_SOC_RM9200_PQFP;
-	else
-		at91_soc_initdata.subtype = AT91_SOC_RM9200_BGA;
-
-	pr_info("filled in soc subtype: %s\n",
-		at91_get_soc_subtype(&at91_soc_initdata));
-}
-
 void __iomem *at91_ramc_base[2];
 EXPORT_SYMBOL_GPL(at91_ramc_base);
 
-- 
2.1.0
