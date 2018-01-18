From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 18 Jan 2018 23:03:14 +1100
Subject: [PATCH] crypto: marvell/cesa - Fix DMA API misuse
In-Reply-To: <55d3177407b00dd4a9d51fe4f8e2bf2282fe8e3d.1515596541.git.robin.murphy@arm.com>
References: <55d3177407b00dd4a9d51fe4f8e2bf2282fe8e3d.1515596541.git.robin.murphy@arm.com>
Message-ID: <20180118120314.GG20717@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 03:15:43PM +0000, Robin Murphy wrote:
> phys_to_dma() is an internal helper for certain DMA API implementations,
> and is not appropriate for drivers to use. It appears that what the CESA
> driver really wants to be using is dma_map_resource() - admittedly that
> didn't exist when the offending code was first merged, but it does now.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
