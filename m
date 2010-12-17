From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 17 Dec 2010 21:21:04 +0800
Subject: [PATCH 17/40] ARM: nuc: update clock source registration
In-Reply-To: <E1PTYgL-0006ik-RX@rmk-PC.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYgL-0006ik-RX@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTin6Z6NXY+rF4_PUmnhuomzuSQrCzUKvD9tXk19H@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of the
> divisor shift/mult constants. ?Switch over to using this new interface.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/mach-w90x900/time.c | ? ?5 +----
> ?1 files changed, 1 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-w90x900/time.c b/arch/arm/mach-w90x900/time.c
> index b80f769..4b089cb 100644
> --- a/arch/arm/mach-w90x900/time.c
> +++ b/arch/arm/mach-w90x900/time.c
> @@ -153,7 +153,6 @@ static struct clocksource clocksource_nuc900 = {
> ? ? ? ?.rating = 200,
> ? ? ? ?.read ? = nuc900_get_cycles,
> ? ? ? ?.mask ? = CLOCKSOURCE_MASK(TDR_SHIFT),
> - ? ? ? .shift ?= 10,
> ? ? ? ?.flags ?= CLOCK_SOURCE_IS_CONTINUOUS,
> ?};
>
> @@ -176,9 +175,7 @@ static void __init nuc900_clocksource_init(void)
> ? ? ? ?val |= (COUNTEN | PERIOD | PRESCALE);
> ? ? ? ?__raw_writel(val, REG_TCSR1);
>
> - ? ? ? clocksource_nuc900.mult =
> - ? ? ? ? ? ? ? clocksource_khz2mult((rate / 1000), clocksource_nuc900.shift);
> - ? ? ? clocksource_register(&clocksource_nuc900);
> + ? ? ? clocksource_register_hz(&clocksource_nuc900, rate);
> ?}
>
> ?static void __init nuc900_timer_init(void)

Acked-by: Wan zongshun <mcuos.com@gmail.com>

> --
> 1.6.2.5
>
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
