From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 5 Feb 2010 08:51:41 +0100
Subject: [PATCH] input: schedule corgi_ssp and corgi_ts to be removed
In-Reply-To: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
References: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
Message-ID: <20100205075141.GA31903@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> diff --git a/Documentation/feature-removal-schedule.txt
> b/Documentation/feature-removal-schedule.txt
> index 5860583..e16529e 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -554,3 +554,15 @@ Why:	We now have a generic GPIO based matrix
> keyboard driver that
>  	and so are difficult to maintain.
>  Who:	Eric Miao <eric.y.miao@gmail.com>
> 
> +----------------------------
> +
> +What:	corgi_ssp and corgi_ts driver
> +When:	2.6.35
> +Files:	arch/arm/mach-pxa/corgi_ssp.c, drivers/input/touchscreen/corgi_ts.c
> +Why:	The corgi touchscreen is now deprecated in favour of the generic
> +	ads7846.c driver. The noise reduction technique used in corgi_ts.c
> +	that to wait til vsync before ADC sampling is also inte grated into
> +	ads7846 driver now. Provided that the original driver is no generic
s/no /not / or s/is no/isn't/

Best regards
Uwe

> +	and difficult to maintain, will be removed later.
> +Who:	Eric Miao <eric.y.miao@gmail.com>
> +

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
