From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 30 Sep 2014 14:28:14 +0200
Subject: [PATCH 2/3] irqchip: dw-apb-ictl: enable
 IRQ_GC_MASK_CACHE_PER_TYPE
In-Reply-To: <1411454100-6814-3-git-send-email-jszhang@marvell.com>
References: <1411454100-6814-1-git-send-email-jszhang@marvell.com>
 <1411454100-6814-3-git-send-email-jszhang@marvell.com>
Message-ID: <542AA1DE.4020606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2014 08:34 AM, Jisheng Zhang wrote:
> The irq_chip_type instances have separate mask registers, so we need to
> enable IRQ_GC_MASK_CACHE_PER_TYPE to actually handle separate mask registers.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   drivers/irqchip/irq-dw-apb-ictl.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
> index fcc3385..c136b67 100644
> --- a/drivers/irqchip/irq-dw-apb-ictl.c
> +++ b/drivers/irqchip/irq-dw-apb-ictl.c
> @@ -115,6 +115,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
>
>   	ret = irq_alloc_domain_generic_chips(domain, 32, (nrirqs > 32) ? 2 : 1,
>   					     np->name, handle_level_irq, clr, 0,
> +					     IRQ_GC_MASK_CACHE_PER_TYPE |
>   					     IRQ_GC_INIT_MASK_CACHE);
>   	if (ret) {
>   		pr_err("%s: unable to alloc irq domain gc\n", np->full_name);
>
