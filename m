From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 23 Apr 2015 09:24:41 +0900
Subject: [PATCH] ARM: exynos: Fix wake-up interrupts for Exynos3250
In-Reply-To: <1429724452-26563-1-git-send-email-marc.zyngier@arm.com>
References: <1429724452-26563-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <55383BC9.5010604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 04/23/2015 02:40 AM, Marc Zyngier wrote:
> Commit 8b283c025443 (ARM: exynos4/5: convert pmu wakeup to
> stacked domains) changed the Exynos PMU code to use stacked
> domains. This has led to a number of interrupt numbers to be
> fixed.
> 
> In the meantime, support for Exynos 3250 was added, missing
> the required change to this platform. This amounts to revert
> ace283a04a4a (ARM: EXYNOS: Fix wrong hwirq of RTC interrupt
> for Exynos3250 SoC), as the initial patch was right, just a
> bit early...
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-exynos/suspend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index 3e6aea7..40dce36 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -87,8 +87,8 @@ static unsigned int exynos_pmu_spare3;
>  static u32 exynos_irqwake_intmask = 0xffffffff;
>  
>  static const struct exynos_wkup_irq exynos3250_wkup_irq[] = {
> -	{ 105, BIT(1) }, /* RTC alarm */
> -	{ 106, BIT(2) }, /* RTC tick */
> +	{ 73, BIT(1) }, /* RTC alarm */
> +	{ 74, BIT(2) }, /* RTC tick */
>  	{ /* sentinel */ },
>  };
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
