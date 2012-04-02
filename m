From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 2 Apr 2012 11:06:53 +0200
Subject: [PATCH] ARM: imx/mx21ads: remove unneeded cast
In-Reply-To: <1333051138-27360-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1333051138-27360-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120402090653.GO3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 09:58:58PM +0200, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-imx/mach-mx21ads.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
> index e432d4a..d14bbe9 100644
> --- a/arch/arm/mach-imx/mach-mx21ads.c
> +++ b/arch/arm/mach-imx/mach-mx21ads.c
> @@ -304,8 +304,7 @@ static void __init mx21ads_board_init(void)
>  	imx21_add_mxc_nand(&mx21ads_nand_board_info);
>  
>  	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
> -	platform_device_register_full(
> -			(struct platform_device_info *)&mx21ads_cs8900_devinfo);
> +	platform_device_register_full(&mx21ads_cs8900_devinfo);

Applied, thanks

Sascha

>  }
>  
>  static void __init mx21ads_timer_init(void)
> -- 
> 1.7.9.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
