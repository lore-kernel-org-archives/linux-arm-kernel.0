From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Jun 2018 14:41:06 +0800
Subject: [PATCH] ARM: dts: imx6q: Use correct SDMA script for SPI5 core
In-Reply-To: <20180522174509.18154-1-sean.nyekjaer@prevas.dk>
References: <20180522174509.18154-1-sean.nyekjaer@prevas.dk>
Message-ID: <20180611064104.GD16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 07:45:09PM +0200, Sean Nyekjaer wrote:
> According to the reference manual the shp_2_mcu / mcu_2_shp
> scripts must be used for devices connected through the SPBA.
> 
> This fixes an issue we saw with DMA transfers.
> Sometimes the SPI controller RX FIFO was not empty after a DMA
> transfer and the driver got stuck in the next PIO transfer when
> it read one word more than expected.
> 
> commit dd4b487b32a35 ("ARM: dts: imx6: Use correct SDMA script
> for SPI cores") is fixing the same issue but only for SPI1 - 4.
> 
> Fixes: 677940258dd8e ("ARM: dts: imx6q: enable dma for ecspi5")
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

Applied, thanks.
