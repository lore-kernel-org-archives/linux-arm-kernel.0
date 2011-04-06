From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Wed, 6 Apr 2011 21:26:06 +0400
Subject: [PATCH 2/3] DA8xx: kill duplicate #define DA8XX_PLL1_BASE
Message-ID: <201104062126.06877.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 044ca01521d077a35b46a445b02b93f413109a4b (davinci: da850/omap-l138: add
support for SoC suspend) introduced DA8XX_PLL1_BASE despite PLL1 exists only on
DA850/OMAP-L138 and da850.c even already #define'd DA850_PLL1_BASE. Kill the
duplicate macro, renaming an existing reference to it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent DaVinci tree.

 arch/arm/mach-davinci/da850.c              |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

Index: linux-davinci/arch/arm/mach-davinci/da850.c
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/da850.c
+++ linux-davinci/arch/arm/mach-davinci/da850.c
@@ -1055,7 +1055,7 @@ int da850_register_pm(struct platform_de
 	if (!pdata->cpupll_reg_base)
 		return -ENOMEM;
 
-	pdata->ddrpll_reg_base = ioremap(DA8XX_PLL1_BASE, SZ_4K);
+	pdata->ddrpll_reg_base = ioremap(DA850_PLL1_BASE, SZ_4K);
 	if (!pdata->ddrpll_reg_base) {
 		ret = -ENOMEM;
 		goto no_ddrpll_mem;
Index: linux-davinci/arch/arm/mach-davinci/include/mach/da8xx.h
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/include/mach/da8xx.h
+++ linux-davinci/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -65,7 +65,6 @@ extern unsigned int da850_max_speed;
 #define DA8XX_GPIO_BASE		0x01e26000
 #define DA8XX_PSC1_BASE		0x01e27000
 #define DA8XX_LCD_CNTRL_BASE	0x01e13000
-#define DA8XX_PLL1_BASE		0x01e1a000
 #define DA8XX_MMCSD0_BASE	0x01c40000
 #define DA8XX_AEMIF_CS2_BASE	0x60000000
 #define DA8XX_AEMIF_CS3_BASE	0x62000000
