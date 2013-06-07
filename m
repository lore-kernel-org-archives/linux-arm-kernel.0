From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 17:38:01 +0200
Subject: [PATCH] dmaengine/trivial: at_hdmac: add curly brackets to
 if/else expressions
In-Reply-To: <1370618898-18296-1-git-send-email-nicolas.ferre@atmel.com>
References: <1370618898-18296-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201306071738.01488.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Nicolas Ferre wrote:
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 50953a7..b321562 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -299,8 +299,9 @@ static int atc_get_bytes_left(struct dma_chan *chan)
>                 if (atchan->remain_desc < 0) {
>                         ret = -EINVAL;
>                         goto out;
> -               } else
> +               } else {
>                         ret = atchan->remain_desc;
> +               }
>         } else {

Actually the original code is what a lot of people prefer, though I don't
have a reference to back that up.

If one side of the 'else' uses curly braces, the other one should too.
	
	Arnd
