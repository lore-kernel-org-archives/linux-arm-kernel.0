From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 19 May 2017 11:11:06 +0200
Subject: [PATCH v2 8/9] crypto: mediatek - Use IPAD/OPAD constant
In-Reply-To: <20170519065331.27670-9-clabbe.montjoie@gmail.com>
References: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
 <20170519065331.27670-9-clabbe.montjoie@gmail.com>
Message-ID: <bf63ad43-5648-d289-4414-5d187b37f229@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/05/17 08:53, Corentin Labbe wrote:
> This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
> define.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   drivers/crypto/mediatek/mtk-sha.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/mediatek/mtk-sha.c b/drivers/crypto/mediatek/mtk-sha.c
> index 2226f12d1c7a..5f4f845adbb8 100644
> --- a/drivers/crypto/mediatek/mtk-sha.c
> +++ b/drivers/crypto/mediatek/mtk-sha.c
> @@ -12,6 +12,7 @@
>    * Some ideas are from atmel-sha.c and omap-sham.c drivers.
>    */
>   
> +#include <crypto/hmac.h>
>   #include <crypto/sha.h>
>   #include "mtk-platform.h"
>   
> @@ -825,8 +826,8 @@ static int mtk_sha_setkey(struct crypto_ahash *tfm, const u8 *key,
>   	memcpy(bctx->opad, bctx->ipad, bs);
>   
>   	for (i = 0; i < bs; i++) {
> -		bctx->ipad[i] ^= 0x36;
> -		bctx->opad[i] ^= 0x5c;
> +		bctx->ipad[i] ^= HMAC_IPAD_VALUE;
> +		bctx->opad[i] ^= HMAC_OPAD_VALUE;
>   	}
>   
>   	return 0;
> 
