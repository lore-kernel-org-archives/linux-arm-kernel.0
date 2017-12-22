From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 22 Dec 2017 17:57:24 +1100
Subject: [PATCH RFC 1/4] crypto: engine - Permit to enqueue all async
 requests
In-Reply-To: <20171129084121.9385-2-clabbe.montjoie@gmail.com>
References: <20171129084121.9385-1-clabbe.montjoie@gmail.com>
 <20171129084121.9385-2-clabbe.montjoie@gmail.com>
Message-ID: <20171222065724.GA27149@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 09:41:18AM +0100, Corentin Labbe wrote:
> The crypto engine could actually only enqueue hash and ablkcipher request.
> This patch permit it to enqueue any type of crypto_async_request.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

This is going the wrong way.  We do not want to expose any of the
base types such as crypto_alg, crypto_async_request to end-users
and that includes drivers.  Only core API code should touch these
base types.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
