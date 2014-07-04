From: spk.linux@gmail.com (Sachin Kamat)
Date: Fri, 4 Jul 2014 14:27:27 +0530
Subject: [PATCH] ARM: EXYNOS: Fix the check for non-smp configuration
In-Reply-To: <1404363812-26307-1-git-send-email-a.kesavan@samsung.com>
References: <1404363812-26307-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAK5sBcEicy++xayNEXipQEd_4ZzpaD8MRnwxS74qi3RA4R-mpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 3, 2014 at 10:33 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
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
>          * This is called from smp_prepare_cpus if we've built for SMP, but
>          * we still need to set it up for PM and firmware ops if not.
>          */
> -       if (!IS_ENABLED(SMP))
> +       if (!IS_ENABLED(CONFIG_SMP))
>                 exynos_sysram_init();
>
>         exynos_cpuidle_init();

If it's not too late
Reviewed-by: Sachin Kamat <sachin.kamat@samsug.com>

-- 
Regards,
Sachin.
