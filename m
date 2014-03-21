From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 21 Mar 2014 22:40:07 +0800
Subject: [PATCH 1/3 V4] crypto: Fix the pointer voodoo in unaligned ahash
In-Reply-To: <1394761026-7292-1-git-send-email-marex@denx.de>
References: <1394761026-7292-1-git-send-email-marex@denx.de>
Message-ID: <20140321144007.GA25820@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 02:37:04AM +0100, Marek Vasut wrote:
> Add documentation for the pointer voodoo that is happening in crypto/ahash.c
> in ahash_op_unaligned(). This code is quite confusing, so add a beefy chunk
> of documentation.
> 
> Moreover, make sure the mangled request is completely restored after finishing
> this unaligned operation. This means restoring all of .result, .base.data
> and .base.complete .
> 
> Also, remove the crypto_completion_t complete = ... line present in the
> ahash_op_unaligned_done() function. This type actually declares a function
> pointer, which is very confusing.
> 
> Finally, yet very important nonetheless, make sure the req->priv is free()'d
> only after the original request is restored in ahash_op_unaligned_done().
> The req->priv data must not be free()'d before that in ahash_op_unaligned_finish(),
> since we would be accessing previously free()'d data in ahash_op_unaligned_done()
> and cause corruption.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>

All applied.  Thanks Marek!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
