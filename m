From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Feb 2016 08:43:00 +0100
Subject: [PATCH v2] i.MX SPI DMA cleanup
Message-ID: <1455867792-26389-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Second round for the i.MX SPI DMA patches. No changes to code, only
updated commit messages.

Mark, you already applied patch 1/12 and 2/12. I'm resending them here
anyway because I updated the commit message as you requested. Feel free
to ignore 1/12 and 2/12 or replace them with this updated version.

Changes since v1:

- Add missing Signed-off-by to Patch 3
- Drop device tree change as it's already applied by Shawn
- Add patch subject when referring to commits

----------------------------------------------------------------
Anton Bondarenko (3):
      spi: imx: allow only WML aligned transfers to use DMA
      spi: imx: replace fixed timeout with calculated
      spi: imx: add support for all SPI word width for DMA

Sascha Hauer (9):
      spi: imx: use proper dev_* functions for driver messages
      spi: imx: drop fallback to PIO
      spi: imx: initialize usedma earlier
      spi: imx: drop unnecessary read/modify/write
      spi: imx: drop unncessary dma_is_inited variable
      spi: imx: remove unnecessary bit clearing in mx51_ecspi_config
      spi: imx: make some register defines simpler
      spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function
      spi: imx: drop bogus tests for rx/tx bufs in DMA transfer

 drivers/spi/spi-imx.c | 350 ++++++++++++++++++++++++++------------------------
 1 file changed, 181 insertions(+), 169 deletions(-)
