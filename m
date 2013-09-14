From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 15 Sep 2013 00:48:27 +0300
Subject: [PATCH 136/228] cpufreq: loongson2: use cpufreq_generic_init()
 routine
In-Reply-To: <63ebf29a1bcc7b3a26f8bfc76a5677d2880f8534.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <63ebf29a1bcc7b3a26f8bfc76a5677d2880f8534.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130914214827.GA30568@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 06:31:22PM +0530, Viresh Kumar wrote:
> Use generic cpufreq_generic_init() routine instead of replicating the same code
> here. This driver wasn't setting transition_latency and so is getting set to 0
> by default. Lets mark it explicitly by calling the generic routine with
> transition_latency as 0.
> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: John Crispin <blogic@openwrt.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

BTW, this is not ARM but MIPS board, so adding linux-mips to CC.

A.

> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index dd4f3e4..2c8ec8e 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -131,8 +131,7 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		return ret;
>  	}
>  
> -	return cpufreq_table_validate_and_show(policy,
> -					    &loongson2_clockmod_table[0]);
> +	return cpufreq_generic_init(policy, &loongson2_clockmod_table[0], 0);
>  }
>  
>  static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
> -- 
> 1.7.12.rc2.18.g61b472e
> 
