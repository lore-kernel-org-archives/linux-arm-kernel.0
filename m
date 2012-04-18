From: stigge@antcom.de (Roland Stigge)
Date: Wed, 18 Apr 2012 15:36:09 +0200
Subject: [PATCH v3 4/10] ARM: LPC32xx: clock.c dma adjustment
In-Reply-To: <1334756176-25144-1-git-send-email-stigge@antcom.de>
References: <1334756176-25144-1-git-send-email-stigge@antcom.de>
Message-ID: <1334756176-25144-5-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adjusts the DMA clock of the LPC32xx to "pl08xdmac" to be picked up
correctly by the AMBA dmaengine driver.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/mach-lpc32xx/clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -1109,7 +1109,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_INIT(NULL, "timer2_ck", &clk_timer2),
 	CLKDEV_INIT(NULL, "timer3_ck", &clk_timer3),
 	CLKDEV_INIT(NULL, "vfp9_ck", &clk_vfp9),
-	CLKDEV_INIT(NULL, "clk_dmac", &clk_dma),
+	CLKDEV_INIT("pl08xdmac", NULL, &clk_dma),
 	CLKDEV_INIT("pnx4008-watchdog", NULL, &clk_wdt),
 	CLKDEV_INIT(NULL, "uart3_ck", &clk_uart3),
 	CLKDEV_INIT(NULL, "uart4_ck", &clk_uart4),
