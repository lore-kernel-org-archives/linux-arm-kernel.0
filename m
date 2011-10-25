From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 25 Oct 2011 09:20:34 +0200
Subject: [PATCH] ARM: mx31pdk: Add MC13783 RTC support
In-Reply-To: <1319482929-28262-1-git-send-email-fabio.estevam@freescale.com>
References: <1319482929-28262-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20111025072034.GR15299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Mon, Oct 24, 2011 at 05:02:09PM -0200, Fabio Estevam wrote:
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
> index c20be75..e82778c 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -494,7 +494,8 @@ static struct mc13xxx_platform_data mc13783_pdata = {
>  		.regulators = mx31_3ds_regulators,
>  		.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
>  	},
> -	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
> +	.flags  = MC13XXX_USE_REGULATOR | MC13XXX_USE_TOUCHSCREEN |
> +							MC13XXX_USE_RTC,
ok in principle but (I think mfd in) next touches this already:

	$ git show next/master:arch/arm/mach-imx/mach-mx31_3ds.c | grep USE_TOUCH
		.flags  = MC13XXX_USE_TOUCHSCREEN,

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
