From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Mar 2012 11:03:47 +0100
Subject: [PATCH 6/7] ARM: kirkwood: rtc-mv devicetree bindings
In-Reply-To: <0b9921e304cb46af9c4fbc8b7b8c8b9ba3d18654.1331601448.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <cover.1331601448.git.jason@lakedaemon.net>
 <0b9921e304cb46af9c4fbc8b7b8c8b9ba3d18654.1331601448.git.jason@lakedaemon.net>
Message-ID: <20120313100347.GA10400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 01:57:48AM +0000, Jason Cooper wrote:
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  drivers/rtc/rtc-mv.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
> index 768e2ed..0dd8421 100644
> --- a/drivers/rtc/rtc-mv.c
> +++ b/drivers/rtc/rtc-mv.c
> @@ -12,6 +12,7 @@
>  #include <linux/bcd.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
>  #include <linux/delay.h>
>  #include <linux/gfp.h>
>  #include <linux/module.h>
> @@ -294,11 +295,19 @@ static int __exit mv_rtc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id rtc_mv_of_match_table[] = {
> +	{ .compatible = "mrvl,orion-rtc", },
> +	{}
> +};
> +#endif
I guess it's a matter of taste, but you could use __maybe_unused instead
of #ifdef .. #endif.

Best regards
Uwe

> +
>  static struct platform_driver mv_rtc_driver = {
>  	.remove		= __exit_p(mv_rtc_remove),
>  	.driver		= {
>  		.name	= "rtc-mv",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(rtc_mv_of_match_table),
>  	},
>  };
>  
> -- 
> 1.7.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
