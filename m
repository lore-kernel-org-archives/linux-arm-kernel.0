From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 Jan 2017 11:57:17 +0000
Subject: [PATCH v7 16/19] irqchip/gicv3-its: Sets IRQ_DOMAIN_FLAG_MSI_REMAP
In-Reply-To: <1483969570-3154-17-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
 <1483969570-3154-17-git-send-email-eric.auger@redhat.com>
Message-ID: <7eb4fde8-93fd-3046-a261-06c62a14c8da@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 09/01/17 13:46, Eric Auger wrote:
> The GICv3 ITS is MSI remapping capable. Let's advertise
> this property so that VFIO passthrough can assess IRQ safety.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 69b040f..9d4fefc 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1642,6 +1642,7 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
>  
>  	inner_domain->parent = its_parent;
>  	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
> +	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_REMAP;
>  	info->ops = &its_msi_domain_ops;
>  	info->data = its;
>  	inner_domain->host_data = info;
> 

For patches 13 to 16, and provided that you address the couple of nits I
mentioned in reply to patches 13 and 15:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
