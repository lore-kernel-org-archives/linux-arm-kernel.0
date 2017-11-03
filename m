From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 3 Nov 2017 16:26:41 +0200
Subject: [PATCH 7/7] ARM: DM816x: hwmod_data: fix clockdomain name for sata
 hwmod
In-Reply-To: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
References: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
Message-ID: <1509719201-32700-8-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"default_sata_clkdm" does not exist, instead replace this with the
correct clockdomain name which is just "default_clkdm".

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 310afe4..95f1222 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -988,7 +988,7 @@
 
 static struct omap_hwmod dm81xx_sata_hwmod = {
 	.name		= "sata",
-	.clkdm_name	= "default_sata_clkdm",
+	.clkdm_name	= "default_clkdm",
 	.flags		= HWMOD_NO_IDLEST,
 	.prcm = {
 		.omap4 = {
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
