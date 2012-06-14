From: stigge@antcom.de (Roland Stigge)
Date: Thu, 14 Jun 2012 18:50:53 +0200
Subject: [PATCH v2 03/23] ARM: LPC32xx: Remove SLC controller initialization
 from platform init
In-Reply-To: <1339692673-7848-1-git-send-email-stigge@antcom.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
Message-ID: <1339692673-7848-4-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we now support two MTD NAND controllers (MLC and SLC) for LPC32xx via DT,
we don't initialize the SLC controller statically anymore, but do it via the
clock setup (see previous patch).

Signed-off-by: Roland Stigge <stigge@antcom.de>
Tested-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 arch/arm/mach-lpc32xx/phy3250.c |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/phy3250.c
+++ linux-2.6/arch/arm/mach-lpc32xx/phy3250.c
@@ -241,10 +241,6 @@ static void __init lpc3250_machine_init(
 {
 	u32 tmp;
 
-	/* Setup SLC NAND controller muxing */
-	__raw_writel(LPC32XX_CLKPWR_NANDCLK_SEL_SLC,
-		LPC32XX_CLKPWR_NAND_CLK_CTRL);
-
 	/* Setup LCD muxing to RGB565 */
 	tmp = __raw_readl(LPC32XX_CLKPWR_LCDCLK_CTRL) &
 		~(LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_MSK |
