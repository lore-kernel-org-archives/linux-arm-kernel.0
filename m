From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jan 2015 15:13:57 -0800
Subject: [PATCH 7/7] ARM: OMAP2+: Disable omap3 PM init for ti81xx
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Message-ID: <1421190837-4692-8-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We cannot use the omap3 pm support on 81xx.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b957776..e4a5630 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -568,7 +568,6 @@ void __init am35xx_init_late(void)
 void __init ti81xx_init_late(void)
 {
 	omap_common_late_init();
-	omap3_pm_init();
 	omap2_clk_enable_autoidle_all();
 }
 #endif
-- 
2.1.4
