From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Jul 2014 17:32:52 +0900
Subject: [PATCH] ARM: EXYNOS: Fix the check for non-smp configuration
In-Reply-To: <1404363812-26307-1-git-send-email-a.kesavan@samsung.com>
References: <1404363812-26307-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <032801cf9762$8be518b0$a3af4a10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash Kesavan wrote:
> 
> Commit 1754c42e3db5("ARM: exynos: move sysram info to exynos.c") missed
> out the CONFIG_ prefix causing exynos_sysram_init() to get called twice
> for SMP configurations.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index f38cf7c..95cad25 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -297,7 +297,7 @@ static void __init exynos_dt_machine_init(void)
>  	 * This is called from smp_prepare_cpus if we've built for SMP, but
>  	 * we still need to set it up for PM and firmware ops if not.
>  	 */
> -	if (!IS_ENABLED(SMP))
> +	if (!IS_ENABLED(CONFIG_SMP))
>  		exynos_sysram_init();
> 
>  	exynos_cpuidle_init();
> --
> 1.7.9.5

Oh, OK. will apply into fixes.

Thanks,
Kukjin
