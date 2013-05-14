From: csd@broadcom.com (Christian Daudt)
Date: Tue, 14 May 2013 07:53:24 -0700
Subject: [PATCH] ARM: mach-bcm: drop "select GPIO_BCM"
In-Reply-To: <1368524085.1350.102.camel@x61.thuisdomein>
References: <1368524085.1350.102.camel@x61.thuisdomein>
Message-ID: <51924FE4.5000803@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-05-14 02:34 AM, Paul Bolle wrote:
> A select statement for the Kconfig symbol GPIO_BCM was added in v3.8.
> But there's no symbol with that name. It's a nop so we can drop it.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Untested.
>
> 1) Patch assumes that https://lkml.org/lkml/2013/3/6/182 ("ARM:
> mach-bcm: drop "select GENERIC_TIME""), which got a Reviewed-by tag from
> Christian, was applied first.
>
>   arch/arm/mach-bcm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 764273e..322620d 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -8,7 +8,6 @@ config ARCH_BCM
>   	select CPU_V7
>   	select CLKSRC_OF
>   	select GENERIC_CLOCKEVENTS
> -	select GPIO_BCM
>   	select SPARSE_IRQ
>   	select TICK_ONESHOT
>   	help
Hi Paul,
  We are planning on submitting the driver for this option for review 
over the next couple of weeks, to get it in the 3.11 cycle. So this 
patch won't be necessary.

  Thanks,
    csd
