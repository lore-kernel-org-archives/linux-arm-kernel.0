From: elen.song@atmel.com (elen.song)
Date: Mon, 3 Jun 2013 11:10:06 +0800
Subject: warning introduced in "DMA: AT91: Get residual bytes in dma
 buffer"
In-Reply-To: <5527092.NRqFJAfgoB@wuerfel>
References: <5527092.NRqFJAfgoB@wuerfel>
Message-ID: <51AC090E.9090908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd:

On 5/31/2013 11:54 PM, Arnd Bergmann wrote:
> Patch 7c407d3e "DMA: AT91: Get residual bytes in dma buffer"
> causes a build warning
>
> /git/arm-soc/drivers/dma/at_hdmac.c:424:13: warning: 'atc_cleanup_descriptors' defined but not used [-Wunused-function]
>   static void atc_cleanup_descriptors(struct at_dma_chan *atchan)
>               ^
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
> This may not be the right solution, but it should get fixed
> in linux-next in some way.
>
> Elen, please address this appropriately.
OK.
>
> 	Arnd
>
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 6db5228..09929c8 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -421,7 +421,7 @@ static void atc_complete_all(struct at_dma_chan *atchan)
>    *
>    * Called with atchan->lock held and bh disabled
>    */
> -static void atc_cleanup_descriptors(struct at_dma_chan *atchan)
> +static void __maybe_unused atc_cleanup_descriptors(struct at_dma_chan *atchan)
>   {
>   	struct at_desc	*desc, *_desc;
>   	struct at_desc	*child;
>
Hi Nicolas and Ludovic:

I think atc_cleanup_descriptors could be removed, because ATC_DONE will 
no longer support, what you think?

Best Regards
Elen song
