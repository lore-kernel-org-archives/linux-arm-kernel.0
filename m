From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 2 Oct 2013 14:47:49 +0200
Subject: [PATCH 3/3] ARM: at91/tc/clocksource: remove IRQF_DISABLED
In-Reply-To: <1380717348-6650-1-git-send-email-b.brezillon@overkiz.com>
References: <1380717265-6497-1-git-send-email-b.brezillon@overkiz.com>
 <1380717348-6650-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <524C15F5.5030704@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2013 14:35, Boris BREZILLON :
> Remove the deprecated IRQF_DISABLED flag.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>   drivers/clocksource/tcb_clksrc.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index 10a5d9e..00fdd11 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -180,7 +180,7 @@ static irqreturn_t ch2_irq(int irq, void *handle)
>
>   static struct irqaction tc_irqaction = {
>   	.name		= "tc_clkevt",
> -	.flags		= IRQF_TIMER | IRQF_DISABLED,
> +	.flags		= IRQF_TIMER,
>   	.handler	= ch2_irq,
>   };
>
>


-- 
Nicolas Ferre
