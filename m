From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 10 Aug 2010 16:48:52 +0200
Subject: [PATCH] lpc32xx/clock: Use && instead of &
Message-ID: <1281451732-19294-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because we are connecting two expressions here, not binary values.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 32d6379..9ff1438 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -397,7 +397,7 @@ static int local_usbpll_enable(struct clk *clk, int enable)
 		__raw_writel(reg, LPC32XX_CLKPWR_USB_CTRL);
 
 		/* Wait for PLL lock */
-		while ((timeout > jiffies) & (ret == -ENODEV)) {
+		while ((timeout > jiffies) && (ret == -ENODEV)) {
 			reg = __raw_readl(LPC32XX_CLKPWR_USB_CTRL);
 			if (reg & LPC32XX_CLKPWR_USBCTRL_PLL_STS)
 				ret = 0;
-- 
1.7.1
