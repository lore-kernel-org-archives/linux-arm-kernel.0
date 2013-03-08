From: csd_b@daudt.org (Christian Daudt)
Date: Thu, 7 Mar 2013 19:18:31 -0800
Subject: [PATCH] ARM: mach-bcm: drop "select GENERIC_TIME"
In-Reply-To: <1362563553.16460.166.camel@x61.thuisdomein>
References: <1362563553.16460.166.camel@x61.thuisdomein>
Message-ID: <CAGFynZ-CBRMGAwgF+xjAU_R8QPHhS_wtQgxgmW9JPVsjohOi2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My bad. Thanks for the fix !

Reviewed-by: Christian Daudt <csd@broadcom.com>


 Thanks,
   csd


On Wed, Mar 6, 2013 at 1:52 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> The Kconfig symbol GENERIC_TIME was removed from the kernel in v2.6.36,
> with commit 592913ecb87a9e06f98ddb55b298f1a66bf94c6b ("time: Kill off
> CONFIG_GENERIC_TIME"). Somehow this select statement still popped up
> recently. It's a nop so we can drop it.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Tested with "git grep" only.
>
>  arch/arm/mach-bcm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index bf02471..be4a0a1 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -7,7 +7,6 @@ config ARCH_BCM
>         select ARM_GIC
>         select CPU_V7
>         select GENERIC_CLOCKEVENTS
> -       select GENERIC_TIME
>         select GPIO_BCM
>         select SPARSE_IRQ
>         select TICK_ONESHOT
> --
> 1.7.11.7
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
