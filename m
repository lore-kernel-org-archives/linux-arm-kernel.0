From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 19 Oct 2012 16:28:15 +0800
Subject: [PATCH 1/2] spi: spidev: Add device tree bindings
In-Reply-To: <1350568768-4374-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1350568768-4374-1-git-send-email-maxime.ripard@free-electrons.com>
 <1350568768-4374-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20121019082811.GB21078@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark is maintaining spi subsystem recently as Grant has been off line
for a while.

Shawn

On Thu, Oct 18, 2012 at 03:59:27PM +0200, Maxime Ripard wrote:
> This will allow to probe spidev from device tree
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/spi/spidev.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 830adbe..8ae0660 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -31,6 +31,8 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/compat.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spidev.h>
> @@ -642,10 +644,18 @@ static int __devexit spidev_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id spidev_dt_ids[] = {
> +	{ .compatible = "linux,spidev" },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, spidev_dt_ids);
> +
>  static struct spi_driver spidev_spi_driver = {
>  	.driver = {
>  		.name =		"spidev",
>  		.owner =	THIS_MODULE,
> +		.of_match_table = of_match_ptr(spidev_dt_ids),
>  	},
>  	.probe =	spidev_probe,
>  	.remove =	__devexit_p(spidev_remove),
> -- 
> 1.7.9.5
> 
