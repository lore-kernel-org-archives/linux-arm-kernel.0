From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 27 Aug 2010 07:35:47 +0200
Subject: [PATCH] i2c-pxa: Squash warning about discarding qualifier
In-Reply-To: <1282795885-4445-1-git-send-email-marek.vasut@gmail.com>
References: <1282795885-4445-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <20100827053547.GB17521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 26, 2010 at 06:11:25AM +0200, Marek Vasut wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  drivers/i2c/busses/i2c-pxa.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 020ff23..c94e51b 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1001,7 +1001,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	struct pxa_i2c *i2c;
>  	struct resource *res;
>  	struct i2c_pxa_platform_data *plat = dev->dev.platform_data;
> -	struct platform_device_id *id = platform_get_device_id(dev);
> +	const struct platform_device_id *id = platform_get_device_id(dev);
>  	int ret;
>  	int irq;
This is already in mainline:

http://git.kernel.org/linus/21e2ecfe19df8f28408b5a607fef8704f51fa7f8

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
