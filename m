From: zonque@gmail.com (Daniel Mack)
Date: Wed, 04 Dec 2013 11:26:06 +0100
Subject: [PATCH] ARM: pxa: Remove unused variables
In-Reply-To: <1386152565-26524-1-git-send-email-thierry.reding@gmail.com>
References: <1386152565-26524-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <529F033E.9020608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2013 11:22 AM, Thierry Reding wrote:
> The conf and of_id variables are assigned but never used, so they may as
> well just be removed.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Daniel Mack <zonque@gmail.com>

> ---
>  arch/arm/mach-pxa/irq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index b6cc1816463e..0eecd83c624e 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -235,8 +235,6 @@ static const struct of_device_id intc_ids[] __initconst = {
>  void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>  {
>  	struct device_node *node;
> -	const struct of_device_id *of_id;
> -	struct pxa_intc_conf *conf;
>  	struct resource res;
>  	int n, ret;
>  
> @@ -245,8 +243,6 @@ void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int))
>  		pr_err("Failed to find interrupt controller in arch-pxa\n");
>  		return;
>  	}
> -	of_id = of_match_node(intc_ids, node);
> -	conf = of_id->data;
>  
>  	ret = of_property_read_u32(node, "marvell,intc-nr-irqs",
>  				   &pxa_internal_irq_nr);
> 
