From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Oct 2017 08:51:24 +0100
Subject: [PATCH] irqchip/irq-mvebu-gicp: add missing spin_lock init
In-Reply-To: <20171025072326.21030-1-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Wed, 25 Oct 2017 09:23:26 +0200")
References: <20171025072326.21030-1-antoine.tenart@free-electrons.com>
Message-ID: <86efprfywz.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 25 2017 at  9:23:26 am BST, Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
> A spin lock is used in the irq-mvebu-gicp driver, but it is never
> initialized. This patch adds the missing spin_lock_init() call in the
> driver's probe function.
>
> Fixes: a68a63cb4dfc ("irqchip/irq-mvebu-gicp: Add new driver for Marvell GICP")
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/irqchip/irq-mvebu-gicp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
> index b283fc90be1e..17a4a7b6cdbb 100644
> --- a/drivers/irqchip/irq-mvebu-gicp.c
> +++ b/drivers/irqchip/irq-mvebu-gicp.c
> @@ -194,6 +194,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	gicp->dev = &pdev->dev;
> +	spin_lock_init(&gicp->spi_lock);
>  
>  	gicp->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!gicp->res)

Cc: stable at vger.kernel.org
Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thomas, can you please queue this ASAP?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
