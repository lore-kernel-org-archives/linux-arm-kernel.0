From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 4 Jan 2013 11:09:23 +0100
Subject: [PATCH v2 2/2] ARM: OMAP4: hwmod_data: Correct IDLEMODE for McPDM
In-Reply-To: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com>
References: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1357294163-4317-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

McPDM need to be configured to NO_IDLE mode when it is in used otherwise
vital clocks will be gated which results 'slow motion' audio playback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 129d508..584acf9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2133,7 +2133,7 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	 * available, so it doesn't seem that we have any choice in
 	 * the kernel other than to avoid resetting it.
 	 */
-	.flags		= HWMOD_EXT_OPT_MAIN_CLK,
+	.flags		= HWMOD_EXT_OPT_MAIN_CLK | HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_mcpdm_irqs,
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
 	.main_clk	= "mcpdm_fck",
-- 
1.8.0.2
