From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 1 Sep 2014 12:16:26 +0200
Subject: [PATCH v2 19/26] irqchip: atmel-aic: convert to handle_domain_irq
In-Reply-To: <1409047421-27649-20-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
 <1409047421-27649-20-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140901121626.7bd01dbe@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Aug 2014 11:03:34 +0100
Marc Zyngier <marc.zyngier@arm.com> wrote:

> Use the new handle_domain_irq method to handle interrupts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  drivers/irqchip/irq-atmel-aic.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
> index a82869e..9a2cf3c 100644
> --- a/drivers/irqchip/irq-atmel-aic.c
> +++ b/drivers/irqchip/irq-atmel-aic.c
> @@ -68,12 +68,10 @@ aic_handle(struct pt_regs *regs)
>  	irqnr = irq_reg_readl(gc->reg_base + AT91_AIC_IVR);
>  	irqstat = irq_reg_readl(gc->reg_base + AT91_AIC_ISR);
>  
> -	irqnr = irq_find_mapping(aic_domain, irqnr);
> -
>  	if (!irqstat)
>  		irq_reg_writel(0, gc->reg_base + AT91_AIC_EOICR);
>  	else
> -		handle_IRQ(irqnr, regs);
> +		handle_domain_irq(aic_domain, irqnr, regs);
>  }
>  
>  static int aic_retrigger(struct irq_data *d)



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
