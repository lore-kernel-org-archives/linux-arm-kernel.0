From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 1 Sep 2014 11:33:31 +0200
Subject: [PATCH v2 20/26] irqchip: atmel-aic5: convert to handle_domain_irq
In-Reply-To: <1409047421-27649-21-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
 <1409047421-27649-21-git-send-email-marc.zyngier@arm.com>
Message-ID: <54043D6B.5020401@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/2014 12:03, Marc Zyngier :
> Use the new handle_domain_irq method to handle interrupts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Ok, thanks:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/irqchip/irq-atmel-aic5.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
> index edb2270..04fe2c1 100644
> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -78,12 +78,10 @@ aic5_handle(struct pt_regs *regs)
>  	irqnr = irq_reg_readl(gc->reg_base + AT91_AIC5_IVR);
>  	irqstat = irq_reg_readl(gc->reg_base + AT91_AIC5_ISR);
>  
> -	irqnr = irq_find_mapping(aic5_domain, irqnr);
> -
>  	if (!irqstat)
>  		irq_reg_writel(0, gc->reg_base + AT91_AIC5_EOICR);
>  	else
> -		handle_IRQ(irqnr, regs);
> +		handle_domain_irq(aic5_domain, irqnr, regs);
>  }
>  
>  static void aic5_mask(struct irq_data *d)
> 


-- 
Nicolas Ferre
