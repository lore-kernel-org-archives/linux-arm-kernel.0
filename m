From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 12 Mar 2014 20:08:14 +0800
Subject: [PATCH 1/3 V2] crypto: Fix the pointer voodoo in unaligned ahash
In-Reply-To: <1393806108-6374-1-git-send-email-marex@denx.de>
References: <1389720829-5963-1-git-send-email-marex@denx.de>
 <1393806108-6374-1-git-send-email-marex@denx.de>
Message-ID: <20140312120814.GA25881@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 01:21:46AM +0100, Marek Vasut wrote:
> Add documentation for the pointer voodoo that is happening in crypto/ahash.c
> in ahash_op_unaligned(). This code is quite confusing, so add a beefy chunk
> of documentation.
> 
> Moreover, make sure the mangled request is completely restored after finishing
> this unaligned operation. This means restoring all of .result, .priv, .base.data
> and .base.complete .

There is no point in saving priv because it is only meant to be
used by the crypto API.

Otherwise the patch looks OK to me.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
