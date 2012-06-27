From: stigge@antcom.de (Roland Stigge)
Date: Thu, 28 Jun 2012 00:26:12 +0200
Subject: [PATCH 2/8] ARM: LPC32xx: Add further bits to MMC init
In-Reply-To: <1340835978-20331-1-git-send-email-stigge@antcom.de>
References: <1340835978-20331-1-git-send-email-stigge@antcom.de>
Message-ID: <1340835978-20331-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes sure certain MMC bits are cleared as they should for
initialization.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 arch/arm/mach-lpc32xx/clock.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -813,7 +813,11 @@ static int mmc_onoff_enable(struct clk *
 
 	tmp = __raw_readl(LPC32XX_CLKPWR_MS_CTRL) &
 		~(LPC32XX_CLKPWR_MSCARD_SDCARD_EN |
-		  LPC32XX_CLKPWR_MSCARD_MSDIO_PU_EN);
+		  LPC32XX_CLKPWR_MSCARD_MSDIO_PU_EN |
+		  LPC32XX_CLKPWR_MSCARD_MSDIO_PIN_DIS |
+		  LPC32XX_CLKPWR_MSCARD_MSDIO0_DIS |
+		  LPC32XX_CLKPWR_MSCARD_MSDIO1_DIS |
+		  LPC32XX_CLKPWR_MSCARD_MSDIO23_DIS);
 
 	/* If rate is 0, disable clock */
 	if (enable != 0)
