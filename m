From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 27 Dec 2009 22:51:06 +0100
Subject: [PATCH 1/5] arch/arm: Correct NULL test
In-Reply-To: <Pine.LNX.4.64.0912272226360.20548@ask.diku.dk>
References: <Pine.LNX.4.64.0912272226360.20548@ask.diku.dk>
Message-ID: <20091227215106.GA18317@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 27, 2009 at 10:26:54PM +0100, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Test the just-allocated value for NULL rather than some other value.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> ....
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  arch/arm/plat-pxa/dma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
> --- a/arch/arm/plat-pxa/dma.c
> +++ b/arch/arm/plat-pxa/dma.c
> @@ -244,7 +244,7 @@ static void pxa_dma_init_debugfs(void)
>  
>  	dbgfs_chan = kmalloc(sizeof(*dbgfs_state) * num_dma_channels,
>  			     GFP_KERNEL);
> -	if (!dbgfs_state)
> +	if (!dbgfs_chan)
>  		goto err_alloc;
Shouldn't the malloc line read:

	... = kmalloc(sizeof(*dbgfs_chan) * ...)
	                      ^^^^^^^^^^

?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
