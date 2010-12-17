From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 17 Dec 2010 13:49:39 +0900
Subject: [PATCH 13/24] ARM: s5pv310: update clock source registration
In-Reply-To: <E1PSDvg-0008D8-6F@rmk-PC.arm.linux.org.uk>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDvg-0008D8-6F@rmk-PC.arm.linux.org.uk>
Message-ID: <002f01cb9da5$d30eac70$792c0550$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of the
> divisor shift/mult constants.  Switch over to using this new interface.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>  arch/arm/mach-s5pv310/time.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-s5pv310/time.c b/arch/arm/mach-s5pv310/time.c
> index 01b012a..b262d46 100644
> --- a/arch/arm/mach-s5pv310/time.c
> +++ b/arch/arm/mach-s5pv310/time.c
> @@ -211,7 +211,6 @@ struct clocksource pwm_clocksource = {
>  	.rating		= 250,
>  	.read		= s5pv310_pwm4_read,
>  	.mask		= CLOCKSOURCE_MASK(32),
> -	.shift		= 20,
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS ,
>  };
> 
> @@ -230,10 +229,7 @@ static void __init s5pv310_clocksource_init(void)
>  	s5pv310_pwm_init(4, ~0);
>  	s5pv310_pwm_start(4, 1);
> 
> -	pwm_clocksource.mult =
> -		clocksource_khz2mult(clock_rate/1000,
pwm_clocksource.shift);
> -
> -	if (clocksource_register(&pwm_clocksource))
> +	if (clocksource_register_hz(&pwm_clocksource, clock_rate))
>  		panic("%s: can't register clocksource\n",
> pwm_clocksource.name);
>  }
> 
> --

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
