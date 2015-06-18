From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 18 Jun 2015 17:37:30 +0800
Subject: [PATCH v6 05/14] crypto: marvell/CESA: add TDMA support
In-Reply-To: <20150618090400.GG7557@n2100.arm.linux.org.uk>
References: <1434527142-3609-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434527142-3609-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150617095001.GA11538@gondor.apana.org.au>
 <20150618090400.GG7557@n2100.arm.linux.org.uk>
Message-ID: <20150618093730.GA29911@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 10:04:00AM +0100, Russell King - ARM Linux wrote:
>
> If dma_map_sg() coalesces scatterlist entries, then ret will be smaller
> than src_nents, and ret indicates how many scatterlist entries to be
> walked during DMA - you should not use src_nents for that.  I couldn't
> see where the driver used that information.  In fact, the driver seems
> to be capable of walking more than src_nents/ret numbers of scatterlist
> entries: it just keeps going with sg_next() until it hits the end of
> the allocated scatterlist.

I think he should be OK even though he throws away the return value
because he's stopping his walk once the sum of sg_dma_length reaches
his end goal.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
