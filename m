From: stigge@antcom.de (stigge at antcom.de)
Date: Thu,  2 Feb 2012 20:19:43 +0100
Subject: [PATCH v3 2/7] ARM: LPC32XX: Remove broken non-static declaration
In-Reply-To: <1328210388-21296-1-git-send-email-stigge@antcom.de>
References: <1328210388-21296-1-git-send-email-stigge@antcom.de>
Message-ID: <1328210388-21296-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a GCC compile error ("static declaration follows non-static
declaration") for LPC32XX's watchdog, removing the extern declaration since
it's not called externally.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>

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
