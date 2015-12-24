From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Thu, 24 Dec 2015 13:56:25 +0100
Subject: [RFC PATCH 3/5] crypto: sunxi-ss: fix dev_dbg() output type
In-Reply-To: <1450787267-26836-4-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-4-git-send-email-andre.przywara@arm.com>
Message-ID: <567BEB79.7050201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 22/12/2015 13:27, Andre Przywara a ?crit :
> The length parameter in this dev_dbg() call is actually a size_t,
> so use the proper type to avoid warnings when compiling for 64-bit
> architectures.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> index b3bc7bd..af2690c 100644
> --- a/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> +++ b/drivers/crypto/sunxi-ss/sun4i-ss-cipher.c
> @@ -251,7 +251,7 @@ static int sun4i_ss_cipher_poll(struct ablkcipher_request *areq)
>  		spaces = readl(ss->base + SS_FCSR);
>  		rx_cnt = SS_RXFIFO_SPACES(spaces);
>  		tx_cnt = SS_TXFIFO_SPACES(spaces);
> -		dev_dbg(ss->dev, "%x %u/%u %u/%u cnt=%u %u/%u %u/%u cnt=%u %u %u\n",
> +		dev_dbg(ss->dev, "%x %u/%zu %u/%u cnt=%u %u/%zu %u/%u cnt=%u %u %u\n",
>  			mode,
>  			oi, mi.length, ileft, areq->nbytes, rx_cnt,
>  			oo, mo.length, oleft, areq->nbytes, tx_cnt,
> 

Acked-by: LABBE Corentin <clabbe.montjoie@gmail.com>
