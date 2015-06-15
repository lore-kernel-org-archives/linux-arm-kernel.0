From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 15 Jun 2015 18:09:20 +0800
Subject: [RESEND PATCH v4 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <1434093366-14681-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150615100920.GB32199@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 09:15:57AM +0200, Boris Brezillon wrote:
>
> +	ret = dma_map_sg(cesa_dev->dev, req->src, creq->src_nents,
> +			 DMA_TO_DEVICE);
> +	if (ret < 0)

This function returns zero on error, not negative.  See
Documentation/DMA-API-HOWTO.txt for details.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
