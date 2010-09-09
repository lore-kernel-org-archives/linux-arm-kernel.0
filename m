From: ext-eero.nurkkala@nokia.com (Eero Nurkkala)
Date: Thu, 09 Sep 2010 09:17:11 +0300
Subject: [PATCH] OMAP: McBSP: tx_irq_completion used in rx_irq_handler
In-Reply-To: <1283966941.3677.178.camel@quad>
References: <1283966941.3677.178.camel@quad>
Message-ID: <1284013031.15370.8.camel@eenurkka-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-09-08 at 19:29 +0200, ext Scott Ellis wrote:
> Looks like a typo from commit d6d834b010.
> 
> Signed-off-by: Scott Ellis <scott@jumpnowtek.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Indeed my typo.

Acked-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index e31496e..0c8612f 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -156,7 +156,7 @@ static irqreturn_t omap_mcbsp_rx_irq_handler(int irq, void *dev_id)
>  		/* Writing zero to RSYNC_ERR clears the IRQ */
>  		MCBSP_WRITE(mcbsp_rx, SPCR1, MCBSP_READ_CACHE(mcbsp_rx, SPCR1));
>  	} else {
> -		complete(&mcbsp_rx->tx_irq_completion);
> +		complete(&mcbsp_rx->rx_irq_completion);
>  	}
>  
>  	return IRQ_HANDLED;
> 
> 
