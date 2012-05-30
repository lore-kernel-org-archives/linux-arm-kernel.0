From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 30 May 2012 16:26:31 +0530
Subject: [RFC PATCH 2/5] arm: omap: remove ocp2scp_usb_phy_ick clock node
In-Reply-To: <1338375394-16268-1-git-send-email-kishon@ti.com>
References: <1338375394-16268-1-git-send-email-kishon@ti.com>
Message-ID: <1338375394-16268-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ocp2scp_usb_phy_ick" clock node was a fake clock node created
to control MODULEMODE of ocp2scp. Since the hwmod for ocp2scp is now added
(which can be used to control MODULEMODE) this clock node is removed.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2172f66..3e2cccf 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2132,16 +2132,6 @@ static struct clk ocp2scp_usb_phy_phy_48m = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk ocp2scp_usb_phy_ick = {
-	.name		= "ocp2scp_usb_phy_ick",
-	.ops		= &clkops_omap2_dflt,
-	.enable_reg	= OMAP4430_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL,
-	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
-	.clkdm_name	= "l3_init_clkdm",
-	.parent		= &l4_div_ck,
-	.recalc		= &followparent_recalc,
-};
-
 static struct clk ocp_wp_noc_ick = {
 	.name		= "ocp_wp_noc_ick",
 	.ops		= &clkops_omap2_dflt,
@@ -3277,7 +3267,6 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"mmc4_fck",			&mmc4_fck,	CK_443X),
 	CLK(NULL,	"mmc5_fck",			&mmc5_fck,	CK_443X),
 	CLK(NULL,	"ocp2scp_usb_phy_phy_48m",	&ocp2scp_usb_phy_phy_48m,	CK_443X),
-	CLK(NULL,	"ocp2scp_usb_phy_ick",		&ocp2scp_usb_phy_ick,	CK_443X),
 	CLK(NULL,	"ocp_wp_noc_ick",		&ocp_wp_noc_ick,	CK_443X),
 	CLK("omap_rng",	"ick",				&rng_ick,	CK_443X),
 	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
-- 
1.7.5.4
