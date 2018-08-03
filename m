From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 3 Aug 2018 21:59:52 +0800
Subject: [PATCH] crypto: arm/chacha20 - always use vrev for 16-bit rotates
In-Reply-To: <20180725012907.1614-1-ebiggers3@gmail.com>
References: <20180725012907.1614-1-ebiggers3@gmail.com>
Message-ID: <20180803135952.6zbc32uibhnljelw@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 06:29:07PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The 4-way ChaCha20 NEON code implements 16-bit rotates with vrev32.16,
> but the one-way code (used on remainder blocks) implements it with
> vshl + vsri, which is slower.  Switch the one-way code to vrev32.16 too.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
