From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Jan 2014 09:48:08 +0000
Subject: [RFC 01/18] mfd: syscon: Consider platform data a regmap config
 name
In-Reply-To: <1387815830-8794-2-git-send-email-pawel.moll@arm.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-2-git-send-email-pawel.moll@arm.com>
Message-ID: <20140106094808.GG23772@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Use the device platform data as a regmap config
> name. This is particularly useful in the regmap
> debugfs when there is more than one syscon device
> registered, to distinguish the register blocks.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/syscon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 71841f9..ea1770b 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -143,6 +143,7 @@ static int syscon_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	syscon_regmap_config.max_register = res->end - res->start - 3;
> +	syscon_regmap_config.name = dev_get_platdata(&pdev->dev);
>  	syscon->regmap = devm_regmap_init_mmio(dev, base,
>  					&syscon_regmap_config);
>  	if (IS_ERR(syscon->regmap)) {

This smells a bit fishy to me. Can you point me to the piece of code
or patch where you set the platform_data pointer as a string?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
