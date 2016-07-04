From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 4 Jul 2016 17:19:25 +0800
Subject: [PATCHv2 06/27] crypto: ahash: increase the maximum allowed
 statesize
In-Reply-To: <577A298E.4040803@ti.com>
References: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
 <1466601840-18486-7-git-send-email-t-kristo@ti.com>
 <20160624103209.GA19607@gondor.apana.org.au>
 <5770B283.8000902@ti.com>
 <20160627050031.GA5673@gondor.apana.org.au>
 <577A298E.4040803@ti.com>
Message-ID: <20160704091925.GA31964@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 12:17:02PM +0300, Tero Kristo wrote:
>
> I need some clarification on this, afaik request_alloc related
> functionality only works per-request basis. The export / import
> functionality however is supposed to work across multiple requests.
> The test code for example does this:

Why are you trying to allocate memory in export/import at all?
The preferred approach is to unconditionally allocate the memory
in ahash_request_alloc.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
