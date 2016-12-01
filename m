From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 1 Dec 2016 20:56:16 +0800
Subject: [PATCH] crypto: arm/aesbs - Select SIMD in Kconfig
In-Reply-To: <20161130234826.854879-1-arnd@arndb.de>
References: <20161130234826.854879-1-arnd@arndb.de>
Message-ID: <20161201125616.GB2249@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 12:47:59AM +0100, Arnd Bergmann wrote:
> Commit 585b5fa63da9 ("crypto: arm/aes - Select SIMD in Kconfig") added
> the dependency for CRYPTO_AES_ARM_CE, but missed the same change
> for CRYPTO_AES_ARM_BS:
> 
> arch/arm/crypto/aes-arm-bs.o: In function `aesbs_mod_init':
> aesbs-glue.c:(.init.text+0x38): undefined reference to `simd_skcipher_create_compat'
> 
> Fixes: 211f41af534a ("crypto: aesbs - Convert to skcipher")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd.  This should already be fixed by 6fdf436fd854.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
