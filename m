From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 9 Jan 2014 16:00:49 +0200
Subject: [PATCHv13 38/40] ARM: AM43xx: Enable clock init
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Message-ID: <1389276051-1326-39-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initializes clock data from device tree.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 44fc8cd..bbd2959 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -606,6 +606,7 @@ void __init am43xx_init_early(void)
 	am43xx_clockdomains_init();
 	am43xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_clk_soc_init = am43xx_dt_clk_init;
 }
 
 void __init am43xx_init_late(void)
-- 
1.7.9.5
