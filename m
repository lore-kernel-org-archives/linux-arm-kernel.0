From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 28 Jul 2018 00:05:29 +0800
Subject: [PATCH] crypto: arm64/sha256 - increase cra_priority of scalar
 implementations
In-Reply-To: <20180717170926.90689-1-ebiggers3@gmail.com>
References: <20180717170926.90689-1-ebiggers3@gmail.com>
Message-ID: <20180727160529.hvqcpaw432edqpt3@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 10:09:26AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Commit b73b7ac0a774 ("crypto: sha256_generic - add cra_priority") gave
> sha256-generic and sha224-generic a cra_priority of 100, to match the
> convention for generic implementations.  But sha256-arm64 and
> sha224-arm64 also have priority 100, so their order relative to the
> generic implementations became ambiguous.
> 
> Therefore, increase their priority to 125 so that they have higher
> priority than the generic implementations but lower priority than the
> NEON implementations which have priority 150.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
