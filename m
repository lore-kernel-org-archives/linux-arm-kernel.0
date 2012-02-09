From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  9 Feb 2012 22:30:34 +0100
Subject: [PATCH] RM: OMAP4: board-4430sdp: don't initialize value that is
 never used
Message-ID: <1328823034-9668-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdp4430_spi_board_info.irq was initialized to ETH_KS8851_IRQ and in
omap_4430sdp_init() overwritten with gpio_to_irq(ETH_KS8851_IRQ) before
sdp4430_spi_board_info was registered. This is a bit confusing, so
better don't initialize .irq and document that it is set later.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap2/board-4430sdp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 39fba9d..991a289 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -321,7 +321,10 @@ static struct spi_board_info sdp4430_spi_board_info[] __initdata = {
 		.bus_num                = 1,
 		.chip_select            = 0,
 		.max_speed_hz           = 24000000,
-		.irq                    = ETH_KS8851_IRQ,
+		/*
+		 * .irq is set to gpio_to_irq(ETH_KS8851_IRQ)
+		 * in omap_4430sdp_init
+		 */
 	},
 };
 
-- 
1.7.9
