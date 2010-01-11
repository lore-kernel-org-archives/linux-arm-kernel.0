From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Jan 2010 10:33:39 +0000
Subject: [PATCH 1/3] ARM: SAMSUNG: Add config option for number of
	additional GPIO pins.
In-Reply-To: <1263203046-29219-1-git-send-email-kgene.kim@samsung.com>
References: <1263203046-29219-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100111103338.GA3440@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 06:44:06PM +0900, Kukjin Kim wrote:

> +config SAMSUNG_GPIO_EXTRA
> +	int "Number of additional GPIO pins"
> +	default 0
> +	help
> +	  Use additional GPIO space in addition to the GPIO's the SOC
> +	  provides. This allows expanding the GPIO space for use with
> +	  GPIO expanders.
> +

The way this has been handled for previous Samsung variants is to make
it entirely hidden from users and provide selectable values for defining
the number so you end up with something like:

	config SAMSUNG_GPIO_EXTRA
	int
	default 64 if SAMSUNG_GPIO_64
	default 32 if SAMSUNG_GPIO_32
	default 0

The board drivers then select one of the numeric options.  They should
know how many GPIOs they need, while end users rebuilding their kernels
don't need to know this since at least code if not hardware changes will
be required to change it usefully.
