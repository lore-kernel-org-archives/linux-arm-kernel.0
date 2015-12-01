From: tony@atomide.com (Tony Lindgren)
Date: Tue,  1 Dec 2015 15:38:19 -0800
Subject: [PATCH 06/10] ARM: OMAP2+: Remove useless check for legacy booting
 for dm814x
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Message-ID: <1449013103-23238-7-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have never had dm814x booting properly with mainline kernel using
the legacy platform data based booting. Current minimal support is
device tree only.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3eaeaca..3c87e40 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -612,8 +612,7 @@ void __init ti814x_init_early(void)
 	ti814x_clockdomains_init();
 	dm814x_hwmod_init();
 	omap_hwmod_init_postsetup();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = dm814x_dt_clk_init;
+	omap_clk_soc_init = dm814x_dt_clk_init;
 }
 
 void __init ti816x_init_early(void)
-- 
2.6.2
