From: stigge@antcom.de (Roland Stigge)
Date: Mon, 11 Jun 2012 13:02:06 +0200
Subject: [PATCH 3/14] ARM: LPC32xx: Remove SLC controller initialization from
 platform init
In-Reply-To: <1339412537-24485-1-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
Message-ID: <1339412537-24485-4-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we now support two MTD NAND controllers (MLC and SLC) for LPC32xx via DT,
we don't initialize the SLC controller statically anymore, but do it via the
clock setup (see previous patch).

Signed-off-by: Roland Stigge <stigge@antcom.de>

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
