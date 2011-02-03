From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Feb 2011 09:15:08 +0100
Subject: [PATCH] ARM: omap1/nokia770: mark some functions __init
In-Reply-To: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100902054630.GB14214@pengutronix.de>
	<1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110203081508.GC30452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Tony,

this patch below is now 4 months old and I didn't get any feedback.  (Though I
somehow missed to cc linux-omap at vger.kernel.org before, sorry for that.)

There are two more patches in this thread that are not yet
applied/commented.  Should I resend?

Best regards
Uwe

On Thu, Sep 02, 2010 at 08:17:10AM +0200, Uwe Kleine-K?nig wrote:
> These are only called from omap_nokia770_init which is in .init.text, too.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-omap1/board-nokia770.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
> index 51a4539..09b3f46 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -112,7 +112,7 @@ static struct mipid_platform_data nokia770_mipid_platform_data = {
>  	.shutdown = mipid_shutdown,
>  };
>  
> -static void mipid_dev_init(void)
> +static void __init mipid_dev_init(void)
>  {
>  	const struct omap_lcd_config *conf;
>  
> @@ -123,7 +123,7 @@ static void mipid_dev_init(void)
>  	}
>  }
>  
> -static void ads7846_dev_init(void)
> +static void __init ads7846_dev_init(void)
>  {
>  	if (gpio_request(ADS7846_PENDOWN_GPIO, "ADS7846 pendown") < 0)
>  		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
> @@ -167,7 +167,7 @@ static struct hwa742_platform_data nokia770_hwa742_platform_data = {
>  	.te_connected		= 1,
>  };
>  
> -static void hwa742_dev_init(void)
> +static void __init hwa742_dev_init(void)
>  {
>  	clk_add_alias("hwa_sys_ck", NULL, "bclk", NULL);
>  	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
> -- 
> 1.7.1

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
