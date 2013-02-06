From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 6 Feb 2013 11:28:09 +0530
Subject: [PATCH 1/5] ARM: OMAP4: remove control module address space from PHY
 and OTG
In-Reply-To: <1360130294-5976-1-git-send-email-kishon@ti.com>
References: <1360130294-5976-1-git-send-email-kishon@ti.com>
Message-ID: <1360130294-5976-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a separate driver for the control module,
stop populating the control module device data in other modules
(PHY and OTG) device info.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 793f54a..624a7e8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2702,13 +2702,6 @@ static struct resource omap44xx_usb_phy_and_pll_addrs[] = {
 		.end		= 0x4a0ae000,
 		.flags		= IORESOURCE_MEM,
 	},
-	{
-		/* XXX: Remove this once control module driver is in place */
-		.name		= "ctrl_dev",
-		.start		= 0x4a002300,
-		.end		= 0x4a002303,
-		.flags		= IORESOURCE_MEM,
-	},
 	{ }
 };
 
@@ -6156,12 +6149,6 @@ static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
 		.pa_end		= 0x4a0ab7ff,
 		.flags		= ADDR_TYPE_RT
 	},
-	{
-		/* XXX: Remove this once control module driver is in place */
-		.pa_start	= 0x4a00233c,
-		.pa_end		= 0x4a00233f,
-		.flags		= ADDR_TYPE_RT
-	},
 	{ }
 };
 
-- 
1.7.10.4
