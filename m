From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 25 Sep 2013 11:48:28 +0300
Subject: [PATCHv7 22/36] ARM: OMAP: DRA7: Enable clock init
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Message-ID: <1380098922-30340-23-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initializes clock data from device tree.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 205bb1d..1f23182 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -671,6 +671,7 @@ void __init dra7xx_init_early(void)
 	dra7xx_clockdomains_init();
 	dra7xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_clk_init = dra7xx_clk_init;
 }
 #endif
 
-- 
1.7.9.5
