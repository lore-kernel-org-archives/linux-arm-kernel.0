From: david@lechnology.com (David Lechner)
Date: Mon, 25 Jun 2018 11:00:11 -0500
Subject: [PATCH 3/9] ARM: davinci: da850-evm: use aemif platform driver in
 legacy mode
In-Reply-To: <20180625152920.11549-4-brgl@bgdev.pl>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-4-brgl@bgdev.pl>
Message-ID: <13418bf6-dbe7-5091-b5a7-07f779fb9f63@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We now support board files in the aemif driver. Register a platform
> device instead of using the handcrafted API in da850-evm.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

> -	iounmap(aemif_addr);
> -}
> +static struct platform_device da850_evm_aemif_device = {
> +	.name		= "ti-aemif",
> +	.dev = {
> +		.platform_data	= &da850_evm_aemif_pdata,
> +	},
> +	.resource	= da850_evm_aemif_resource,
> +	.num_resources	= ARRAY_SIZE(da850_evm_aemif_resource),
> +	.id		= -1,
> +};
> 

Not essential, but it is nice to have the id right after name
since they are closely related (as you did in several other
instances in this same patch). For a second, I thought you
forgot id = -1 here before I saw it.
