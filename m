From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Aug 2018 14:45:49 +0100
Subject: [PATCH resend] irqchip/tango: Set irq handler and data in one go
In-Reply-To: <1534507827-7230-1-git-send-email-martin@kaiser.cx>
References: <1532282533-26507-1-git-send-email-martin@kaiser.cx>
 <1534507827-7230-1-git-send-email-martin@kaiser.cx>
Message-ID: <9ad15cc2-2a53-fc42-1643-3c91c4190709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/08/18 13:10, Martin Kaiser wrote:
> Replace the two separate calls for setting the irq handler and data with
> a single irq_set_chained_handler_and_data() call.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> Resending this, it seems this got lost along the way. Not a major change,
> of course. But should also be simple to review.
> 
> Thanks & Best regards,
> Martin
> 
>  drivers/irqchip/irq-tango.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
> index 0c085303a583..580e2d72b9ba 100644
> --- a/drivers/irqchip/irq-tango.c
> +++ b/drivers/irqchip/irq-tango.c
> @@ -205,8 +205,7 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
>  
>  	tangox_irq_domain_init(dom);
>  
> -	irq_set_chained_handler(irq, tangox_irq_handler);
> -	irq_set_handler_data(irq, dom);
> +	irq_set_chained_handler_and_data(irq, tangox_irq_handler, dom);
>  
>  	return 0;
>  }
> 

Queued, thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
