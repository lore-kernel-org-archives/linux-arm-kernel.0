From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 21 Jan 2010 17:00:22 +0200
Subject: [PATCH 1/2] mx25: remove unused mx25_clocks_init() argument
In-Reply-To: <cover.1264085584.git.baruch@tkos.co.il>
References: <cover.1264085584.git.baruch@tkos.co.il>
Message-ID: <62743e533ee2fc3527cc1dda75933f03704e7a63.1264085584.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fref is needless on mx25 since the reference clock is fixed at 24MHz.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/clock.c              |    2 +-
 arch/arm/mach-mx25/mx25pdk.c            |    2 +-
 arch/arm/plat-mxc/include/mach/common.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 6e838b8..a4ba334 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -208,7 +208,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 };
 
-int __init mx25_clocks_init(unsigned long fref)
+int __init mx25_clocks_init(void)
 {
 	int i;
 
diff --git a/arch/arm/mach-mx25/mx25pdk.c b/arch/arm/mach-mx25/mx25pdk.c
index c8b1d3b..232f9ca 100644
--- a/arch/arm/mach-mx25/mx25pdk.c
+++ b/arch/arm/mach-mx25/mx25pdk.c
@@ -98,7 +98,7 @@ static void __init mx25pdk_init(void)
 
 static void __init mx25pdk_timer_init(void)
 {
-	mx25_clocks_init(26000000);
+	mx25_clocks_init();
 }
 
 static struct sys_timer mx25pdk_timer = {
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 286cb9b..4bf1068 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -32,7 +32,7 @@ extern void mxc91231_init_irq(void);
 extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
 extern int mx1_clocks_init(unsigned long fref);
 extern int mx21_clocks_init(unsigned long lref, unsigned long fref);
-extern int mx25_clocks_init(unsigned long fref);
+extern int mx25_clocks_init(void);
 extern int mx27_clocks_init(unsigned long fref);
 extern int mx31_clocks_init(unsigned long fref);
 extern int mx35_clocks_init(void);
-- 
1.6.5
