From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 5 Dec 2013 22:35:29 +0800
Subject: [PATCH] crypto: omap-sham - Only release DMA channel if
 successfully requested
In-Reply-To: <1384287147-19656-1-git-send-email-mgreer@animalcreek.com>
References: <1384287147-19656-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <20131205143529.GB1976@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 01:12:27PM -0700, Mark A. Greer wrote:
> In omap_sham_probe() and omap_sham_remove(), 'dd->dma_lch'
> is released without checking to see if it was successfully
> requested or not.  This is a bug and was identified and
> reported by Dan Carpenter here:
> 
> 	http://www.spinics.net/lists/devicetree/msg11023.html
> 
> Add code to only release 'dd->dma_lch' when its not NULL
> (that is, when it was successfully requested).
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> CC: Joel Fernandes <joelf@ti.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
