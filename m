From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:02 +0530
Subject: [PATCH 38/74] ST SPEAr3xx: Rearranging declarations in clock.c file
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <4d45de5bf73c7c10c68ade48922a9c3ffdcac795.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/clock.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index b56a755..720f04f 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -614,6 +614,11 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "fsmc",		.clk = &fsmc_clk},
 #endif
 
+	/* common clock to spear300 and spear320 */
+#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR320)
+	{ .dev_id = "sdhci",	.clk = &sdhci_clk},
+#endif /* CONFIG_MACH_SPEAR300 || CONFIG_MACH_SPEAR320 */
+
 	/* spear300 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR300
 	{ .dev_id = "keyboard",		.clk = &kbd_clk},
@@ -628,11 +633,6 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
 	{ .dev_id = "pwm",		.clk = &pwm_clk},
 #endif
-
-	/* common clock to spear300 and spear320 */
-#if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR320)
-	{ .dev_id = "sdhci",	.clk = &sdhci_clk},
-#endif /* CONFIG_MACH_SPEAR300 || CONFIG_MACH_SPEAR320 */
 };
 
 void __init clk_init(void)
-- 
1.7.2.2
