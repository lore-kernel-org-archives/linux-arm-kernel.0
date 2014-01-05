From: marex@denx.de (Marek Vasut)
Date: Sun, 5 Jan 2014 16:33:21 +0100
Subject: [PATCH 1/5] crypto: Fully restore ahash request before completing
In-Reply-To: <20140105130529.GA26358@gondor.apana.org.au>
References: <1386703583-8386-1-git-send-email-marex@denx.de>
 <20140105130529.GA26358@gondor.apana.org.au>
Message-ID: <201401051633.21894.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, January 05, 2014 at 02:05:29 PM, Herbert Xu wrote:
> On Tue, Dec 10, 2013 at 08:26:19PM +0100, Marek Vasut wrote:
> > When finishing the ahash request, the ahash_op_unaligned_done() will
> > call complete() on the request. Yet, this will not call the correct
> > complete callback. The correct complete callback was previously stored
> > in the requests' private data, as seen in ahash_op_unaligned(). This
> > patch restores the correct complete callback and .data field of the
> > request before calling complete() on it.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: linux-crypto at vger.kernel.org
> 
> All patches applied.  Thanks!

Uh, I think this was not intended to happen! We still discuss this patch will 
need rework, do we not?

Best regards,
Marek Vasut
