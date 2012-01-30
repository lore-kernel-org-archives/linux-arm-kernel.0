From: stigge@antcom.de (Roland Stigge)
Date: Mon, 30 Jan 2012 17:02:02 +0100
Subject: [PATCH v2 3/7] LPC32xx: clock.c: Clock registration fixes
In-Reply-To: <1327939327-7799-1-git-send-email-stigge@antcom.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
Message-ID: <1327939327-7799-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adjusts the clock registration list, ported from the latest version
of Kevin Wells' latest version of clock.c: i2s0_ck, i2s1_ck and dev:mmc0 have
NULL pointers associated as the .dev_id and .con_id, respectively. The old
values were not useful.

Signed-off-by: Roland Stigge <stigge@antcom.de>

--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1076,10 +1098,10 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("dev:ssp1", NULL, clk_ssp1)
 	_REGISTER_CLOCK("lpc32xx_keys.0", NULL, clk_kscan)
 	_REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
-	_REGISTER_CLOCK("tbd", "i2s0_ck", clk_i2s0)
-	_REGISTER_CLOCK("tbd", "i2s1_ck", clk_i2s1)
+	_REGISTER_CLOCK(NULL, "i2s0_ck", clk_i2s0)
+	_REGISTER_CLOCK(NULL, "i2s1_ck", clk_i2s1)
 	_REGISTER_CLOCK("ts-lpc32xx", NULL, clk_tsc)
-	_REGISTER_CLOCK("dev:mmc0", "MCLK", clk_mmc)
+	_REGISTER_CLOCK("dev:mmc0", NULL, clk_mmc)
 	_REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
 	_REGISTER_CLOCK("dev:clcd", NULL, clk_lcd)
 	_REGISTER_CLOCK("lpc32xx_udc", "ck_usbd", clk_usbd)
