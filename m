From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 30 Nov 2015 10:53:09 +0530
Subject: [PATCH 2/4] cpufreq: mt8173: remove redundant
 regulator_get_voltage() call
In-Reply-To: <1448785898-17838-2-git-send-email-pi-cheng.chen@linaro.org>
References: <1448785898-17838-1-git-send-email-pi-cheng.chen@linaro.org>
 <1448785898-17838-2-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20151130052309.GJ3373@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-11-15, 16:31, Pi-Cheng Chen wrote:
> Remove redundant regulator_get_voltage() call to get Vsram value
> since it will be obtained later at the beginning of voltage tracking
> loop.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
>  drivers/cpufreq/mt8173-cpufreq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index c438109..750cda7 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -59,7 +59,6 @@ static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>  	int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
>  
>  	old_vproc = regulator_get_voltage(proc_reg);
> -	old_vsram = regulator_get_voltage(sram_reg);
>  	/* Vsram should not exceed the maximum allowed voltage of SoC. */
>  	new_vsram = min(new_vproc + MIN_VOLT_SHIFT, MAX_VOLT_LIMIT);
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
