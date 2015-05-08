From: nm@ti.com (Nishanth Menon)
Date: Fri, 8 May 2015 15:16:35 -0500
Subject: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
In-Reply-To: <1431115050-23693-2-git-send-email-balbi@ti.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <1431115050-23693-2-git-send-email-balbi@ti.com>
Message-ID: <554D19A3.8030607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2015 02:57 PM, Felipe Balbi wrote:
> by adding the missing MODULE_ALIAS(), cpufreq-dt
> can be autoloaded by udev/systemd.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index bab67db54b7e..528a82bf5038 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -416,6 +416,7 @@ static struct platform_driver dt_cpufreq_platdrv = {
>  };
>  module_platform_driver(dt_cpufreq_platdrv);
>  
> +MODULE_ALIAS("platform:cpufreq-dt");
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>  MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
>  MODULE_DESCRIPTION("Generic cpufreq driver");
> 

This patch does not depend on patch #1 of the series.

other than that..

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
