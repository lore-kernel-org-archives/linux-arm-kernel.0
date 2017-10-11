From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 11 Oct 2017 09:40:30 +0530
Subject: [PATCH 1/1] cpufreq: ti-cpufreq: add missing of_node_put()
In-Reply-To: <1507642040-13646-1-git-send-email-zumeng.chen@gmail.com>
References: <1507642040-13646-1-git-send-email-zumeng.chen@gmail.com>
Message-ID: <20171011041030.GJ4031@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-10-17, 21:27, Zumeng Chen wrote:
> call of_node_put to release the refcount of np.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index ffcddcd..923317f 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -205,6 +205,7 @@ static int ti_cpufreq_init(void)
>  
>  	np = of_find_node_by_path("/");
>  	match = of_match_node(ti_cpufreq_of_match, np);
> +	of_node_put(np);
>  	if (!match)
>  		return -ENODEV;
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
