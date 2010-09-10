From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Fri, 10 Sep 2010 09:19:36 -0700
Subject: [PATCH 2/5] ARM: LPC32XX: Add missing SPI mode and remove unused
	fields
In-Reply-To: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
References: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1284135579-13578-3-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Some of the fields in the pl022_chip_info structure used with
the amba pl022 driver are no longer used. This patch removes
those unused fields and adds the missing .mode flags to the
spi_board_info structure.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/phy3250.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index bc9a42d..0c936cf 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -172,18 +172,12 @@ static void phy3250_spi_cs_set(u32 control)
 }
 
 static struct pl022_config_chip spi0_chip_info = {
-	.lbm			= LOOPBACK_DISABLED,
 	.com_mode		= INTERRUPT_TRANSFER,
 	.iface			= SSP_INTERFACE_MOTOROLA_SPI,
 	.hierarchy		= SSP_MASTER,
 	.slave_tx_disable	= 0,
-	.endian_tx		= SSP_TX_LSB,
-	.endian_rx		= SSP_RX_LSB,
-	.data_size		= SSP_DATA_BITS_8,
 	.rx_lev_trig		= SSP_RX_4_OR_MORE_ELEM,
 	.tx_lev_trig		= SSP_TX_4_OR_MORE_EMPTY_LOC,
-	.clk_phase		= SSP_CLK_FIRST_EDGE,
-	.clk_pol		= SSP_CLK_POL_IDLE_LOW,
 	.ctrl_len		= SSP_BITS_8,
 	.wait_state		= SSP_MWIRE_WAIT_ZERO,
 	.duplex			= SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
@@ -239,6 +233,7 @@ static int __init phy3250_spi_board_register(void)
 			.max_speed_hz = 5000000,
 			.bus_num = 0,
 			.chip_select = 0,
+			.mode = SPI_MODE_0,
 			.platform_data = &eeprom,
 			.controller_data = &spi0_chip_info,
 		},
-- 
1.7.2.2
