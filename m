From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 13 Feb 2010 11:50:29 +0100
Subject: i2c-imx: Autoprobe of eeproms
In-Reply-To: <4B75D317.7040801@vmlinux.org>
References: <4B75D317.7040801@vmlinux.org>
Message-ID: <20100213105029.GA14254@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2010 at 11:15:51PM +0100, Mattias Walstrom wrote:
> I have tried to get autoprobe of eeproms to work on a custom freescale
> mx27-board, and i found out that the i2c-imx driver was missing the
> following, is there a reason for this, most other i2c-bus drivers seems
> to have it?
> 
> --- linux-2.6.32.8.orig/drivers/i2c/busses/i2c-imx.c    2010-02-09
> 13:57:19.000000000 +0100
> +++ linux-2.6.32.8/drivers/i2c/busses/i2c-imx.c 2010-02-12
> 11:30:12.000000000 +0100
> @@ -521,6 +521,7 @@
>         i2c_imx->adapter.algo           = &i2c_imx_algo;
>         i2c_imx->adapter.dev.parent     = &pdev->dev;
>         i2c_imx->adapter.nr             = pdev->id;
> +        i2c_imx->adapter.class          = I2C_CLASS_HWMON | I2C_CLASS_SPD;
>         i2c_imx->irq                    = irq;
>         i2c_imx->base                   = base;
>         i2c_imx->res                    = res;
Your patch is broken.  drivers/i2c/busses/i2c-imx.c uses tabs for
indention, not spaces.

(Note, this doesn't mean I'd ack your patch, see Wolfram's reply.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
