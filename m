From: hramrach@gmail.com (Michal Suchanek)
Date: Fri, 24 Jul 2015 17:36:49 +0200
Subject: [PATCH 1/2] spi: s3c64xx: print fifo size on probe.
In-Reply-To: <cover.1438075797.git.hramrach@gmail.com>
References: <cover.1438075797.git.hramrach@gmail.com>
Message-ID: <f2e4f2351691d3060f15d239d6b0998d32950812.1438075797.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Printing the FIFO depth does not add much noise in the log and can be useful
for debugging transfer issues.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2a8c513..cd1cfac 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1191,8 +1191,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
 					sdd->port_id, master->num_chipselect);
-	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tDMA=[Rx-%d, Tx-%d]\n",
-					mem_res,
+	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\tDMA=[Rx-%d, Tx-%d]\n",
+					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
 					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
 
 	return 0;
-- 
2.1.4
