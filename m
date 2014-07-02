From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Jul 2014 10:22:00 +0100
Subject: [PATCH 1/1] arm: perf: Fix build error
In-Reply-To: <1404291976-24662-1-git-send-email-sachin.kamat@samsung.com>
References: <1404291976-24662-1-git-send-email-sachin.kamat@samsung.com>
Message-ID: <20140702092200.GA14665@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

Thanks for reporting the issue.

As it may not be obvious to others from the commit message alone, this
is a breakage in linux-next, not mainline.

On Wed, Jul 02, 2014 at 10:06:16AM +0100, Sachin Kamat wrote:
> Add missing semicolon to fix the following build errors introduced by
> commit 6f73e8ababdd ("arm: perf: clean up PMU names"):
> arch/arm/kernel/perf_event_v6.c:498:2: error: expected ?;? before ?return?
> arch/arm/kernel/perf_event_v6.c:505:2: error: expected ?;? before ?return?
> arch/arm/kernel/perf_event_v6.c:512:2: error: expected ?;? before ?return?

This was a fairly obvious bug on my behalf, apologies for that. I must
have messed that up while rebasing the series.

I'll fix up the relevant commit and give the series another round of
testing.

Thanks,
Mark.

> 
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/kernel/perf_event_v6.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
> index 62227d11e874..abfeb04f3213 100644
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/arch/arm/kernel/perf_event_v6.c
> @@ -494,21 +494,21 @@ static void armv6pmu_init(struct arm_pmu *cpu_pmu)
>  static int armv6_1136_pmu_init(struct arm_pmu *cpu_pmu)
>  {
>  	armv6pmu_init(cpu_pmu);
> -	cpu_pmu->name		= "armv6_1136"
> +	cpu_pmu->name		= "armv6_1136";
>  	return 0;
>  }
>  
>  static int armv6_1156_pmu_init(struct arm_pmu *cpu_pmu)
>  {
>  	armv6pmu_init(cpu_pmu);
> -	cpu_pmu->name		= "armv6_1156"
> +	cpu_pmu->name		= "armv6_1156";
>  	return 0;
>  }
>  
>  static int armv6_1176_pmu_init(struct arm_pmu *cpu_pmu)
>  {
>  	armv6pmu_init(cpu_pmu);
> -	cpu_pmu->name		= "armv6_1176"
> +	cpu_pmu->name		= "armv6_1176";
>  	return 0;
>  }
>  
> -- 
> 1.7.9.5
> 
> 
