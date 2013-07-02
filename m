From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 01 Jul 2013 17:07:43 -0700
Subject: [PATCH 2/4] davinci: da8xx/omap-l1: Remove hard coding of rtc
 device wakeup
In-Reply-To: <1372412109-986-3-git-send-email-gururaja.hebbar@ti.com> (Hebbar
 Gururaja's message of "Fri, 28 Jun 2013 15:05:07 +0530")
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-3-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <87a9m5omcw.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hebbar Gururaja <gururaja.hebbar@ti.com> writes:

> Since now rtc-omap driver itself calls deice_init_wakeup(dev, true),
> duplicate call from the rtc device registration can be removed.
>
> This is basically a partial revert of the prev commit
>
> commit 75c99bb0006ee065b4e2995078d779418b0fab54
> Author: Sekhar Nori <nsekhar@ti.com>
>
>     davinci: da8xx/omap-l1: mark RTC as a wakeup source
>
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
>
> ---
> :100644 100644 bf57252... 85a900c... M	arch/arm/mach-davinci/devices-da8xx.c
>  arch/arm/mach-davinci/devices-da8xx.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index bf57252..85a900c 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -827,14 +827,7 @@ static struct platform_device da8xx_rtc_device = {
>  
>  int da8xx_register_rtc(void)
>  {
> -	int ret;
> -
> -	ret = platform_device_register(&da8xx_rtc_device);
> -	if (!ret)
> -		/* Atleast on DA850, RTC is a wakeup source */
> -		device_init_wakeup(&da8xx_rtc_device.dev, true);
> -
> -	return ret;
> +	return  platform_device_register(&da8xx_rtc_device);

nit: extra space between 'return' and 'platform_'

>  }
>  
>  static void __iomem *da8xx_ddr2_ctlr_base;

Otherwise,

Acked-by: Kevin Hilman <khilman@linaro.org>
