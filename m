From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 16 Nov 2012 14:56:52 +0100
Subject: [PATCH 09/11] watchdog/at91sam9_wdt: add support to device tree
In-Reply-To: <1352877369-19740-10-git-send-email-wenyou.yang@atmel.com>
References: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
 <1352877369-19740-10-git-send-email-wenyou.yang@atmel.com>
Message-ID: <50A64624.6010902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2012 08:16 AM, Wenyou Yang :
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

No. The work has already been done by Fabio Porcedda and he managed to
sustain the discussion and reach a consensus at his v9 patch series: so
please take into account his work and build yours on top of his patch
series.

Best regards,

> Cc: grant.likely at secretlab.ca
> Cc: rob.herring at calxeda.com
> Cc: devicetree-discuss at lists.ozlabs.org
> ---
>  drivers/watchdog/at91sam9_wdt.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index e7ce9ea..cba5c5d 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -32,6 +32,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/timer.h>
>  #include <linux/bitops.h>
> +#include <linux/of.h>
>  
>  #include "at91sam9_wdt.h"
>  
> @@ -251,12 +252,21 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id at91wdt_match[] = {
> +	{ .compatible = "atmel,at91sam-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, at91wdt_match);
> +#endif
> +
>  static struct platform_driver at91wdt_driver = {
>  	.probe		= at91wdt_probe,
>  	.remove		= __exit_p(at91wdt_remove),
>  	.driver		= {
>  		.name	= "at91_wdt",
>  		.owner	= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(at91wdt_match),
>  	},
>  };
>  
> 


-- 
Nicolas Ferre
