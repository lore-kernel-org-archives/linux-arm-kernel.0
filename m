From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 13:47:16 +0100
Subject: [PATCH] ARM: OMAP: make ti81xx_rtc_hwmod static
Message-ID: <1466513236-23528-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ti81xx_rtc_hwmod is not exported, or declared outside the file
arch/arm/mach-omap2/omap_hwmod_81xx_data.c so make it static to
avoid the following warning:

arch/arm/mach-omap2/omap_hwmod_81xx_data.c:246:19: warning: symbol 'ti81xx_rtc_hwmod' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index df83277..b82b77c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -243,7 +243,7 @@ static struct omap_hwmod_class ti81xx_rtc_hwmod_class = {
 	.sysc		= &ti81xx_rtc_sysc,
 };
 
-struct omap_hwmod ti81xx_rtc_hwmod = {
+static struct omap_hwmod ti81xx_rtc_hwmod = {
 	.name		= "rtc",
 	.class		= &ti81xx_rtc_hwmod_class,
 	.clkdm_name	= "alwon_l3s_clkdm",
-- 
2.8.1
