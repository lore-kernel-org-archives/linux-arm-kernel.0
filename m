From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 15:29:25 +0100
Subject: [PATCH 08/11] irqchip: gic-v3: declare rdist as __percpu pointer
 to __iomem pointer
In-Reply-To: <1409062410-25891-9-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-9-git-send-email-will.deacon@arm.com>
Message-ID: <53FC99C5.10209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/14 15:13, Will Deacon wrote:
> The __percpu __iomem annotations on the rdist base are contradictory
> and confuse static checkers such as sparse.
> 
> This patch fixes the anotations so that rdist is described as a __percpu
> pointer to an __iomem pointer.
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

> ---
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 57eaa5a0b1e3..4d7b7c28c554 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -36,7 +36,7 @@
>  struct gic_chip_data {
>  	void __iomem		*dist_base;
>  	void __iomem		**redist_base;
> -	void __percpu __iomem	**rdist;
> +	void __iomem * __percpu	*rdist;
>  	struct irq_domain	*domain;
>  	u64			redist_stride;
>  	u32			redist_regions;
> 


-- 
Jazz is not dead. It just smells funny...
