From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Nov 2016 08:49:41 +0530
Subject: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: make symbol
 brcm_avs_cpufreq_attr static
In-Reply-To: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com>
References: <1478791145-21137-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20161111031941.GF11670@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-11-16, 15:19, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/cpufreq/brcmstb-avs-cpufreq.c:982:18: warning:
>  symbol 'brcm_avs_cpufreq_attr' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index b761d54..4fda623 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -979,7 +979,7 @@ cpufreq_freq_attr_ro(brcm_avs_pmap);
>  cpufreq_freq_attr_ro(brcm_avs_voltage);
>  cpufreq_freq_attr_ro(brcm_avs_frequency);
>  
> -struct freq_attr *brcm_avs_cpufreq_attr[] = {
> +static struct freq_attr *brcm_avs_cpufreq_attr[] = {
>  	&cpufreq_freq_attr_scaling_available_freqs,
>  	&brcm_avs_pstate,
>  	&brcm_avs_mode,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
