From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 2 Jan 2017 12:39:03 +0530
Subject: [PATCH] cpufreq: s3c64xx: remove incorrect __init annotation
In-Reply-To: <20161216090625.2235668-1-arnd@arndb.de>
References: <20161216090625.2235668-1-arnd@arndb.de>
Message-ID: <20170102070903.GC8588@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-12-16, 10:06, Arnd Bergmann wrote:
> s3c64xx_cpufreq_config_regulator is incorrectly annotated
> as __init, since the caller is also not init:
> 
> WARNING: vmlinux.o(.text+0x92fe1c): Section mismatch in reference from the function s3c64xx_cpufreq_driver_init() to the function .init.text:s3c64xx_cpufreq_config_regulator()
> 
> With modern gcc versions, the function gets inline, so we don't
> see the warning, this only happens with gcc-4.6 and older.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/s3c64xx-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
> index 176e84cc3991..0cb9040eca49 100644
> --- a/drivers/cpufreq/s3c64xx-cpufreq.c
> +++ b/drivers/cpufreq/s3c64xx-cpufreq.c
> @@ -107,7 +107,7 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
>  }
>  
>  #ifdef CONFIG_REGULATOR
> -static void __init s3c64xx_cpufreq_config_regulator(void)
> +static void s3c64xx_cpufreq_config_regulator(void)
>  {
>  	int count, v, i, found;
>  	struct cpufreq_frequency_table *freq;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
