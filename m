From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Jul 2011 09:50:52 +0200
Subject: [PATCH] Enable RTC driver.
In-Reply-To: <1309872931-13999-1-git-send-email-J.Lambrecht@televic.com>
References: <1309872931-13999-1-git-send-email-J.Lambrecht@televic.com>
Message-ID: <20110706075052.GB26347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 03:35:31PM +0200, J?rgen Lambrecht wrote:
> The MC13783 MFD also contains an RTC. Enable it.
> To avoid "No RTC device found, ALARM timers will not wake from suspend",
> this patch is needed:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c008ba58af24dc5d0d8e9fe6e59d876910254761
> 
> Signed-off-by: J?rgen Lambrecht <J.Lambrecht@televic.com>

Applied for next. Please Cc me in the future for i.MX specific changes.

Sascha

> ---
>  arch/arm/mach-imx/mach-mx27_3ds.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
> index 84114aa..00bbb6b 100644
> --- a/arch/arm/mach-imx/mach-mx27_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx27_3ds.c
> @@ -294,7 +294,8 @@ static struct mc13xxx_platform_data mc13783_pdata = {
>  		.num_regulators = ARRAY_SIZE(mx27_3ds_regulators),
>  
>  	},
> -	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
> +	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN |
> +	MC13783_USE_RTC,
>  };
>  
>  /* SPI */
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
