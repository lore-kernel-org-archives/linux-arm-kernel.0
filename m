From: jhnikula@gmail.com (Jarkko Nikula)
Date: Thu, 9 Sep 2010 09:24:22 +0300
Subject: [PATCH] OMAP: McBSP: tx_irq_completion used in rx_irq_handler
In-Reply-To: <1283966941.3677.178.camel@quad>
References: <1283966941.3677.178.camel@quad>
Message-ID: <20100909092422.79840f3e.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Sep 2010 13:29:01 -0400
Scott Ellis <scott@jumpnowtek.com> wrote:

> Looks like a typo from commit d6d834b010.
> 
> Signed-off-by: Scott Ellis <scott@jumpnowtek.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
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
It looks so.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
