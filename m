From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Oct 2010 15:04:53 +0200
Subject: [PATCH] mx25/clocks: match esdhc-clocks to platform device
Message-ID: <1286802293-18075-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So the correct clock will be taken for each of the two independent
controllers.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 25f37a9..2179713 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -299,8 +299,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx-wdt.0", NULL, wdt_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK(NULL, "sdhc", esdhc1_clk)
-	_REGISTER_CLOCK(NULL, "sdhc", esdhc2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
 	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
 	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
-- 
1.7.1
