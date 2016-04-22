From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Apr 2016 00:42:58 +0200
Subject: [PATCH 10/10] cpufreq: mvebu: Use generic platdev driver
In-Reply-To: <1c2cc13d812e04f231ddd4313e3ba6a54fb4632c.1461228504.git.viresh.kumar@linaro.org>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <1c2cc13d812e04f231ddd4313e3ba6a54fb4632c.1461228504.git.viresh.kumar@linaro.org>
Message-ID: <7576455.rVXD0283Nr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 14:29:02 Viresh Kumar wrote:
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 79d0a5d9da8e..f24f46776fbb 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -685,8 +685,6 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
>                         dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>                                 __func__, ret);
>         }
> -
> -       platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>         return 0;
>  }
>  
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 69b2a222c84e..5704a92c52dc 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -33,6 +33,8 @@ static const struct of_device_id machines[] = {
>  
>         { .compatible = "marvell,berlin", },
>  
> +       { .compatible = "marvell,armadaxp", },
> +
>         { .compatible = "samsung,exynos3250", },
>         { .compatible = "samsung,exynos4210", },
>         { .compatible = "samsung,exynos4212", },

I think to make it clear that the ordering is significant here, I would leave this
platform_device_register_simple() in armada_xp_pmsu_cpufreq_init().

However, it might be helpful to move that function into a new file in
drivers/cpufreq/ if that works.

	Arnd
