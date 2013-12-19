From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 19 Dec 2013 13:24:17 +0200
Subject: [PATCHv11 46/49] ARM: OMAP: DRA7: Enable clock init
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Message-ID: <1387452260-23276-47-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initializes clock data from device tree.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5854677..628a7f5 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -692,6 +692,7 @@ void __init dra7xx_init_early(void)
 	dra7xx_clockdomains_init();
 	dra7xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_clk_soc_init = dra7xx_dt_clk_init;
 }
 
 void __init dra7xx_init_late(void)
-- 
1.7.9.5
