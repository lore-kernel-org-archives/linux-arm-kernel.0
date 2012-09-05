From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 05 Sep 2012 10:50:28 +0200
Subject: [PATCH 4/8] gpio: 74x164: Add device tree support
In-Reply-To: <1346834457-6257-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <3289095.PtLZhVmAnO@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 September 2012 10:40:53 Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>  drivers/gpio/gpio-74x164.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
> index 24cfe4c..613067c 100644
> --- a/drivers/gpio/gpio-74x164.c
> +++ b/drivers/gpio/gpio-74x164.c
> @@ -141,10 +141,17 @@ static int __devexit gen_74x164_remove(struct 
spi_device *spi)
>  	return ret;
>  }
>  
> +static const struct of_device_id gen_74x164_dt_ids[] = {
> +	{ .compatible = "fairchild,74hc595" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gen_74x164_dt_ids);
> +
>  static struct spi_driver gen_74x164_driver = {
>  	.driver = {
>  		.name		= "74x164",
>  		.owner		= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(gen_74x164_dt_ids),
>  	},
>  	.probe		= gen_74x164_probe,
>  	.remove		= __devexit_p(gen_74x164_remove),
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
