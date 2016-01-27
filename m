From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 27 Jan 2016 22:17:46 +0800
Subject: [PATCH v2 2/2] crypto: jitterentropy - always select CRYPTO_RNG
In-Reply-To: <1453816035-3070440-1-git-send-email-arnd@arndb.de>
References: <1453815902-3070323-1-git-send-email-arnd@arndb.de>
 <1453816035-3070440-1-git-send-email-arnd@arndb.de>
Message-ID: <20160127141746.GC1601@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 02:47:10PM +0100, Arnd Bergmann wrote:
> When building the jitterentropy driver by itself, we get a link error
> when CRYPTO_RNG is not enabled as well:
> 
> crypto/built-in.o: In function `jent_mod_init':
> jitterentropy-kcapi.c:(.init.text+0x98): undefined reference to `crypto_register_rng'
> crypto/built-in.o: In function `jent_mod_exit':
> jitterentropy-kcapi.c:(.exit.text+0x60): undefined reference to `crypto_unregister_rng'
> 
> This adds a 'select CRYPTO_RNG' to CRYPTO_JITTERENTROPY to ensure the API
> is always there when it's used, not just when DRBG is also enabled.
> CRYPTO_DRBG would set it implicitly through CRYPTO_JITTERENTROPY now,
> but this leaves it in place to make it explicit what the driver does.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
