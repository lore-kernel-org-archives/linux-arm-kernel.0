From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 17 Jun 2015 15:18:29 +0800
Subject: [PATCH v5 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150617091503.5f74b6e5@bbrezillon>
References: <1434448748-10828-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434448748-10828-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150617050527.GA8807@gondor.apana.org.au>
 <20150617055633.GA9123@gondor.apana.org.au>
 <20150617091503.5f74b6e5@bbrezillon>
Message-ID: <20150617071829.GA9895@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 09:15:03AM +0200, Boris Brezillon wrote:
>
> Anyway, now I'm doing the following test:
> 
> if (creq->src_nents && !ret)
> 	return -ENOMEM;

Best not call dma_map_sg at all in the !src_nents case as I think
some architectures will WARN or BUG if you give it a zero-length
list.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
