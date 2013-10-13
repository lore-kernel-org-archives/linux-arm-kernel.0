From: b.brezillon@overkiz.com (boris brezillon)
Date: Sun, 13 Oct 2013 11:27:54 +0200
Subject: [PATCH] clocksource: at91/tc: remove deprecated IRQF_DISABLED
In-Reply-To: <1381639559-6981-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1381639559-6981-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <525A679A.2060408@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Micheal,

This flag has been removed in a recent submission (see 
https://lkml.org/lkml/2013/10/2/202), and, if I'm correct, is on his way 
for mainlining.

Best Regards,

Boris

On 13/10/2013 06:45, Michael Opdenacker wrote:
> This patch proposes to remove the use of the IRQF_DISABLED flag
>
> It's a NOOP since 2.6.35 and it will be removed one day.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> ---
>   drivers/clocksource/tcb_clksrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index 8a61872..2efeb3b 100644
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
