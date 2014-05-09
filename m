From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 9 May 2014 11:10:05 +0300
Subject: [PATCH v2] ARM: omap5: hwmod_data: Correct IDLEMODE for McPDM
In-Reply-To: <alpine.DEB.2.02.1405081602220.23579@utopia.booyaka.com>
References: <alpine.DEB.2.02.1405081602220.23579@utopia.booyaka.com>
Message-ID: <1399623005-30581-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

McPDM need to be configured to NO_IDLE mode when it is in used otherwise
vital clocks will be gated which results 'slow motion' audio playback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Paul,

Changes since v1:
- updated the commit message

If this can still make it to 3.15, that would be great.

Regards,
Peter

 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 892317294fdc..e829664e6a6c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -895,7 +895,7 @@ static struct omap_hwmod omap54xx_mcpdm_hwmod = {
 	 * current exception.
 	 */
 
-	.flags		= HWMOD_EXT_OPT_MAIN_CLK,
+	.flags		= HWMOD_EXT_OPT_MAIN_CLK | HWMOD_SWSUP_SIDLE,
 	.main_clk	= "pad_clks_ck",
 	.prcm = {
 		.omap4 = {
-- 
1.9.2
