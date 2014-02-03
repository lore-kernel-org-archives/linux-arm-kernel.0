From: horms@verge.net.au (Simon Horman)
Date: Mon, 3 Feb 2014 15:31:15 +0900
Subject: [PATCH 3/3] ARM: fix HAVE_ARM_TWD selection for OMAP and shmobile
In-Reply-To: <1391294144-27787-4-git-send-email-robherring2@gmail.com>
References: <1391294144-27787-1-git-send-email-robherring2@gmail.com>
 <1391294144-27787-4-git-send-email-robherring2@gmail.com>
Message-ID: <20140203063114.GB30047@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

could you split the shmobile portion out into a separate patch
so that I can take it through my tree?

Thanks

On Sat, Feb 01, 2014 at 04:35:44PM -0600, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> The selection of HAVE_ARM_TWD for OMAP and shmobile depend on LOCAL_TIMER
> which no longer exists. They should depend on SMP instead.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-omap2/Kconfig    | 2 +-
>  arch/arm/mach-shmobile/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 653b489..e2ce4f8 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -54,7 +54,7 @@ config SOC_OMAP5
>  	select ARM_GIC
>  	select CPU_V7
>  	select HAVE_ARM_SCU if SMP
> -	select HAVE_ARM_TWD if LOCAL_TIMERS
> +	select HAVE_ARM_TWD if SMP
>  	select HAVE_SMP
>  	select HAVE_ARM_ARCH_TIMER
>  	select ARM_ERRATA_798181 if SMP
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 3386406..05fa505 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -8,7 +8,7 @@ config ARCH_SHMOBILE_MULTI
>  	select CPU_V7
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_ARM_SCU if SMP
> -	select HAVE_ARM_TWD if LOCAL_TIMERS
> +	select HAVE_ARM_TWD if SMP
>  	select HAVE_SMP
>  	select ARM_GIC
>  	select MIGHT_HAVE_CACHE_L2X0
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
