From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Mar 2017 14:06:39 -0700
Subject: [PATCH 4/4] ARM: OMAP2+: Make hwmod clkdm_name const
In-Reply-To: <20170314210639.2065-1-tony@atomide.com>
References: <20170314210639.2065-1-tony@atomide.com>
Message-ID: <20170314210639.2065-5-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This can be const, and needs to be const when we start initializing
it from clkdm data.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -676,7 +676,7 @@ struct omap_hwmod {
 	const char			*main_clk;
 	struct clk			*_clk;
 	struct omap_hwmod_opt_clk	*opt_clks;
-	char				*clkdm_name;
+	const char			*clkdm_name;
 	struct clockdomain		*clkdm;
 	struct list_head		slave_ports; /* connect to *_TA */
 	void				*dev_attr;
-- 
2.11.1
