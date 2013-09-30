From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 30 Sep 2013 15:00:36 +0200
Subject: [PATCH] ARM: at91: cam60: fix incorrect placement of __initdata tag
Message-ID: <1547748.5rp6t7JgE3@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initdata tag should be placed between the variable name and equal
sign for the variable to be placed in the intended .init.data section.

In this particular case __initdata is incorrect as cam60_macb_data
can be used as a platform data for at91_eth driver which can be
compiled as module.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-at91/board-cam60.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/board-cam60.c b/arch/arm/mach-at91/board-cam60.c
index ade948b..ecabbed 100644
--- a/arch/arm/mach-at91/board-cam60.c
+++ b/arch/arm/mach-at91/board-cam60.c
@@ -108,16 +108,14 @@ static struct spi_board_info cam60_spi_devices[] __initdata = {
 #endif
 };
 
-
 /*
  * MACB Ethernet device
  */
-static struct __initdata macb_platform_data cam60_macb_data = {
+static struct macb_platform_data cam60_macb_data = {
 	.phy_irq_pin	= AT91_PIN_PB5,
 	.is_rmii	= 0,
 };
 
-
 /*
  * NAND Flash
  */
-- 
1.8.2.3
