From: stigge@antcom.de (Roland Stigge)
Date: Fri, 27 Jan 2012 14:04:45 +0100
Subject: [PATCH] LPC32XX build fix
Message-ID: <1327669485-15322-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a GCC compile error ("static declaration follows non-static
declaration") for LPC32XX's watchdog, removing the extern declaration since
it's not called externally.

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
index 4b4e700..75640bfb 100644
--- a/arch/arm/mach-lpc32xx/common.h
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -65,7 +65,6 @@ extern u32 clk_get_pclk_div(void);
  */
 extern void lpc32xx_get_uid(u32 devid[4]);
 
-extern void lpc32xx_watchdog_reset(void);
 extern u32 lpc32xx_return_iram_size(void);
 
 /*
