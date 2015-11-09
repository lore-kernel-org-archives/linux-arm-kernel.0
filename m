From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 9 Nov 2015 15:38:10 +0800
Subject: [PATCH] crypto: sun4i-ss: add missing statesize
In-Reply-To: <1447054026-4243-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1447054026-4243-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20151109073745.GA3106@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 08:27:06AM +0100, LABBE Corentin wrote:
> sun4i-ss implementaton of md5/sha1 is via ahash algorithms.
> A recent change make impossible to load them without giving statesize.
> This patch specifiy statesize for sha1 and md5.
> 
> Fixes: 8996eafdcbad ("crypto: ahash - ensure statesize is non-zero")

Nack.  As I said this commit is absolutely correct and if you really
have to slap on a fixes header then make it the original changeset
that added the driver.  It's the driver that's broken, not the API.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
