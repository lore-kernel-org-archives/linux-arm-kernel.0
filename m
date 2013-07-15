From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 15 Jul 2013 20:47:30 +0200
Subject: [PATCH v1 01/24] spi: mpc512x: prepare clocks before enabling them
In-Reply-To: <1373914074-20889-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
Message-ID: <1373914074-20889-2-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clocks need to get prepared before they can get enabled,
fix the MPC512x PSC SPI master's initialization

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/spi/spi-mpc512x-psc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 29fce6a..76b20ea 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -395,7 +395,7 @@ static int mpc512x_psc_spi_port_config(struct spi_master *master,
 
 	sprintf(name, "psc%d_mclk", master->bus_num);
 	spiclk = clk_get(&master->dev, name);
-	clk_enable(spiclk);
+	clk_prepare_enable(spiclk);
 	mps->mclk = clk_get_rate(spiclk);
 	clk_put(spiclk);
 
-- 
1.7.10.4
