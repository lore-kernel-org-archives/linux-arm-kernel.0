From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Nov 2010 10:59:20 +0100
Subject: [PATCH] pcmcia/sa1100: don't put machine specific init
	functions in .init.text
In-Reply-To: <1288863974-20434-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1288863974-20434-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20101104095920.GB16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> [..]
> diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
> index 945857f..6b22859 100644
> --- a/drivers/pcmcia/sa1100_generic.c
> +++ b/drivers/pcmcia/sa1100_generic.c
> @@ -64,7 +64,7 @@ static int (*sa11x0_pcmcia_hw_init[])(struct device *dev) = {
>  #endif
>  };
>  
> -static int sa11x0_drv_pcmcia_probe(struct platform_device *dev)
> +static int __devinit sa11x0_drv_pcmcia_probe(struct platform_device *dev)
>  {
>  	int i, ret = -ENODEV;
>  
BTW, I wonder why sa11x0_pcmcia_hw_init doesn't need to be annotated
with __devinitdata.  I guess the compiler just put's the array into
sa11x0_drv_pcmcia_probe and so modpost doesn't notice.

If you care I can resend with sa11x0_pcmcia_hw_init being marked, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
