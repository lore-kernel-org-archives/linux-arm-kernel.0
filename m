From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Mar 2011 10:50:00 +0100
Subject: [PATCH 02/10] ux500: Adding new board files for snowball.
In-Reply-To: <1299884892-6766-3-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201103121050.00140.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 March 2011 00:08:04 mathieu.poirier at linaro.org wrote:
> From: Mathieu J. Poirier <mathieu.poirier@linaro.org>
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

This changelog would be a good place to explain what the board
is and point to http://www.igloocommunity.org/.

The patch looks good. One question though:

> +
> +static struct pl022_ssp_controller ssp0_platform_data = {
> +	.bus_id = 0,
> +#ifdef CONFIG_STE_DMA40
> +	.enable_dma = 1,
> +	.dma_filter = stedma40_filter,
> +	.dma_rx_param = &ssp0_dma_cfg_rx,
> +	.dma_tx_param = &ssp0_dma_cfg_tx,
> +#else
> +	.enable_dma = 0,
> +#endif
> +	/* on this platform, gpio 31,142,144,214 &
> +	 * 224 are connected as chip selects
> +	 */
> +	.num_chipselect = 5,
> +};

You have a lot of #ifdef CONFIG_STE_DMA40. Is that something
that realistically would be disabled for many users?

If not, you could simply "select STE_DMA40" from the board
Kconfig symbol and make all these unconditional.

	Arnd
