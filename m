From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Oct 2015 07:29:34 +0530
Subject: [patch] cpufreq: scpi-cpufreq: signedness bug in
 scpi_get_dvfs_info()
In-Reply-To: <20151022195208.GB24439@mwanda>
References: <20151022195208.GB24439@mwanda>
Message-ID: <20151023015934.GM3897@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-10-15, 22:52, Dan Carpenter wrote:
> The "domain" variable needs to be signed for the error handling to work.
> 
> Fixes: 8def31034d03 ('cpufreq: arm_big_little: add SCPI interface driver')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index 2c3b16f..de5e89b 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -31,7 +31,7 @@ static struct scpi_ops *scpi_ops;
>  
>  static struct scpi_dvfs_info *scpi_get_dvfs_info(struct device *cpu_dev)
>  {
> -	u8 domain = topology_physical_package_id(cpu_dev->id);
> +	int domain = topology_physical_package_id(cpu_dev->id);
>  
>  	if (domain < 0)
>  		return ERR_PTR(-EINVAL);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
