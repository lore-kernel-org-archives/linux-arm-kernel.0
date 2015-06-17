From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 17 Jun 2015 13:05:27 +0800
Subject: [PATCH v5 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <1434448748-10828-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1434448748-10828-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434448748-10828-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150617050527.GA8807@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 11:58:59AM +0200, Boris Brezillon wrote:
>
> +	ret = dma_map_sg(cesa_dev->dev, req->src, creq->src_nents,
> +			 DMA_TO_DEVICE);
> +	if (ret != creq->src_nents)
> +		return -ENOMEM;

Hmm it doesn't quite work like that.  It returns zero on error,
otherwise it returns the number (n) of mapped entries which may be
less than what you gave it due to merging.  You're then supposed
to use only the first n entries which should contain everything.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
