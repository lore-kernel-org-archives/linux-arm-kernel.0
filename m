From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 17 Jun 2015 17:50:01 +0800
Subject: [PATCH v6 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <1434527142-3609-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434527142-3609-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150617095001.GA11538@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 09:45:33AM +0200, Boris Brezillon wrote:
>
> +	ret = dma_map_sg(cesa_dev->dev, req->src, creq->src_nents,
> +			 DMA_TO_DEVICE);
> +	if (!ret)
> +		return -ENOMEM;
> +
> +	creq->src_nents = ret;

DMA-API-HOWTO says that you must retain the original nents and
use it when you call dma_unmap_sg.  So I'm afraid one more repost
is needed :)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
