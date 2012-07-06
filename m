From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Jul 2012 01:28:01 -0700
Subject: [PATCHv2 3/3] watchdog: omap_wdt: add device tree support
In-Reply-To: <1338525856-4359-4-git-send-email-jgq516@gmail.com>
References: <1338525856-4359-1-git-send-email-jgq516@gmail.com>
 <1338525856-4359-4-git-send-email-jgq516@gmail.com>
Message-ID: <20120706082801.GO1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

* jgq516 at gmail.com <jgq516@gmail.com> [120531 20:56]:
> From: Xiao Jiang <jgq516@gmail.com>
> 
> Add device table for omap_wdt to support dt.

Care to ack this patch in the series?

Regards,

Tony

> 
> Signed-off-by: Xiao Jiang <jgq516@gmail.com>
> ---
>  drivers/watchdog/omap_wdt.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 8285d65..02ebfd5 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -430,6 +430,12 @@ static int omap_wdt_resume(struct platform_device *pdev)
>  #define	omap_wdt_resume		NULL
>  #endif
>  
> +static const struct of_device_id omap_wdt_of_match[] = {
> +	{ .compatible = "ti,omap3-wdt", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, omap_wdt_of_match);
> +
>  static struct platform_driver omap_wdt_driver = {
>  	.probe		= omap_wdt_probe,
>  	.remove		= __devexit_p(omap_wdt_remove),
> @@ -439,6 +445,7 @@ static struct platform_driver omap_wdt_driver = {
>  	.driver		= {
>  		.owner	= THIS_MODULE,
>  		.name	= "omap_wdt",
> +		.of_match_table = omap_wdt_of_match,
>  	},
>  };
>  
> -- 
> 1.7.3
> 
