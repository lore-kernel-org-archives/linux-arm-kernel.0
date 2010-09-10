From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Fri, 10 Sep 2010 09:19:38 -0700
Subject: [PATCH 4/5] ARM: Ux500: Change SPI mode and remove unused fields
In-Reply-To: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
References: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1284135579-13578-5-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Some of the fields in the pl022_chip_info structure used with
the amba pl022 driver are no longer used. This patch removes
those unused fields and changes the .mode flags in the
spi_board_info structure to setup the correct SPI mode.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-ux500/board-mop500.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 0e8fd13..219ae0c 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -55,19 +55,13 @@ static void ab4500_spi_cs_control(u32 command)
 }
 
 struct pl022_config_chip ab4500_chip_info = {
-	.lbm = LOOPBACK_DISABLED,
 	.com_mode = INTERRUPT_TRANSFER,
 	.iface = SSP_INTERFACE_MOTOROLA_SPI,
 	/* we can act as master only */
 	.hierarchy = SSP_MASTER,
 	.slave_tx_disable = 0,
-	.endian_rx = SSP_RX_MSB,
-	.endian_tx = SSP_TX_MSB,
-	.data_size = SSP_DATA_BITS_24,
 	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
 	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
-	.clk_phase = SSP_CLK_SECOND_EDGE,
-	.clk_pol = SSP_CLK_POL_IDLE_HIGH,
 	.cs_control = ab4500_spi_cs_control,
 };
 
@@ -83,7 +77,7 @@ static struct spi_board_info u8500_spi_devices[] = {
 		.max_speed_hz = 12000000,
 		.bus_num = 0,
 		.chip_select = 0,
-		.mode = SPI_MODE_0,
+		.mode = SPI_MODE_3,
 		.irq = IRQ_DB8500_AB8500,
 	},
 };
-- 
1.7.2.2
