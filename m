From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Apr 2014 07:45:02 +0900
Subject: [PATCH 13/14] ARM: shmobile: koelsch legacy: Enable Quad SPI
 transfers for the SPI FLASH
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
Message-ID: <4d4a0ff30c39b82c1dc549f2cc7a62b514431e64.1397774191.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 5a034ff..a12a9d3 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -216,7 +216,7 @@ static const struct spi_board_info spi_info[] __initconst = {
 	{
 		.modalias	= "m25p80",
 		.platform_data	= &spi_flash_data,
-		.mode		= SPI_MODE_0,
+		.mode		= SPI_MODE_0 | SPI_TX_QUAD | SPI_RX_QUAD,
 		.max_speed_hz	= 30000000,
 		.bus_num	= 0,
 		.chip_select	= 0,
-- 
1.8.4
