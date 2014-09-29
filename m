From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Sep 2014 11:12:59 -0700
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
In-Reply-To: <20140926162512.07ef4957@canb.auug.org.au>
References: <20140926162512.07ef4957@canb.auug.org.au>
Message-ID: <20140929181258.GF3122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Rothwell <sfr@canb.auug.org.au> [140925 23:26]:
> Hi all,
> 
> Today's linux-next merge of the tip tree got a conflict in
> arch/arm/mach-omap2/irq.c between commit 8598066cddd1 ("arm: omap: irq:
> move irq.c to drivers/irqchip/") from the arm-soc tree and commit
> f978999f6096 ("Use the new handle_domain_irq method to handle
> interrupts") from the tip tree.
> 
> I fixed it up (I applied the latter patch to the moved file - see
> below) and can carry the fix as necessary (no action is required).
> 
> diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
> index f3814e79192d..28718d3e8281 100644
> --- a/drivers/irqchip/irq-omap-intc.c
> +++ b/drivers/irqchip/irq-omap-intc.c
> @@ -334,8 +334,7 @@ out:
>  		irqnr &= ACTIVEIRQ_MASK;
>  
>  		if (irqnr) {
> -			irqnr = irq_find_mapping(domain, irqnr);
> -			handle_IRQ(irqnr, regs);
> +			handle_domain_irq(domain, irqnr, regs);
>  			handled_irq = 1;
>  		}
>  	} while (irqnr);
> 

Thanks I've verified things are booting fine with linux next.

Regards,

Tony
