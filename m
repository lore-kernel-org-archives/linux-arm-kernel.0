From: horms@verge.net.au (Simon Horman)
Date: Sun, 6 Jul 2014 16:32:10 +0200
Subject: ARM: shmobile: fix shmobile_smp_apmu_suspend_init build failure
 for !SUSPEND
In-Reply-To: <4396372.pxzjeyg4CZ@wuerfel>
References: <4396372.pxzjeyg4CZ@wuerfel>
Message-ID: <20140706143210.GI3750@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 04:08:30PM +0200, Arnd Bergmann wrote:
> Patch d6d757c9a4e ("ARM: shmobile: APMU: Add Core-Standby-state for
> Suspend to RAM") added both an inline wrapper for shmobile_smp_apmu_suspend_init
> and an empty function in arch/arm/mach-shmobile/platsmp-apmu.c. We get a
> build failure when both are present, so this patch removes the one in the .c
> file and keeps the inline version.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd, I will queue this up.

> diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
> index a05b16d..2c06810 100644
> --- a/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ b/arch/arm/mach-shmobile/platsmp-apmu.c
> @@ -244,6 +244,4 @@ void __init shmobile_smp_apmu_suspend_init(void)
>  {
>  	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
>  }
> -#else
> -void shmobile_smp_apmu_suspend_init(void) {}
>  #endif
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
