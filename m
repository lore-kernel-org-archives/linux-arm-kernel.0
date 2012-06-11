From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 13:02:11 +0200
Subject: [PATCH 8/14] ARM: LPC32xx: Clock adjustment for key matrix controller
In-Reply-To: <1339412537-24485-1-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
Message-ID: <1339412537-24485-9-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock.c file needs to be changed to match the automatic device name to its
clock.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Rob Herring <rob.herring@calxeda.com>

---
 arch/arm/mach-lpc32xx/clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -1131,7 +1131,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_INIT("31020300.i2c", NULL, &clk_i2c2),
 	CLKDEV_INIT("dev:ssp0", NULL, &clk_ssp0),
 	CLKDEV_INIT("dev:ssp1", NULL, &clk_ssp1),
-	CLKDEV_INIT("lpc32xx_keys.0", NULL, &clk_kscan),
+	CLKDEV_INIT("40050000.key", NULL, &clk_kscan),
 	CLKDEV_INIT("20020000.flash", NULL, &clk_nand),
 	CLKDEV_INIT("200a8000.flash", NULL, &clk_nand_mlc),
 	CLKDEV_INIT("40048000.adc", NULL, &clk_adc),
