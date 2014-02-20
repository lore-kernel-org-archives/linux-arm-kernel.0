From: rogerq@ti.com (Roger Quadros)
Date: Thu, 20 Feb 2014 13:40:02 +0200
Subject: [PATCH v8 07/14] ARM: OMAP3: hwmod data: Remove optional clock from
 usb_host_hs module
In-Reply-To: <1392896409-5101-1-git-send-email-rogerq@ti.com>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com>
Message-ID: <1392896409-5101-8-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USB Host driver manages this clock so no need to have it in
the hwmod data. We also get rid of the 'ehci_logic_fck' alias
for 'usbhost_120m_fck' clock.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 4c3b1e6..ad87f46 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1955,10 +1955,6 @@ static struct omap_hwmod_class omap3xxx_usb_host_hs_hwmod_class = {
 	.sysc = &omap3xxx_usb_host_hs_sysc,
 };
 
-static struct omap_hwmod_opt_clk omap3xxx_usb_host_hs_opt_clks[] = {
-	  { .role = "ehci_logic_fck", .clk = "usbhost_120m_fck", },
-};
-
 static struct omap_hwmod_irq_info omap3xxx_usb_host_hs_irqs[] = {
 	{ .name = "ohci-irq", .irq = 76 + OMAP_INTC_START, },
 	{ .name = "ehci-irq", .irq = 77 + OMAP_INTC_START, },
@@ -1981,8 +1977,6 @@ static struct omap_hwmod omap3xxx_usb_host_hs_hwmod = {
 			.idlest_stdby_bit = OMAP3430ES2_ST_USBHOST_STDBY_SHIFT,
 		},
 	},
-	.opt_clks	= omap3xxx_usb_host_hs_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(omap3xxx_usb_host_hs_opt_clks),
 
 	/*
 	 * Errata: USBHOST Configured In Smart-Idle Can Lead To a Deadlock
-- 
1.8.3.2
