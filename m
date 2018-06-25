From: david@lechnology.com (David Lechner)
Date: Mon, 25 Jun 2018 11:08:57 -0500
Subject: [PATCH 2/9] ARM: davinci: omapl138-hawk: add aemif & nand support
In-Reply-To: <20180625152920.11549-3-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-3-brgl@bgdev.pl>
Message-ID: <41248083-69db-4b88-8a11-e7fa2bd06718@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now have support for aemif & nand from board files. As an example
> add support for nand to da850-hawk.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

> +static struct platform_device omapl138_hawk_aemif_devices[] = {
> +	{
> +		.name		= "davinci_nand",
> +		.id		= 1,

same comment as on da850-evm...

this might need id = 0 now.

> +		.dev		= {
> +			.platform_data	= &omapl138_hawk_nandflash_data,
> +		},
> +		.resource	= omapl138_hawk_nandflash_resource,
> +		.num_resources	= ARRAY_SIZE(omapl138_hawk_nandflash_resource),
> +	}
> +};
