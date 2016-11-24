From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 24 Nov 2016 12:25:00 +0100
Subject: [PATCH 4/5] spi: atmel: trivial: remove unused fields in DMA structure
In-Reply-To: <cover.1479985886.git.nicolas.ferre@atmel.com>
References: <cover.1479985886.git.nicolas.ferre@atmel.com>
Message-ID: <b9945f7ce52c8368843c7de850de302c34d828d7.1479985886.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atmel_spi_dma structure was cluttered with unused fields relative
to older DMA channel selection API. Remove them.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/spi/spi-atmel.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f62bc2d27c9e..f3a225585575 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -268,10 +268,6 @@
 struct atmel_spi_dma {
 	struct dma_chan			*chan_rx;
 	struct dma_chan			*chan_tx;
-	struct dma_async_tx_descriptor	*data_desc_rx;
-	struct dma_async_tx_descriptor	*data_desc_tx;
-
-	struct at_dma_slave	dma_slave;
 };
 
 struct atmel_spi_caps {
-- 
2.9.0
