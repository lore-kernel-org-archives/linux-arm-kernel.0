From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 3 Nov 2009 22:54:51 +0000
Subject: s3cmci: convert missed s3c2410_gpio calls to gpiolib calls
In-Reply-To: <20091103225007.605753048@fluff.org.uk>
References: <20091103225007.605753048@fluff.org.uk>
Message-ID: <20091103225451.GA10599@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 10:50:07PM +0000, Ben Dooks wrote:
> Convert two missed s3c2410 specific gpio calls to gpiolib calls.
> 
> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>
> 
> ---
>  drivers/mmc/host/s3cmci.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> Index: b/drivers/mmc/host/s3cmci.c
> ===================================================================
> --- a/drivers/mmc/host/s3cmci.c	2009-11-03 22:17:12.000000000 +0000
> +++ b/drivers/mmc/host/s3cmci.c	2009-11-03 22:22:33.000000000 +0000
> @@ -1302,10 +1302,8 @@ static int s3cmci_get_ro(struct mmc_host
>  	if (pdata->no_wprotect)
>  		return 0;
>  
> -	ret = s3c2410_gpio_getpin(pdata->gpio_wprotect);
> -
> -	if (pdata->wprotect_invert)
> -		ret = !ret;
> +	ret = s3c2410_gpio_getpin(pdata->gpio_wprotect) ? 1 : 0;
> +	ret ^= pdata->wprotect_invert;

gah, should have been gpio_get_value(), reposted.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
