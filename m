From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 Sep 2016 09:23:38 +0530
Subject: [PATCH] cpufreq: st: add missing \n to end of dev_err message
In-Reply-To: <20160925214013.12430-1-colin.king@canonical.com>
References: <20160925214013.12430-1-colin.king@canonical.com>
Message-ID: <20160926035338.GF17336@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-09-16, 14:40, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix, dev_err message is missing a \n, so add it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index 0404203..b366e6d 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -163,7 +163,7 @@ static int sti_cpufreq_set_opp_info(void)
>  
>  	reg_fields = sti_cpufreq_match();
>  	if (!reg_fields) {
> -		dev_err(dev, "This SoC doesn't support voltage scaling");
> +		dev_err(dev, "This SoC doesn't support voltage scaling\n");
>  		return -ENODEV;
>  	}
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
