From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Fri, 17 Jun 2016 17:58:02 +0200
Subject: [PATCH v4 06/13] ARM: shmobile: apmu: Move #ifdef CONFIG_SMP to
 cover more functions
In-Reply-To: <1466072862-28030-7-git-send-email-geert+renesas@glider.be>
References: <1466072862-28030-1-git-send-email-geert+renesas@glider.be>
 <1466072862-28030-7-git-send-email-geert+renesas@glider.be>
Message-ID: <CAO3366wf2KTgmuO6qOBxOfDHwW8Y8Rpa0eLmPW6rjvBizdWSJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 12:27 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> shmobile_smp_apmu_prepare_cpus() is used only if CONFIG_SMP=y.
>
> Hence move the #ifdef to cover shmobile_smp_apmu_prepare_cpus() and all
> functions only called by it (apmu_init_cpu() and apmu_parse_cfg()).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - New.
> ---
>  arch/arm/mach-shmobile/platsmp-apmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
> index aba75c89f9c1c5eb..c1558ef0c590dd3e 100644
> --- a/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ b/arch/arm/mach-shmobile/platsmp-apmu.c
> @@ -74,6 +74,7 @@ static int __maybe_unused apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu)
>         return p ? fn(p, apmu_cpus[cpu].bit) : -EINVAL;
>  }
>
> +#ifdef CONFIG_SMP
>  static void apmu_init_cpu(struct resource *res, int cpu, int bit)
>  {
>         if ((cpu >= ARRAY_SIZE(apmu_cpus)) || apmu_cpus[cpu].iomem)
> @@ -128,7 +129,6 @@ void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
>         apmu_parse_cfg(apmu_init_cpu, apmu_config, num);
>  }
>
> -#ifdef CONFIG_SMP
>  int shmobile_smp_apmu_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>         /* For this particular CPU register boot vector */
> --
> 1.9.1
>

Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

CU
Uli
