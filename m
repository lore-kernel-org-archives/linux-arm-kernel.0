From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 7 Oct 2017 12:19:58 +0800
Subject: [PATCH 1/2] crypto: stm32 - Fix uninitialized data usage
In-Reply-To: <20170912093553.2580986-1-arnd@arndb.de>
References: <20170912093553.2580986-1-arnd@arndb.de>
Message-ID: <20171007041958.GF29803@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 12, 2017 at 11:35:38AM +0200, Arnd Bergmann wrote:
> The error handling in stm32_hash_irq_thread passes
> uninitialized data into stm32_hash_finish_req, as gcc
> points out:
> 
> drivers/crypto/stm32/stm32-hash.c: In function 'stm32_hash_irq_thread':
> drivers/crypto/stm32/stm32-hash.c:1088:2: error: 'err' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> I could not tell what data should be passed there instead,
> so this changes the code to always pass zero, making it
> well-defined, though possibly still wrong. Please check.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This is already fixed in cryptodev.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
