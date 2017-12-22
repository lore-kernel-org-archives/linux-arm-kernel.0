From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 22 Dec 2017 20:06:03 +1100
Subject: [PATCH RFC 1/4] crypto: engine - Permit to enqueue all async
 requests
In-Reply-To: <20171222084148.GA3024@Red>
References: <20171129084121.9385-1-clabbe.montjoie@gmail.com>
 <20171129084121.9385-2-clabbe.montjoie@gmail.com>
 <20171222065724.GA27149@gondor.apana.org.au>
 <20171222084148.GA3024@Red>
Message-ID: <20171222090603.GB32542@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 09:41:48AM +0100, Corentin Labbe wrote:
>
> It's you that was suggesting using crypto_async_request:
> https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1474434.html
> "The only wart with this scheme is that the drivers end up seeing
> struct crypto_async_request and will need to convert that to the
> respective request types but I couldn't really find a better way."
> 
> So I wait for any suggestion.

The core engine code obviously will use the base type but it should
not be exposed to the driver authors.  IOW all exposed API should
take the final types such as aead_request before casting it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
