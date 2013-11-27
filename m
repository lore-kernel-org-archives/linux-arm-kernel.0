From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 27 Nov 2013 13:16:26 +0000
Subject: [PATCH v4 4/5] regulator: max14577: Add regulator driver for
 Maxim 14577
In-Reply-To: <1385135469-27044-5-git-send-email-k.kozlowski@samsung.com>
References: <1385135469-27044-1-git-send-email-k.kozlowski@samsung.com>
 <1385135469-27044-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131127131626.GH3296@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> MAX14577 chip is a multi-function device which includes MUIC,
> charger and voltage regulator. The driver is located in drivers/mfd.
> 
> This patch adds regulator driver for MAX14577 chip. There are two
> regulators in this chip:
> 1. Safeout LDO with constant voltage output of 4.9V. It can be only
>    enabled or disabled.
> 2. Current regulator for the charger. It provides current from 90mA up
>    to 950mA.
> Driver supports Device Tree.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mfd/max14577.c       |    3 +-
>  drivers/regulator/Kconfig    |    7 ++
>  drivers/regulator/Makefile   |    1 +
>  drivers/regulator/max14577.c |  268 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 278 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/regulator/max14577.c
> 
> diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
> index 94b766d..d841f2a 100644
> --- a/drivers/mfd/max14577.c
> +++ b/drivers/mfd/max14577.c
> @@ -26,7 +26,8 @@
>  
>  static struct mfd_cell max14577_devs[] = {
>  	{ .name = "max14577-muic", },
> -	{ .name = "max14577-regulator", },
> +	{ .name = "max14577-regulator",
> +		.of_compatible = "maxim,max14577-regulator", },
>  	{ .name = "max14577-charger", },
>  };

If you separate this patch out and make it look 'normal' i.e. sort out
the indenting, I'll apply it. Instead of this randomness, I expect to
see something like: 

> +	 {
> +	        .name = "max14577-regulator",
> +	        .of_compatible = "maxim,max14577-regulator", 
> +	 },


-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
