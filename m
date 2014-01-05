From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 5 Jan 2014 21:05:29 +0800
Subject: [PATCH 1/5] crypto: Fully restore ahash request before completing
In-Reply-To: <1386703583-8386-1-git-send-email-marex@denx.de>
References: <1386703583-8386-1-git-send-email-marex@denx.de>
Message-ID: <20140105130529.GA26358@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 08:26:19PM +0100, Marek Vasut wrote:
> When finishing the ahash request, the ahash_op_unaligned_done() will
> call complete() on the request. Yet, this will not call the correct
> complete callback. The correct complete callback was previously stored
> in the requests' private data, as seen in ahash_op_unaligned(). This
> patch restores the correct complete callback and .data field of the
> request before calling complete() on it.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-crypto at vger.kernel.org

All patches applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
