From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 21 Jul 2015 20:09:27 -0600
Subject: [PATCH v2 4/4] irqchip: Add bcm2836 interrupt controller for
 Raspberry Pi 2.
In-Reply-To: <1436837718-956-5-git-send-email-eric@anholt.net>
References: <1436837718-956-1-git-send-email-eric@anholt.net>
 <1436837718-956-5-git-send-email-eric@anholt.net>
Message-ID: <55AEFB57.6030902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2015 07:35 PM, Eric Anholt wrote:
> This interrupt controller is the new root interrupt controller with
> the timer, PMU events, and IPIs, and the bcm2835's interrupt
> controller is chained off of it to handle the peripherals.

> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c

> +static void bcm2836_arm_irqchip_mask_pmu_irq(struct irq_data *d)
> +{
> +	pr_err("%d: mask PMU\n", smp_processor_id());
> +	writel(1 << smp_processor_id(), intc.base + LOCAL_PM_ROUTING_CLR);
> +}
> +
> +static void bcm2836_arm_irqchip_unmask_pmu_irq(struct irq_data *d)
> +{
> +	pr_err("%d: unmask PMU\n", smp_processor_id());
> +	writel(1 << smp_processor_id(), intc.base + LOCAL_PM_ROUTING_SET);
> +}

Are those pr_err() calls left-over debug, or is there some reason it's
an error to call those functions?

Aside from this and the other minor comment, the series,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
