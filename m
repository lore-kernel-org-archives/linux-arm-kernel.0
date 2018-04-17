From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Apr 2018 03:53:23 +0800
Subject: [RFC PATCH spi] spi: pxa2xx: pxa2xx_spi_transfer_one() can be static
In-Reply-To: <201804180300.Pn9JAJQ2%fengguang.wu@intel.com>
References: <201804180300.Pn9JAJQ2%fengguang.wu@intel.com>
Message-ID: <20180417195323.GA69680@ivb43>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: d5898e19c0d7 ("spi: pxa2xx: Use core message processing loop")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 spi-pxa2xx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c852ea5..40f1346 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -911,9 +911,9 @@ static bool pxa2xx_spi_can_dma(struct spi_controller *master,
 	       xfer->len >= chip->dma_burst_size;
 }
 
-int pxa2xx_spi_transfer_one(struct spi_controller *master,
-			    struct spi_device *spi,
-			    struct spi_transfer *transfer)
+static int pxa2xx_spi_transfer_one(struct spi_controller *master,
+				   struct spi_device *spi,
+				   struct spi_transfer *transfer)
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(master);
 	struct spi_message *message = master->cur_msg;
