From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Wed, 22 May 2013 16:46:39 +0100
Subject: [PATCH 13/14] sched: update the cpu_power
In-Reply-To: <1366910611-20048-14-git-send-email-vincent.guittot@linaro.org>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
 <1366910611-20048-14-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20130522154639.GA4935@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 06:23:29PM +0100, Vincent Guittot wrote:
> @@ -4596,8 +4597,12 @@ static void update_cpu_power(struct sched_domain *sd, int cpu)
>  	cpu_rq(cpu)->cpu_available = power;
>  	sdg->sgp->power_available = power;
>  
> +	if (!is_my_buddy(cpu, cpu))
> +		power = 1;
> +

Using your fix for is_my_buddy() for patch 11 the above will always be
true when sched_packing_mode is to anything else than
SCHED_PACKING_FULL. So cpu_power for all cpus in
SCHED_PACKING_{DEFAULT,NONE} is 1.

As far is I understand, this is not the intention?

Cheers,
Morten

>  	cpu_rq(cpu)->cpu_power = power;
>  	sdg->sgp->power = power;
> +
>  }
>  
>  void update_group_power(struct sched_domain *sd, int cpu)
> -- 
> 1.7.9.5
> 
> 
