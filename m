From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 13 Dec 2009 20:57:21 +0100
Subject: [PATCH 2/4] mfd: mc13783: When probing, unlock the mc13783
	before subsystems initialisation.
In-Reply-To: <1260636819.2054.33.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<1260636819.2054.33.camel@climbing-alby>
Message-ID: <20091213195721.GB14024@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alberto,

On Sat, Dec 12, 2009 at 05:53:39PM +0100, Alberto Panizzo wrote:
> With this, mc13783 subsystems drivers can configure the mc13783 chip
> reading and writing registers.
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> ---
>  drivers/mfd/mc13783-core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/mc13783-core.c b/drivers/mfd/mc13783-core.c
> index aa1f79a..35dcc2a 100644
> --- a/drivers/mfd/mc13783-core.c
> +++ b/drivers/mfd/mc13783-core.c
> @@ -631,6 +631,8 @@ err_revision:
>  	}
>  	/* This should go away (END) */
>  
> +	mc13783_unlock(mc13783);
> +
>  	if (pdata->flags & MC13783_USE_ADC)
>  		mc13783_add_subdevice(mc13783, "mc13783-adc");
>  
> @@ -653,8 +655,6 @@ err_revision:
>  	if (pdata->flags & MC13783_USE_TOUCHSCREEN)
>  		mc13783_add_subdevice(mc13783, "mc13783-ts");
>  
> -	mc13783_unlock(mc13783);
> -
>  	return 0;
>  }
Looks reasonable.  You can take my Acked-by: for that.

Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
