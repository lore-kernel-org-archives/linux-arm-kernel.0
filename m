From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 01 Oct 2015 16:53:58 +0100
Subject: [PATCH 2/2] irqchip: sunxi-nmi: switch to of_io_request_and_map()
 from of_iomap()
In-Reply-To: <1443713629-17415-3-git-send-email-wens@csie.org>
References: <1443713629-17415-1-git-send-email-wens@csie.org>
 <1443713629-17415-3-git-send-email-wens@csie.org>
Message-ID: <560D5716.9000202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/15 16:33, Chen-Yu Tsai wrote:
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Please, take the time to write a commit message. You've done it in your
cover letter (where it matters the least), so why avoid doing it where
it actually benefits everyone?

> ---
>  drivers/irqchip/irq-sunxi-nmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
> index 57e009917d2d..4fa46d778d02 100644
> --- a/drivers/irqchip/irq-sunxi-nmi.c
> +++ b/drivers/irqchip/irq-sunxi-nmi.c
> @@ -152,7 +152,7 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
>  	}
>  
>  	gc = irq_get_domain_generic_chip(domain, 0);
> -	gc->reg_base = of_iomap(node, 0);
> +	gc->reg_base = of_io_request_and_map(node, 0, of_node_full_name(node));
>  	if (!gc->reg_base) {
>  		pr_err("%s: unable to map resource\n", DRV_NAME);
>  		ret = -ENOMEM;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
