From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 29 Mar 2013 16:20:10 +0100
Subject: [PATCH v2 2/2] ARM: imx35 Bugfix admux clock
In-Reply-To: <1364570410-32755-1-git-send-email-mpa@pengutronix.de>
References: <1364570410-32755-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1364570410-32755-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The admux clock seems to be the audmux clock as tests show. audmux does
not work without this clock enabled. Currently imx35 does not register a
clock device for audmux. This patch adds this registration. imx-audmux
driver already handles a clock device, so no changes are necessary
there.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-imx/clk-imx35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index b95898a..2193c83 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -257,6 +257,7 @@ int __init mx35_clocks_init(void)
 	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
 	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
 	clk_register_clkdev(clk[csi_gate], NULL, "mx3-camera.0");
+	clk_register_clkdev(clk[admux_gate], "audmux", NULL);
 
 	clk_prepare_enable(clk[spba_gate]);
 	clk_prepare_enable(clk[gpio1_gate]);
-- 
1.8.2.rc2
