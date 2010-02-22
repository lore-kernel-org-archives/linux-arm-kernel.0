From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 22 Feb 2010 12:24:19 -0500
Subject: [PATCH] ep93xx: fix broken build of clock.c
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909021B9BFC@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 5879/1: ep93xx: define magic numbers for pll1 and pll2 broke
the ep93xx build due to one missing rename of EP93XX_SYSCON_CLOCK_SET2.
The correct name should be EP93XX_SYSCON_CLKSET2.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index e894ee0..5f80092 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -462,7 +462,7 @@ static int __init ep93xx_clock_init(void)
 	ep93xx_dma_clock_init();
 
 	/* Determine the bootloader configured pll2 rate */
-	value = __raw_readl(EP93XX_SYSCON_CLOCK_SET2);
+	value = __raw_readl(EP93XX_SYSCON_CLKSET2);
 	if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
 		clk_pll2.rate = clk_xtali.rate;
 	else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
