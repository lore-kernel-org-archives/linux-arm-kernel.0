From: marex@denx.de (Marek Vasut)
Date: Tue,  4 Sep 2012 04:40:14 +0200
Subject: [PATCH 0/4] mxs/spi: Fixes and improvements
Message-ID: <1346726418-2856-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I humbly present fixes for further issues found in the SPI driver
for i.MX23/i.MX28.

The first patch rectifies the handling of DMA chaining in the driver,
hopefully this time it's correct. Sadly, documentation on this matter
is missing.

The further patches are mostly code improvements, cleanups and fixes
for minor details.

Marek Vasut (4):
  mxs/spi: Fix issues when doing long continuous transfer
  mxs/spi: Increment the transfer length only if transfer succeeded
  mxs/spi: Decrement the DMA/PIO border
  mxs/spi: Rework the mxs_ssp_timeout to be more readable

 drivers/spi/spi-mxs.c |  165 +++++++++++++++++++++++++++++--------------------
 1 file changed, 99 insertions(+), 66 deletions(-)

Cc: Chris Ball <cjb@laptop.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>

-- 
1.7.10.4
