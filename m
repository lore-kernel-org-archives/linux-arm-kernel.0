From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 30 Oct 2014 21:04:15 +0100
Subject: [PATCH] PM / Domains: Change prototype for the ->attach_dev()
 callback
In-Reply-To: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
References: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <3981560.mBph1QJkfl@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 30, 2014 01:02:49 PM Ulf Hansson wrote:
> Convert the prototype to return and int. This is just an initial step,
> needed to support error handling.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> This patch is intended as fix for 3.18 rc[n]. Why?
> 
> There are other SOC specific patches around that adds genpd support and which
> implements the ->attach_dev() callback. To prevent having an "atomic" patch
> during the next release cycle, let's change the prototype now instead.
> 
> Further patches will add the actual error handling in genpd and these can then
> be reviewed and tested thoroughly.

So we have no users of ->attach_dev at the moment, right?

> ---
>  include/linux/pm_domain.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 73e938b..d44f071 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -72,7 +72,7 @@ struct generic_pm_domain {
>  	bool max_off_time_changed;
>  	bool cached_power_down_ok;
>  	struct gpd_cpuidle_data *cpuidle_data;
> -	void (*attach_dev)(struct device *dev);
> +	int (*attach_dev)(struct device *dev);
>  	void (*detach_dev)(struct device *dev);
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
