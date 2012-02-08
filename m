From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 8 Feb 2012 17:26:39 +0100
Subject: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
In-Reply-To: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
References: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20120208162639.GJ15647@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 +
> +static int spi_sirfsoc_setup(struct spi_device *spi)
> +{
> +	struct spi_bitbang *bitbang;
> +	struct sirfsoc_spi *sspi;
> +
> +	if (!spi->max_speed_hz)
> +		return -EINVAL;
> +
> +	sspi = spi_master_get_devdata(spi->master);
> +	bitbang = &sspi->bitbang;
why do you need this?
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;
> +
> +	return spi_sirfsoc_setup_transfer(spi, NULL);
> +}

Best Regards,
J.
