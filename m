From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Sep 2010 10:14:48 +0200
Subject: [PATCH] arm: fix use of clock disable on idle for simple AT91
	devices
In-Reply-To: <201009080122.o881MCXi015409@goober.internal.moreton.com.au>
References: <201009080122.o881MCXi015409@goober.internal.moreton.com.au>
Message-ID: <20100920081448.GC32018@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:22 Wed 08 Sep     , Greg Ungerer wrote:
> 
> Not all types of AT91 device have the PMC hardware unit. Don't do a
> clock disable at idle on those family members that don't have it.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  arch/arm/mach-at91/include/mach/system.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
> index c80e090..0bc497f 100644
> --- a/arch/arm/mach-at91/include/mach/system.h
> +++ b/arch/arm/mach-at91/include/mach/system.h
> @@ -28,7 +28,7 @@
>  
>  static inline void arch_idle(void)
>  {
> -#ifndef CONFIG_DEBUG_KERNEL
> +#if defined(AT91_PMC) && !defined(CONFIG_DEBUG_KERNEL)
we can do this on at91x40 also

Best Regards,
J.
