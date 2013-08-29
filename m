From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 29 Aug 2013 16:16:36 +0300
Subject: [PATCHv6 44/45] ARM: OMAP: DRA7: Enable clock init
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Message-ID: <1377782197-10611-45-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initializes clock data from device tree.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c |    1 +
 include/linux/clk/ti.h   |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index fd4bb71..315a148 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -682,6 +682,7 @@ void __init dra7xx_init_early(void)
 	dra7xx_clockdomains_init();
 	dra7xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_clk_init = dra7xx_clk_init;
 }
 #endif
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 90cb61b..0fcd2e7 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -226,6 +226,7 @@ static inline void of_omap_clk_deny_autoidle_all(void) { }
 #endif
 
 int omap5xxx_clk_init(void);
+int dra7xx_clk_init(void);
 
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
-- 
1.7.9.5
