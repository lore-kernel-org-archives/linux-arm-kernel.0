From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Nov 2017 14:39:44 +0000
Subject: [PATCH 1/3] irqchip/mips-gic: pr_err() strings should end with
 newlines
In-Reply-To: <500e0c48a5e46003d33b31a257806a4991c0ff9d.1510580710.git.arvind.yadav.cs@gmail.com>
References: <cover.1510580710.git.arvind.yadav.cs@gmail.com>
 <500e0c48a5e46003d33b31a257806a4991c0ff9d.1510580710.git.arvind.yadav.cs@gmail.com>
Message-ID: <6c243286-203e-3d05-feb9-7a81a0eb624a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/17 13:53, Arvind Yadav wrote:
> pr_err() messages should end with a new-line to avoid other messages
> being concatenated.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/irqchip/irq-mips-gic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index c90976d..e87d33b 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -737,7 +737,7 @@ static int __init gic_of_init(struct device_node *node,
>  					       gic_shared_intrs, 0,
>  					       &gic_irq_domain_ops, NULL);
>  	if (!gic_irq_domain) {
> -		pr_err("Failed to add GIC IRQ domain");
> +		pr_err("Failed to add GIC IRQ domain\n");
>  		return -ENXIO;
>  	}
>  
> @@ -746,7 +746,7 @@ static int __init gic_of_init(struct device_node *node,
>  						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
>  						  node, &gic_ipi_domain_ops, NULL);
>  	if (!gic_ipi_domain) {
> -		pr_err("Failed to add GIC IPI domain");
> +		pr_err("Failed to add GIC IPI domain\n");
>  		return -ENXIO;
>  	}
>  
> 

This patch doesn't apply to the current state of the irqchip tree, nor
of tip/irq/core. Please verify that it applies and resubmit if required.

I've applied patches 2 and 3.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
