From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Feb 2016 09:20:24 +0100
Subject: [PATCH v4] i.MX SPI DMA cleanup
Message-ID: <1456302033-25638-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v3:

- improve commit description for "spi: imx: initialize usedma earlier"

Changes since v2:

- Drop patches already applied
- rebase on next

Changes since v1:

- Add missing Signed-off-by to Patch 3
- Drop device tree change as it's already applied by Shawn
- Add patch subject when referring to commits

----------------------------------------------------------------
Anton Bondarenko (1):
      spi: imx: add support for all SPI word width for DMA

Sascha Hauer (8):
      spi: imx: drop fallback to PIO
      spi: imx: initialize usedma earlier
      spi: imx: drop unnecessary read/modify/write
      spi: imx: drop unncessary dma_is_inited variable
      spi: imx: remove unnecessary bit clearing in mx51_ecspi_config
      spi: imx: make some register defines simpler
      spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function
      spi: imx: drop bogus tests for rx/tx bufs in DMA transfer

 drivers/spi/spi-imx.c | 296 ++++++++++++++++++++++++++------------------------
 1 file changed, 153 insertions(+), 143 deletions(-)
