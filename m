From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 16 Feb 2011 05:09:08 -0700
Subject: [PATCH] spi/pl022: rid dangling labels
In-Reply-To: <1297845626-13332-1-git-send-email-linus.walleij@stericsson.com>
References: <1297845626-13332-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110216120908.GB24203@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 09:40:26AM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Remove a compilation error regarding unused labels that came about
> when simplifying the DMA code.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.

> ---
>  drivers/spi/amba-pl022.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 4cd05cc..14a451b 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -1030,8 +1030,6 @@ static int configure_dma(struct pl022 *pl022)
>  
>  	return 0;
>  
> -err_submit_tx:
> -err_submit_rx:
>  err_txdesc:
>  	dmaengine_terminate_all(txchan);
>  err_rxdesc:
> -- 
> 1.7.3.2
> 
