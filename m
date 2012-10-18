From: stigge@antcom.de (Roland Stigge)
Date: Thu, 18 Oct 2012 18:06:10 +0200
Subject: [PATCH] ARM: mach-imx: Support for DryIce RTC in i.MX53
In-Reply-To: <1350576370-29098-1-git-send-email-stigge@antcom.de>
References: <1350576370-29098-1-git-send-email-stigge@antcom.de>
Message-ID: <1350576370-29098-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables support for i.MX53 in addition to i.MX25 by providing a
dummy clock on i.MX53 since this one doesn't have a separate clock for internal
RTC but the driver requests one.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.orig/arch/arm/mach-imx/clk-imx51-imx53.c
+++ linux-2.6/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -467,6 +467,7 @@ int __init mx53_clocks_init(unsigned lon
 	clk_register_clkdev(clk[can1_serial_gate], "per", "53fc8000.can");
 	clk_register_clkdev(clk[can2_ipg_gate], "ipg", "53fcc000.can");
 	clk_register_clkdev(clk[can2_serial_gate], "per", "53fcc000.can");
+	clk_register_clkdev(clk[dummy], NULL, "53fa4000.rtc");
 
 	/* set SDHC root clock to 200MHZ*/
 	clk_set_rate(clk[esdhc_a_podf], 200000000);
