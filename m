From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 13 Mar 2014 09:56:25 +0800
Subject: [PATCH 1/3 V2] crypto: Fix the pointer voodoo in unaligned ahash
In-Reply-To: <201403130220.29346.marex@denx.de>
References: <1389720829-5963-1-git-send-email-marex@denx.de>
 <1393806108-6374-1-git-send-email-marex@denx.de>
 <20140312120814.GA25881@gondor.apana.org.au>
 <201403130220.29346.marex@denx.de>
Message-ID: <20140313015624.GA2680@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 02:20:29AM +0100, Marek Vasut wrote:
>
> OK, understood. But shall we not preserve the request intact in case a crypto-
> api function called crypto_ahash_final() with request which has .priv already 
> set? Then we would have really funny corruption of the request going on and I'm 
> not sure that'd be nice.

The priv field is only ever used by ahash.c so how can this happen?
The crypto API refers to code in the API itself, excluding drivers
and users.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
