From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 14 Sep 2011 07:04:31 -0600
Subject: [PATCH] test patch for Igor
Message-ID: <mailman.133.1316005842.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/mach-omap2/clock3xxx_data.c |    8 ++++----
 arch/arm/mach-omap2/id.c             |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index b9b8446..078a40a 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3472,12 +3472,12 @@ int __init omap3xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg = 0;
 
-	if (cpu_is_omap3517()) {
-		cpu_mask = RATE_IN_34XX;
-		cpu_clkflg = CK_3517;
-	} else if (cpu_is_omap3505()) {
+	if (cpu_is_omap3505()) {
 		cpu_mask = RATE_IN_34XX;
 		cpu_clkflg = CK_3505;
+	} else if (cpu_is_omap3517()) {
+		cpu_mask = RATE_IN_34XX;
+		cpu_clkflg = CK_3517;
 	} else if (cpu_is_omap3630()) {
 		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
 		cpu_clkflg = CK_36XX;
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 307e186..ed1d439 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -463,7 +463,7 @@ static void __init omap3_cpuinfo(const char *cpu_rev)
 	 */
 	if (cpu_is_omap3630()) {
 		cpu_name = "OMAP3630";
-	} else if (cpu_is_omap3505()) {
+	} else if (cpu_is_omap3517()) {
 		/* AM35xx devices */
 		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
 	} else if (cpu_is_ti816x()) {
-- 
1.7.5.4
