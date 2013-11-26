From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Tue, 26 Nov 2013 16:30:00 +0000
Subject: [PATCH v2 4/4] ARM: ep93xx: stop using mach/timex.h
In-Reply-To: <1385472566-20950-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384292466-31725-5-git-send-email-u.kleine-koenig@pengutronix.de>
 <1385472566-20950-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8817E073F0@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 26, 2013 6:29 AM, Uwe Kleine-K?nig wrote:
> mach/timex.h is the last remaining header that is unused for multiarch
> builds but necessary for singlearch builds. To allow to get rid of it
> for singlearch builds, too, drop its usage in ep93xx arch code by
> substituting CLOCK_TICK_RATE by an already defined local cpp symbol.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> ---
> Changes since (implicit) v1, sent with
> Message-Id: 1384292466-31725-5-git-send-email-u.kleine-koenig at pengutronix.de:
>  - ack by H Hartley Sweeten
>  - use already existing symbol instead of introducing a new one
>
>  arch/arm/mach-ep93xx/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index d95ee28a..94b141f 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -115,7 +115,7 @@ void __init ep93xx_map_io(void)
>  #define EP93XX_TIMER4_CLOCK		983040
>  
>  #define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
> -#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(CLOCK_TICK_RATE, HZ)
> +#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(EP93XX_TIMER4_CLOCK, HZ)
>  
>  static unsigned int last_jiffy_time;

Thanks,
Hartley
