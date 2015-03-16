From: s-anna@ti.com (Suman Anna)
Date: Mon, 16 Mar 2015 15:54:54 -0500
Subject: [PATCH 2/2] ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4
In-Reply-To: <1426539294-28375-1-git-send-email-s-anna@ti.com>
References: <1426539294-28375-1-git-send-email-s-anna@ti.com>
Message-ID: <1426539294-28375-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPTimer 4 is a regular timer and not a secure timer, so fix
the hwmod to use the correct hwmod class (even though there
are no differences in the class definition itself).

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d0f03e73add4..2875d4bdb924 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1841,7 +1841,7 @@ static struct omap_hwmod dra7xx_timer3_hwmod = {
 /* timer4 */
 static struct omap_hwmod dra7xx_timer4_hwmod = {
 	.name		= "timer4",
-	.class		= &dra7xx_timer_secure_hwmod_class,
+	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.main_clk	= "timer4_gfclk_mux",
 	.prcm = {
-- 
2.3.2
