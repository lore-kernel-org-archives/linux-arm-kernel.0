From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 27 Jul 2014 22:52:54 +0800
Subject: [PATCH v4 3/3] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <53D3B4B6.3000100@gmail.com>
References: <1405169953-13695-1-git-send-email-clabbe.montjoie@gmail.com>
 <1405169953-13695-4-git-send-email-clabbe.montjoie@gmail.com>
 <20140724060054.GA6545@gondor.apana.org.au>
 <53D0E857.8000405@gmail.com>
 <20140724133823.GA9638@gondor.apana.org.au>
 <53D3B4B6.3000100@gmail.com>
Message-ID: <20140727145254.GA2932@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 26, 2014 at 04:01:26PM +0200, Corentin LABBE wrote:
>
> Even if it is undocumented, the hardware seems to support it.
> Since crypto_ahash_ctx is for a tfm, does ahash_request_ctx is the good place to store data ?
> (after a call to crypto_ahash_set_reqsize in cra_init)

Yes any hash state-related data should go into the request context.

> I have also seen export/import function, does I need to use it ?

Absolutely.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
