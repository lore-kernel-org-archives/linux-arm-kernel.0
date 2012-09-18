From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 Sep 2012 15:12:48 -0600
Subject: [PATCH 1/3] ARM: OMAP4: hwmod data: add missing HWMOD_NO_IDLEST
 flags to some PRCM IP blocks
In-Reply-To: <20120918211146.16484.85893.stgit@dusk.lan>
References: <20120918211146.16484.85893.stgit@dusk.lan>
Message-ID: <20120918211245.16484.14543.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some struct omap_hwmod records belonging to PRCM IP blocks are missing
HWMOD_NO_IDLEST flags; add them.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index afb6091..f54b3e5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2537,18 +2537,21 @@ static struct omap_hwmod omap44xx_prcm_mpu_hwmod = {
 	.name		= "prcm_mpu",
 	.class		= &omap44xx_prcm_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* cm_core_aon */
 static struct omap_hwmod omap44xx_cm_core_aon_hwmod = {
 	.name		= "cm_core_aon",
 	.class		= &omap44xx_prcm_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* cm_core */
 static struct omap_hwmod omap44xx_cm_core_hwmod = {
 	.name		= "cm_core",
 	.class		= &omap44xx_prcm_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* prm */
