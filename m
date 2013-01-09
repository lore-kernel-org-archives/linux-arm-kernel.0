From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Wed, 9 Jan 2013 16:03:10 +0100
Subject: [PATCH v2 4/5] OMAP4: hwmod data: Enable AESS hwmod device
In-Reply-To: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
References: <1357743792-13917-1-git-send-email-s-guiriec@ti.com>
Message-ID: <1357743792-13917-5-git-send-email-s-guiriec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable AESS data in hwmod in order to be able to probe
audio driver.

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 13e397f..6d22fd0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -6279,7 +6279,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l3_main_1__l3_main_3,
 	&omap44xx_l3_main_2__l3_main_3,
 	&omap44xx_l4_cfg__l3_main_3,
-	/* &omap44xx_aess__l4_abe, */
+	&omap44xx_aess__l4_abe,
 	&omap44xx_dsp__l4_abe,
 	&omap44xx_l3_main_1__l4_abe,
 	&omap44xx_mpu__l4_abe,
@@ -6288,8 +6288,8 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_cfg__l4_wkup,
 	&omap44xx_mpu__mpu_private,
 	&omap44xx_l4_cfg__ocp_wp_noc,
-	/* &omap44xx_l4_abe__aess, */
-	/* &omap44xx_l4_abe__aess_dma, */
+	&omap44xx_l4_abe__aess,
+	&omap44xx_l4_abe__aess_dma,
 	&omap44xx_l3_main_2__c2c,
 	&omap44xx_l4_wkup__counter_32k,
 	&omap44xx_l4_cfg__ctrl_module_core,
-- 
1.7.10.4
