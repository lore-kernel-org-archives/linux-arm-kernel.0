From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 3 Dec 2009 22:07:18 +0000
Subject: [PATCH 15/38] move s3c_adc_remove to .devexit.text
In-Reply-To: <1259096853-18909-15-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1259096853-18909-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-15-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091203220718.GS4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 10:07:10PM +0100, Uwe Kleine-K?nig wrote:
> The function s3c_adc_remove is used only wrapped by __devexit_p so define
> it using __devexit.

Shall I put these into my tree?
 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Acked-By: Ben Dooks <ben@simtec.co.uk>
> Cc: Ramax Lo <ramaxlo@gmail.com>
> Cc: Nelson Castillo <arhuaco@freaks-unidos.net>
> Cc: linux-kernel at vger.kernel.org
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/plat-s3c24xx/adc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c24xx/adc.c
> index df47322..ce47627 100644
> --- a/arch/arm/plat-s3c24xx/adc.c
> +++ b/arch/arm/plat-s3c24xx/adc.c
> @@ -365,7 +365,7 @@ static int s3c_adc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int s3c_adc_remove(struct platform_device *pdev)
> +static int __devexit s3c_adc_remove(struct platform_device *pdev)
>  {
>  	struct adc_device *adc = platform_get_drvdata(pdev);
>  
> -- 
> 1.6.5.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
