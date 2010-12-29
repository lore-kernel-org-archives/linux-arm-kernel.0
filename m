From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 11:50:01 +0100
Subject: [PATCH 07/10] ARM: mx28: add the second fec device registration
In-Reply-To: <1293548155-16328-8-git-send-email-shawn.guo@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-8-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101229105001.GW14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

> -static const struct fec_platform_data mx28_fec_pdata __initconst = {
> -	.phy = PHY_INTERFACE_MODE_RMII,
> +static struct fec_platform_data mx28_fec_pdata[] = {
> +	{
> +		/* fec0 */
> +		.phy = PHY_INTERFACE_MODE_RMII,
> +	}, {
> +		/* fec1 */
> +		.phy = PHY_INTERFACE_MODE_RMII,
> +	},
>  };
I think there is no need to duplicate the platform_data as mx28_add_fec
makes a copy anyhow.  Did you remove __initconst and const on purpose?

>  static void __init mx28evk_init(void)
> @@ -117,7 +136,10 @@ static void __init mx28evk_init(void)
>  	mx28_add_duart();
>  
>  	mx28evk_fec_reset();
> -	mx28_add_fec(0, &mx28_fec_pdata);
> +	mx28_add_fec(0, &mx28_fec_pdata[0]);
> +#ifdef CONFIG_FEC2
> +	mx28_add_fec(1, &mx28_fec_pdata[1]);
> +#endif
>  }
>  
>  static void __init mx28evk_timer_init(void)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
