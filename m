From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Oct 2017 11:07:20 +0100
Subject: [PATCH] ARM: cache-l2x0-pmu: Delete an error message for a
 failed memory allocation in l2x0_pmu_init()
In-Reply-To: <672554ba-b476-8852-3c37-9e8716f1eec4@users.sourceforge.net>
References: <672554ba-b476-8852-3c37-9e8716f1eec4@users.sourceforge.net>
Message-ID: <20171003100719.GB4931@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 11:23:23AM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Oct 2017 11:16:56 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I assume you'll drop this in Russell's patch system.

Thanks,
Mark.

> ---
>  arch/arm/mm/cache-l2x0-pmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
> index 0a1e2280141f..b3734da93010 100644
> --- a/arch/arm/mm/cache-l2x0-pmu.c
> +++ b/arch/arm/mm/cache-l2x0-pmu.c
> @@ -528,10 +528,8 @@ static __init int l2x0_pmu_init(void)
>  		return 0;
>  
>  	l2x0_pmu = kzalloc(sizeof(*l2x0_pmu), GFP_KERNEL);
> -	if (!l2x0_pmu) {
> -		pr_warn("Unable to allocate L2x0 PMU\n");
> +	if (!l2x0_pmu)
>  		return -ENOMEM;
> -	}
>  
>  	*l2x0_pmu = (struct pmu) {
>  		.task_ctx_nr = perf_invalid_context,
> -- 
> 2.14.2
> 
