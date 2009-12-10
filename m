From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Dec 2009 09:28:03 +0100
Subject: [PATCH 1/12] arch/arm: Correct size given to memset
In-Reply-To: <Pine.LNX.4.64.0912092022040.1870@ask.diku.dk>
References: <Pine.LNX.4.64.0912092022040.1870@ask.diku.dk>
Message-ID: <20091210082803.GA6255@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 09, 2009 at 08:22:26PM +0100, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Memset should be given the size of the structure, not the size of the pointer.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> type T;
> T *x;
> expression E;
> @@
> 
> memset(x, E, sizeof(
> + *
>  x))
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  arch/arm/plat-mxc/dma-mx1-mx2.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/arch/arm/plat-mxc/dma-mx1-mx2.c b/arch/arm/plat-mxc/dma-mx1-mx2.c
> --- a/arch/arm/plat-mxc/dma-mx1-mx2.c
> +++ b/arch/arm/plat-mxc/dma-mx1-mx2.c
> @@ -694,7 +694,7 @@ int imx_dma_request(int channel, const c
>  		local_irq_restore(flags);
>  		return -EBUSY;
>  	}
> -	memset(imxdma, 0, sizeof(imxdma));
> +	memset(imxdma, 0, sizeof(*imxdma));
>  	imxdma->name = name;
>  	local_irq_restore(flags); /* request_irq() can block */
Patch is OK, Sascha, if you take it you can add my Ack, if not I can
take care of it in my cleanup series.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
