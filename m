From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 15 Jun 2015 09:18:55 -0700
Subject: [PATCH 00/10] imx-sdma cleanup
Message-ID: <1434385144-4432-1-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The primary purpose of this patch series, was to
combine common parts of sdma_prep_slave_sg() and 
sdma_prep_dma_cyclic(). 

Code that is common between cyclic and slave
prep functions is combined, which also makes it easier to see
how they meaningfully differ.

In addition, we remove several unneeded or duplicative variables
from struct sdma_channel, add a few more printks on errors,
and simplify some internal functions.

Tested on imx6q

Joshua Clayton (10):
  dma: imx-sdma: constify local structs
  dma: imx-sdma: pass sdma engine into functions
  dma: imx-sdma: use a container_of function
  dma: sdma-imx set dma script address directly
  dma: sdma-imx: print an error when context load fails.
  dma: imx-sdma: config in sdma_config_channel()
  dma: imx-sdma: validate word size when set
  dma: imx-sdma: extract common sdma prep code
  dma: imx-sdma: use a for loop
  dma: imx-sdma: extract sdma_set_buffer_descriptor()

 drivers/dma/imx-sdma.c | 387 +++++++++++++++++++++++--------------------------
 1 file changed, 185 insertions(+), 202 deletions(-)

-- 
2.1.4
