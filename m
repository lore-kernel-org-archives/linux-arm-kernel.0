From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 13 Oct 2015 04:07:47 +0900
Subject: [PATCH] ARM: Remove open-coded version of IRQCHIP_DECLARE
In-Reply-To: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
References: <1443803057-9007-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <561C0503.3050006@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/15 01:24, Marc Zyngier wrote:
> Now that the IRQCHIP_DECLARE macro has been moved to linux/irqchip.h,
> it becomes possible to cleanup the open-coded versions of the same
> macro that have been added to some private irqchips implementations.
> 
> Cc: Kukjin Kim <kgene@kernel.org>

Acked-by: Kukjin Kim <kgene@kernel.org>

Thanks,
Kukjin

> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-exynos/suspend.c       | 3 ++-
>  arch/arm/mach-imx/gpc.c              | 8 ++------
>  arch/arm/mach-omap2/omap-wakeupgen.c | 8 ++------
>  3 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index e00eb39..dfb1fcf 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -19,6 +19,7 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> +#include <linux/irqchip.h>
>  #include <linux/irqdomain.h>
>  #include <linux/of_address.h>
>  #include <linux/err.h>
> @@ -262,7 +263,7 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
>  	return 0;
>  }
>  
> -#define EXYNOS_PMU_IRQ(symbol, name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
> +#define EXYNOS_PMU_IRQ(symbol, name)	IRQCHIP_DECLARE(symbol, name, exynos_pmu_irq_init)
>  
>  EXYNOS_PMU_IRQ(exynos3250_pmu_irq, "samsung,exynos3250-pmu");
>  EXYNOS_PMU_IRQ(exynos4210_pmu_irq, "samsung,exynos4210-pmu");

[...]
