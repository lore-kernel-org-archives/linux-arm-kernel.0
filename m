From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 15 Jul 2013 20:47:42 +0200
Subject: [PATCH v1 13/24] spi: mpc512x: OF clock lookup, use the 'mclk' name
In-Reply-To: <1373914074-20889-1-git-send-email-gsi@denx.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
Message-ID: <1373914074-20889-14-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after PSC related clock specifiers were added to the device tree,
the former 'psc%d_mclk' isn't needed any longer to lookup clock items

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/spi/spi-mpc512x-psc.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 76b20ea..3e30e52 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -388,13 +388,11 @@ static int mpc512x_psc_spi_port_config(struct spi_master *master,
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
 	struct clk *spiclk;
 	int ret = 0;
-	char name[32];
 	u32 sicr;
 	u32 ccr;
 	u16 bclkdiv;
 
-	sprintf(name, "psc%d_mclk", master->bus_num);
-	spiclk = clk_get(&master->dev, name);
+	spiclk = clk_get(&master->dev, "mclk");
 	clk_prepare_enable(spiclk);
 	mps->mclk = clk_get_rate(spiclk);
 	clk_put(spiclk);
-- 
1.7.10.4
