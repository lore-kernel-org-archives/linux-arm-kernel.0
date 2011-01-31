From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 31 Jan 2011 13:03:28 +0100
Subject: [PATCH 0/6] A few fixes on imx-sdma
In-Reply-To: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110131120328.GL9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 05:50:34AM +0800, Shawn Guo wrote:
> The patch set is to address the concerns discussed on thread below.
> And it's been tested on mx51 babbage board with sound driver.
> 
> "A few questions on imx-sdma"
> http://article.gmane.org/gmane.linux.ports.arm.kernel/103001/
> 
> Shawn Guo (6)
>  drivers/dma/imx-sdma.c |   31 +++++++++++++++++++------------
>  1 files changed, 19 insertions(+), 12 deletions(-)
> 
>  [PATCH 1/6] dmaengine: imx-sdma: remove IMX_DMA_SG_LOOP handling in sdma_prep_slave_sg()
>  [PATCH 2/6] dmaengine: imx-sdma: set sdmac->status to DMA_ERROR in err_out of sdma_prep_slave_sg()
>  [PATCH 3/6] dmaengine: imx-sdma: return sdmac->status in sdma_tx_status()
>  [PATCH 4/6] dmaengine: imxs-sdma: correct sdmac->status in sdma_handle_channel_loop()
>  [PATCH 5/6] dmaengine: imx-sdma: fix up param for the last BD in sdma_prep_slave_sg()

Patches 1/6 - 5/6:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Dan,

For your convenience I've set up a branch containing Shawns patches and
the ones just posted here:


The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:

  Linux 2.6.38-rc2 (2011-01-21 19:01:34 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6 dmaengine

Sascha Hauer (11):
      dmaengine i.MX sdma: set maximum segment size for our device
      dmaengine i.MX sdma: check sg entries for valid addresses and lengths
      dmaengine i.MX SDMA: do not initialize chan_id field
      dmaengine i.MX SDMA: initialize dma capabilities outside channel loop
      dmaengine i.MX SDMA: reserve channel 0 by not registering it
      dmaengine i.MX dma: set maximum segment size for our device
      dmaengine i.MX dma: check sg entries for valid addresses and lengths
      dmaengine i.MX DMA: do not initialize chan_id field
      dmaengine i.MX dma: initialize dma capabilities outside channel loop
      Merge branch 'dmaengine-sdma' into dmaengine
      Merge branch 'dmaengine-shawn' into dmaengine

Shawn Guo (5):
      dmaengine: imx-sdma: remove IMX_DMA_SG_LOOP handling in sdma_prep_slave_sg()
      dmaengine: imx-sdma: set sdmac->status to DMA_ERROR in err_out of sdma_prep_slave_sg()
      dmaengine: imx-sdma: return sdmac->status in sdma_tx_status()
      dmaengine: imx-sdma: correct sdmac->status in sdma_handle_channel_loop()
      dmaengine: imx-sdma: fix up param for the last BD in sdma_prep_slave_sg()

 drivers/dma/imx-dma.c  |   26 ++++++++++++++--
 drivers/dma/imx-sdma.c |   76 ++++++++++++++++++++++++++----------------------
 2 files changed, 63 insertions(+), 39 deletions(-)


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
