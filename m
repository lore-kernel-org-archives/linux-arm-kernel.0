From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 26 Jan 2016 22:48:54 +0800
Subject: [PATCH] crypto: hash - select CRYPTO_HASH where needed
In-Reply-To: <1453740685-1980366-1-git-send-email-arnd@arndb.de>
References: <1453740685-1980366-1-git-send-email-arnd@arndb.de>
Message-ID: <20160126144854.GB23264@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 05:51:21PM +0100, Arnd Bergmann wrote:
> The ghash and poly1305 hash implementations can be enabled when
> CONFIG_CRYPTO_HASH is turned off, causing a link error:
> 
> crypto/built-in.o: In function `ghash_mod_init':
> (.init.text+0xd0): undefined reference to `crypto_register_shash'
> crypto/built-in.o: In function `ghash_mod_exit':
> (.exit.text+0xb4): undefined reference to `crypto_unregister_shash'
> crypto/built-in.o: In function `poly1305_mod_init':
> (.init.text+0xb4): undefined reference to `crypto_register_shash'
> crypto/built-in.o: In function `poly1305_mod_exit':
> (.exit.text+0x98): undefined reference to `crypto_unregister_shash'
> 
> This adds an explicit 'select', like all other hashes have it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
