From: a.heider@gmail.com (Andre Heider)
Date: Sun, 29 Jun 2014 18:21:40 +0200
Subject: [PATCH 06/13] ARM: AM33XX: hwmod: deassert PRUSS' hardreset lines
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Message-ID: <1404058907-21112-7-git-send-email-a.heider@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set HWMOD_INIT_DEASSERT_HARD_RESET to get the PRUSS out of hardreset
upon boot.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index a579b89..f1c31f7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -153,6 +153,7 @@ struct omap_hwmod am33xx_pruss_hwmod = {
 	.name		= "pruss",
 	.class		= &am33xx_pruss_hwmod_class,
 	.clkdm_name	= "pruss_ocp_clkdm",
+	.flags		= HWMOD_INIT_DEASSERT_HARD_RESET,
 	.main_clk	= "pruss_ocp_gclk",
 	.prcm		= {
 		.omap4	= {
-- 
2.0.0
