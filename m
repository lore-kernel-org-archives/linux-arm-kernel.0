From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 28 Mar 2011 18:01:30 +0200
Subject: [PATCH 4/4] arm: lpc32xx: clock: use bool logic instead of binary
In-Reply-To: <1301328090-25994-1-git-send-email-w.sang@pengutronix.de>
References: <1301328090-25994-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1301328090-25994-4-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-lpc32xx/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 1e02751..7218237 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -396,7 +396,7 @@ static int local_usbpll_enable(struct clk *clk, int enable)
 		__raw_writel(reg, LPC32XX_CLKPWR_USB_CTRL);
 
 		/* Wait for PLL lock */
-		while ((timeout > jiffies) & (ret == -ENODEV)) {
+		while ((timeout > jiffies) && (ret == -ENODEV)) {
 			reg = __raw_readl(LPC32XX_CLKPWR_USB_CTRL);
 			if (reg & LPC32XX_CLKPWR_USBCTRL_PLL_STS)
 				ret = 0;
-- 
1.7.2.5
