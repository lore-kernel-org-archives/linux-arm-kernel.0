From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 17 Jun 2015 20:25:33 +0800
Subject: [PATCH v6 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150617133324.1ee6ad55@bbrezillon>
References: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434527142-3609-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150617095001.GA11538@gondor.apana.org.au>
 <20150617133324.1ee6ad55@bbrezillon>
Message-ID: <20150617122533.GA13185@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 01:33:24PM +0200, Boris Brezillon wrote:
>
> Actually, I think I don't need to save the dma_map_sg return val, since
> I'm using the sg_next function to iterate over the scatterlist. Am I
> right ?
> IOW, is the ->map_sg() function (in dma_map_ops) supposed to merge the
> contiguous entries and then flag the unused entries with the is_chain
> flag ?

Right.  If you're simply using sg_dma_length in conjunction with
sg_next then you don't need the new length.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
