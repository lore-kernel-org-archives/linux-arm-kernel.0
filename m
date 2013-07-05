From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 5 Jul 2013 20:43:17 +0530
Subject: [PATCH 2/2] ARM: OMAP2+: hwmod: AM335x: fix cpgmac address space
In-Reply-To: <4bb04ee7bcb8ca73d5fc43049ba029471b9cdda3.1373036932.git.afzal@ti.com>
References: <4bb04ee7bcb8ca73d5fc43049ba029471b9cdda3.1373036932.git.afzal@ti.com>
Message-ID: <84d9a3ae9ab7a47924eb54934dcad91339543d63.1373036932.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register target address to be used for cpgmac is the second device
address space. By default, hwmod picks first address space (0th index)
for register target.

With removal of address space from hwmod and using DT instead, cpgmac
is getting wrong address space for register target.

Fix it by indicating the address space to be used for register target.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 28bbd56..7a9b492 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -562,6 +562,7 @@ static struct omap_hwmod am33xx_cpgmac0_hwmod = {
 	.clkdm_name	= "cpsw_125mhz_clkdm",
 	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
 	.main_clk	= "cpsw_125mhz_gclk",
+	.mpu_rt_idx	= 1,
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_CPGMAC0_CLKCTRL_OFFSET,
-- 
1.8.3.1
