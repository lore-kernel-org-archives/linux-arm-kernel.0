From: balbi@ti.com (Felipe Balbi)
Date: Tue, 16 Jun 2015 16:40:32 -0500
Subject: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
In-Reply-To: <1431115050-23693-2-git-send-email-balbi@ti.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <1431115050-23693-2-git-send-email-balbi@ti.com>
Message-ID: <20150616214032.GA4313@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 02:57:30PM -0500, Felipe Balbi wrote:
> by adding the missing MODULE_ALIAS(), cpufreq-dt
> can be autoloaded by udev/systemd.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

looks like this wasn't applied anywhere. Viresh, can you apply this
patch please ?

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
> -- 
> 2.4.0.rc3
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150616/83a6496d/attachment.sig>
