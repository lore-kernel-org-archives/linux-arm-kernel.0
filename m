From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Apr 2015 11:46:25 +0100
Subject: [PATCH 1/2] arm64: Mark PMU interrupt IRQF_NO_THREAD
In-Reply-To: <1429628755-22492-2-git-send-email-anders.roxell@linaro.org>
References: <1429628755-22492-1-git-send-email-anders.roxell@linaro.org>
 <1429628755-22492-2-git-send-email-anders.roxell@linaro.org>
Message-ID: <20150423104624.GD1652@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 04:05:54PM +0100, Anders Roxell wrote:
> Mark the PMU interrupts as non-threadable, as is the case with
> arch/arm: d9c3365 ARM: 7813/1: Mark pmu interupt IRQF_NO_THREAD
> 
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/kernel/perf_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin can queue this for 4.2.

Cheers,

Will

> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 195991d..7db5c84 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -488,7 +488,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
>  			}
>  
>  			err = request_irq(irq, armpmu->handle_irq,
> -					IRQF_NOBALANCING,
> +					IRQF_NOBALANCING | IRQF_NO_THREAD,
>  					"arm-pmu", armpmu);
>  			if (err) {
>  				pr_err("unable to request IRQ%d for ARM PMU counters\n",
> -- 
> 2.1.4
> 
