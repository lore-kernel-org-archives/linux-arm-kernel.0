From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 16 Sep 2016 11:32:20 +0200
Subject: [PATCH] ARM: Kconfig: select GENERIC_CLOCKEVENTS_BROADCAST also
 on UP
In-Reply-To: <1467993522-9176-1-git-send-email-l.stach@pengutronix.de>
References: <1467993522-9176-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1474018340.2243.103.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

can you please take a look at this and tell if there is something wrong
about it, or if you think it can go in?

Without this patch the kernel is unable to use the deeper CPU idle
states on i.MX6S if it isn't built with SMP support enabled.

Regards,
Lucas

Am Freitag, den 08.07.2016, 17:58 +0200 schrieb Lucas Stach:
> Quite a few systems have deeper idle states where the local timer tick
> stops to fire, that rely on the GENERIC_CLOCKEVENTS_BROADCAST
> infrastructure to switch to a global (non-stopping) clockevent device.
> This is also true on UP systems, so select GENERIC_CLOCKEVENTS_BROADCAST
> unconditionally.
> 
> Instead only select ARCH_HAS_TICK_BROADCAST if SMP is present, as this
> is only implemented for SMP systems.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 90542db1220d..745843ea769c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -4,7 +4,7 @@ config ARM
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
> -	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> +	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST && SMP
>  	select ARCH_HAVE_CUSTOM_GPIO_H
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
> @@ -20,7 +20,7 @@ config ARM
>  	select EDAC_ATOMIC_SCRUB
>  	select GENERIC_ALLOCATOR
>  	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
> -	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> +	select GENERIC_CLOCKEVENTS_BROADCAST
>  	select GENERIC_EARLY_IOREMAP
>  	select GENERIC_IDLE_POLL_SETUP
>  	select GENERIC_IRQ_PROBE
