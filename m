From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:11 -0700
Subject: [PATCH 07/46] davinci: DA8XX/OMAP-L1XX: It's SYSCFG not BOOT_CFG
In-Reply-To: <1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Rename the DA8XX_BOOT_CFG_BASE macro to get it in line
with the public documentation for these parts.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/da830.c              |    2 +-
 arch/arm/mach-davinci/da850.c              |    2 +-
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 19b2748..c2224b9 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1184,7 +1184,7 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.cpu_clks		= da830_clks,
 	.psc_bases		= da830_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(da830_psc_bases),
-	.pinmux_base		= IO_ADDRESS(DA8XX_BOOT_CFG_BASE + 0x120),
+	.pinmux_base		= IO_ADDRESS(DA8XX_SYSCFG_BASE + 0x120),
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
 	.intc_base		= (void __iomem *)DA8XX_CP_INTC_VIRT,
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 192d719..18c33b6 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -799,7 +799,7 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.cpu_clks		= da850_clks,
 	.psc_bases		= da850_psc_bases,
 	.psc_bases_num		= ARRAY_SIZE(da850_psc_bases),
-	.pinmux_base		= IO_ADDRESS(DA8XX_BOOT_CFG_BASE + 0x120),
+	.pinmux_base		= IO_ADDRESS(DA8XX_SYSCFG_BASE + 0x120),
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
 	.intc_base		= (void __iomem *)DA8XX_CP_INTC_VIRT,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 7576e8c..1c42379 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -29,7 +29,7 @@
 #define DA8XX_CP_INTC_SIZE	SZ_8K
 #define DA8XX_CP_INTC_VIRT	(IO_VIRT - DA8XX_CP_INTC_SIZE - SZ_4K)
 
-#define DA8XX_BOOT_CFG_BASE	(IO_PHYS + 0x14000)
+#define DA8XX_SYSCFG_BASE	(IO_PHYS + 0x14000)
 
 #define DA8XX_PSC0_BASE		0x01c10000
 #define DA8XX_PLL0_BASE		0x01c11000
-- 
1.6.4.3
