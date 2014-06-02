From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:40:24 +0200
Subject: [PATCH 4/4] ARM: shmobile: koelsch legacy: Enable DMA for QSPI
In-Reply-To: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
References: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1401716424-29740-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-koelsch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index c6c68892caa3..171ce3ea162a 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -182,6 +182,8 @@ static const struct resource qspi_resources[] __initconst = {
 
 static const struct rspi_plat_data qspi_pdata __initconst = {
 	.num_chipselect = 1,
+	.dma_tx_id	= SYS_DMAC_SLAVE_QSPI_TX,
+	.dma_rx_id	= SYS_DMAC_SLAVE_QSPI_RX,
 };
 
 /* SPI Flash memory (Spansion S25FL512SAGMFIG11 64 MiB) */
-- 
1.9.1
