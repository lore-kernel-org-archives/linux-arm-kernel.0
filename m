From: marex@denx.de (Marek Vasut)
Date: Thu, 13 Mar 2014 02:20:29 +0100
Subject: [PATCH 1/3 V2] crypto: Fix the pointer voodoo in unaligned ahash
In-Reply-To: <20140312120814.GA25881@gondor.apana.org.au>
References: <1389720829-5963-1-git-send-email-marex@denx.de>
 <1393806108-6374-1-git-send-email-marex@denx.de>
 <20140312120814.GA25881@gondor.apana.org.au>
Message-ID: <201403130220.29346.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 12, 2014 at 01:08:14 PM, Herbert Xu wrote:
> On Mon, Mar 03, 2014 at 01:21:46AM +0100, Marek Vasut wrote:
> > Add documentation for the pointer voodoo that is happening in
> > crypto/ahash.c in ahash_op_unaligned(). This code is quite confusing, so
> > add a beefy chunk of documentation.
> > 
> > Moreover, make sure the mangled request is completely restored after
> > finishing this unaligned operation. This means restoring all of .result,
> > .priv, .base.data and .base.complete .
> 
> There is no point in saving priv because it is only meant to be
> used by the crypto API.

OK, understood. But shall we not preserve the request intact in case a crypto-
api function called crypto_ahash_final() with request which has .priv already 
set? Then we would have really funny corruption of the request going on and I'm 
not sure that'd be nice.

> Otherwise the patch looks OK to me.

Thanks!

Best regards,
Marek Vasut
