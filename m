From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 6 Dec 2010 16:38:33 -0200
Subject: [PATCH 2/3] ARM: mx5: add watchdog clocks
In-Reply-To: <1291660714-16396-1-git-send-email-fabio.estevam@freescale.com>
References: <1291660714-16396-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1291660714-16396-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 344ee8e..d4c3911 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -833,6 +833,10 @@ static struct clk kpp_clk = {
 	.id = 0,
 };
 
+static struct clk dummy_clk = {
+	.id = 0,
+};
+
 static struct clk emi_slow_clk = {
 	.parent = &pll2_sw_clk,
 	.enable_reg = MXC_CCM_CCGR5,
@@ -1106,6 +1110,8 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
 	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
 	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
+	_REGISTER_CLOCK("imx-wdt.0", NULL, dummy_clk)
+	_REGISTER_CLOCK("imx-wdt.1", NULL, dummy_clk)
 };
 
 static struct clk_lookup mx53_lookups[] = {
-- 
1.6.0.4
