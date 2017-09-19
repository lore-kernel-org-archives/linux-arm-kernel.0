From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 19 Sep 2017 15:38:22 -0700
Subject: [PATCH] cpufreq: ti-cpufreq: Support additional am43xx platforms
In-Reply-To: <20170919200613.31625-1-d-gerlach@ti.com>
References: <20170919200613.31625-1-d-gerlach@ti.com>
Message-ID: <20170919223822.GE30848@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-09-17, 15:06, Dave Gerlach wrote:
> Rather than letting the ti-cpufreq driver match against 'ti,am4372'
> machine compatible during probe let's match against 'ti,am43' so that we
> can support both 'ti,am4372' and 'ti,am438x' platforms which both match
> to this compatible.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index b29cd3398463..4bf47de6101f 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -190,7 +190,7 @@ static int ti_cpufreq_setup_syscon_register(struct ti_cpufreq_data *opp_data)
>  
>  static const struct of_device_id ti_cpufreq_of_match[] = {
>  	{ .compatible = "ti,am33xx", .data = &am3x_soc_data, },
> -	{ .compatible = "ti,am4372", .data = &am4x_soc_data, },
> +	{ .compatible = "ti,am43", .data = &am4x_soc_data, },
>  	{ .compatible = "ti,dra7", .data = &dra7_soc_data },
>  	{},
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
