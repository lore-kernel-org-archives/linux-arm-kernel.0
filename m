From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Jun 2013 16:17:49 +0100
Subject: [PATCH] irqchip: gic: call gic_cpu_init() as well in
 CPU_STARTING_FROZEN case
In-Reply-To: <1371036627-13529-1-git-send-email-shawn.guo@linaro.org>
References: <1371036627-13529-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130612151748.GC31646@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 12:30:27PM +0100, Shawn Guo wrote:
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 1760ceb..19ceaa6 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -705,7 +705,7 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
>  static int __cpuinit gic_secondary_init(struct notifier_block *nfb,
>  					unsigned long action, void *hcpu)
>  {
> -	if (action == CPU_STARTING)
> +	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
>  		gic_cpu_init(&gic_data[0]);
>  	return NOTIFY_OK;
>  }

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
