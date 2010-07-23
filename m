From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Fri, 23 Jul 2010 22:23:50 +0200
Subject: [PATCH 03/11] ARM: sa1111: move __sa1111_probe() to .devinit.text
In-Reply-To: <1279915120-4373-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1279915120-4373-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100723202350.GD976@boggieman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


you beat me to it :)

Acked-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

On Fri, Jul 23, 2010 at 09:58:26PM +0200, Uwe Kleine-K?nig wrote:
> __sa1111_probe is only called by sa1111_probe that lives in .devinit.text.
> So it's save to move the former to .devinit.text, too.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/common/sa1111.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index 6f80665..97c5bc9 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -681,7 +681,7 @@ out:
>   *	%-EBUSY		physical address already marked in-use.
>   *	%0		successful.
>   */
> -static int
> +static int __devinit
>  __sa1111_probe(struct device *me, struct resource *mem, int irq)
>  {
>  	struct sa1111 *sachip;
> -- 
> 1.7.1
