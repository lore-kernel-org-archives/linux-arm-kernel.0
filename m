From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 Nov 2011 10:57:11 +0000
Subject: [PATCH 6/6] ARM: S3C64XX: Modified according to SPI
	consolidation work.
In-Reply-To: <1320410634-10788-7-git-send-email-padma.v@samsung.com>
References: <1320410634-10788-1-git-send-email-padma.v@samsung.com>
	<1320410634-10788-7-git-send-email-padma.v@samsung.com>
Message-ID: <20111104105710.GA12134@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 08:43:54AM -0400, Padmavathi Venna wrote:

> +#ifdef CONFIG_S3C64XX_DEV_SPI0
> +static struct s3c64xx_spi_info crag6410_spi0_pdata __initdata = {
> +	.cfg_gpio       = s3c64xx_spi0_cfg_gpio,
> +	.fifo_lvl_mask  = 0x7f,
> +	.rx_lvl_offset  = 13,
> +	.tx_st_done     = 21,
> +};
> +#endif

It seems like a step backwards to have all this stuff in the individual
machines - most of this (everything except cfg_gpio pretty much) is a
property of the SoC silicon so should be somewhere central for the SoC.
