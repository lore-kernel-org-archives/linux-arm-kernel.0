From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 18 Jun 2015 09:41:32 +0800
Subject: [PATCH v7 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150617173402.7946bbb0@bbrezillon>
References: <20150617122533.GA13185@gondor.apana.org.au>
 <1434547922-10363-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150617150808.GA14915@gondor.apana.org.au>
 <20150617173402.7946bbb0@bbrezillon>
Message-ID: <20150618014132.GA26238@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 05:34:02PM +0200, Boris Brezillon wrote:
>
> I can check for that too, but note that it doesn't prevent one from
> providing different scatterlist structures pointing to the same memory
> region.

Pointing to the same memory should be fine, it's the act of passing
the same SG list to dma_map_sg twice that's wrong because dma_map_sg
will modify the SG list.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
