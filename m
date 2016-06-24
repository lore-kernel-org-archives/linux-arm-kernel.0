From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 24 Jun 2016 21:30:36 +0800
Subject: [PATCHv2 01/27] crypto: omap-sham: use runtime_pm autosuspend
 for clock handling
In-Reply-To: <1466601840-18486-2-git-send-email-t-kristo@ti.com>
References: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
 <1466601840-18486-2-git-send-email-t-kristo@ti.com>
Message-ID: <20160624133036.GA21111@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 04:23:34PM +0300, Tero Kristo wrote:
> Calling runtime PM API for every block causes serious performance hit to
> crypto operations that are done on a long buffer. As crypto is performed
> on a page boundary, encrypting large buffers can cause a series of crypto
> operations divided by page. The runtime PM API is also called those many
> times.
> 
> Convert the driver to use runtime_pm autosuspend instead, with a default
> timeout value of 1 second. This results in upto ~50% speedup.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Patches 1-4 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
