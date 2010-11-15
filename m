From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Mon, 15 Nov 2010 11:59:06 -0800 (PST)
Subject: [PATCH] mx51: Add a dummy clock to watchdog
Message-ID: <619900.66358.qm@web51007.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On MX51 there is no watchdog clock entry in the CCM block.

Create a dummy clock structure and register the watchdog clock. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 8ac36d8..7c8f9d4 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -819,6 +819,10 @@ static struct clk emi_slow_clk = {
 	.get_rate = clk_emi_slow_get_rate,
 };
 
+static struct clk dummy_clk = {
+	.id = 0,
+};
+
 #define DEFINE_CLOCK_CCGR(name, i, er, es, pfx, p, s)	\
 	static struct clk name = {			\
 		.id		= i,			\
@@ -1082,6 +1086,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
 	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
+	_REGISTER_CLOCK("imx-wdt.0", NULL, dummy_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.6.0.4



      
