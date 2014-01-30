From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Wed, 29 Jan 2014 22:20:48 -0300
Subject: [linux-sunxi] [PATCH v2 3/5] spi: sunxi: Add Allwinner A31 SPI
 controller driver
In-Reply-To: <1390993850-9054-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1390993850-9054-1-git-send-email-maxime.ripard@free-electrons.com>
 <1390993850-9054-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <52E9A8F0.8030901@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 29/01/14 08:10, Maxime Ripard escribi?:
> The Allwinner A31 has a new SPI controller IP compared to the older Allwinner
> SoCs.
>
> It supports DMA, but the driver only does PIO for now, and DMA will be
> supported eventually.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
(snip)
> +	struct sun6i_spi *sspi = spi_master_get_devdata(master);
> +	int ret;
> +
> +	ret = clk_prepare_enable(sspi->hclk);
> +	if (ret) {
> +		dev_err(dev, "Couldn't enable clock 'ahb spi'\n");
> +		goto out;
> +	}
> +
> +	ret = clk_prepare_enable(sspi->mclk);
> +	if (ret) {
> +		dev_err(dev, "Couldn't enable clock 'ahb spi'\n");

A different message would be nice :)

Cheers,

Emilio
