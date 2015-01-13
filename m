From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jan 2015 15:13:55 -0800
Subject: [PATCH 5/7] ARM: OMAP2+: Fix dm814 and dm816 for clocks and timer init
In-Reply-To: <1421190837-4692-1-git-send-email-tony@atomide.com>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
Message-ID: <1421190837-4692-6-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix dm814 and dm816 clocks and timer init.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm_common.c | 4 ++++
 arch/arm/mach-omap2/timer.c      | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 779940c..b658785 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -571,6 +571,10 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scrm" },
 	{ .compatible = "ti,am4-prcm" },
 	{ .compatible = "ti,am4-scrm" },
+	{ .compatible = "ti,dm814-prcm" },
+	{ .compatible = "ti,dm814-scrm" },
+	{ .compatible = "ti,dm816-prcm" },
+	{ .compatible = "ti,dm816-scrm" },
 	{ .compatible = "ti,omap2-prcm" },
 	{ .compatible = "ti,omap2-scrm" },
 	{ .compatible = "ti,omap3-prm" },
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 4f61148..376b099 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -146,6 +146,8 @@ static const struct of_device_id omap_timer_match[] __initconst = {
 	{ .compatible = "ti,omap3430-timer", },
 	{ .compatible = "ti,omap4430-timer", },
 	{ .compatible = "ti,omap5430-timer", },
+	{ .compatible = "ti,dm814-timer", },
+	{ .compatible = "ti,dm816-timer", },
 	{ .compatible = "ti,am335x-timer", },
 	{ .compatible = "ti,am335x-timer-1ms", },
 	{ }
-- 
2.1.4
