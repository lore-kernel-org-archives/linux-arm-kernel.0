From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Feb 2011 10:51:47 +0000
Subject: [alsa-devel] [PATCH] EDB93xx: Add support for CS4271 CODEC on
	EDB93xx boards
In-Reply-To: <1296603653.1504.9.camel@r60e>
References: <1296603653.1504.9.camel@r60e>
Message-ID: <20110202105146.GA9810@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 02:40:53AM +0300, Alexander Sverdlin wrote:

> +	err = gpio_request(gpio_nreset, spi->modalias);
> +	if (err)
> +		return err;
> +	err = gpio_request(EP93XX_GPIO_LINE_EGPIO6, spi->modalias);
> +	if (err)
> +		return err;
> +
> +	gpio_direction_output(EP93XX_GPIO_LINE_EGPIO6, 1);

Why is this stuff in the arch/arm code?  I'd expect driver to deal with
all this sequencing.
