From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Feb 2014 11:47:32 +0100
Subject: [PATCH 6/7] ARM: shmobile: lager legacy: Enable Quad SPI transfers
 for the SPI FLASH
In-Reply-To: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
References: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1392029254-15400-7-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
This depends on spi-rspi updates

 arch/arm/mach-shmobile/board-lager.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 9e52efa2a457..d7155375a322 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -298,12 +298,12 @@ static const struct rspi_plat_data qspi_pdata __initconst = {
 
 static const struct spi_board_info spi_info[] __initconst = {
 	{
-		.modalias               = "m25p80",
-		.platform_data          = &spi_flash_data,
-		.mode                   = SPI_MODE_0,
-		.max_speed_hz           = 30000000,
-		.bus_num                = 0,
-		.chip_select            = 0,
+		.modalias	= "m25p80",
+		.platform_data	= &spi_flash_data,
+		.mode		= SPI_MODE_0 | SPI_TX_QUAD | SPI_RX_QUAD,
+		.max_speed_hz	= 30000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
 	},
 };
 
-- 
1.7.9.5
