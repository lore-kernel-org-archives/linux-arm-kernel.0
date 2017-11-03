From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 3 Nov 2017 16:26:38 +0200
Subject: [PATCH 4/7] ARM: OMAP2+: clockdomain: remove the obsolete
 clkdm_xlate_address API
In-Reply-To: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
References: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
Message-ID: <1509719201-32700-5-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is no longer used for anything so it can be dropped.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c | 8 --------
 arch/arm/mach-omap2/clockdomain.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 5189264..b79b1ca 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1224,14 +1224,6 @@ int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	return 0;
 }
 
-u32 clkdm_xlate_address(struct clockdomain *clkdm)
-{
-	if (arch_clkdm->clkdm_xlate_address)
-		return arch_clkdm->clkdm_xlate_address(clkdm);
-
-	return 0;
-}
-
 /**
  * clkdm_hwmod_enable - add an enabled downstream hwmod to this clkdm
  * @clkdm: struct clockdomain *
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 827f01e..24667a5 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -175,7 +175,6 @@ struct clkdm_ops {
 	void	(*clkdm_deny_idle)(struct clockdomain *clkdm);
 	int	(*clkdm_clk_enable)(struct clockdomain *clkdm);
 	int	(*clkdm_clk_disable)(struct clockdomain *clkdm);
-	u32	(*clkdm_xlate_address)(struct clockdomain *clkdm);
 };
 
 int clkdm_register_platform_funcs(struct clkdm_ops *co);
@@ -214,7 +213,6 @@ int clkdm_for_each(int (*fn)(struct clockdomain *clkdm, void *user),
 int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk);
 int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh);
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh);
-u32 clkdm_xlate_address(struct clockdomain *clkdm);
 
 extern void __init omap242x_clockdomains_init(void);
 extern void __init omap243x_clockdomains_init(void);
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
