From: stigge@antcom.de (Roland Stigge)
Date: Thu, 29 Mar 2012 00:49:56 +0200
Subject: [PATCH] ARM: LPC32xx: clock.c: Fix lpc-eth clock reference
Message-ID: <1332974996-13045-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During a complex merge for v3.4, one line of the commit
c20b909be9ba27173294a52d08cab293ec030a2c ("ARM: LPC32xx: Ethernet support") was
reverted wrongly ("lpc-eth.0" -> "lpc-net.0") while the other conflicts were
merged correctly. This patch re-applies the clock name "lpc-eth.0".

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 Applies on top of Olof's 1f5b7dcfdad3840d4bce27ab0b3cc8f376b81544 in
 preparation of v3.4-rc1

 arch/arm/mach-lpc32xx/clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -1134,7 +1134,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "i2s1_ck", clk_i2s1)
 	_REGISTER_CLOCK("ts-lpc32xx", NULL, clk_tsc)
 	_REGISTER_CLOCK("dev:mmc0", NULL, clk_mmc)
-	_REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
+	_REGISTER_CLOCK("lpc-eth.0", NULL, clk_net)
 	_REGISTER_CLOCK("dev:clcd", NULL, clk_lcd)
 	_REGISTER_CLOCK("lpc32xx_udc", "ck_usbd", clk_usbd)
 	_REGISTER_CLOCK("lpc32xx_rtc", NULL, clk_rtc)
