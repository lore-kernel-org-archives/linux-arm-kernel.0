From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 30 Apr 2017 01:54:41 +0800
Subject: [PATCH] crypto: stm32 - fix building as a module
In-Reply-To: <20170427110907.2515229-1-arnd@arndb.de>
References: <20170427110907.2515229-1-arnd@arndb.de>
Message-ID: <20170429175441.GA11834@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 01:07:07PM +0200, Arnd Bergmann wrote:
> The names in the MODULE_DEVICE_TABLE and the actual array don't match:
> 
> drivers/crypto/stm32/stm32_crc32.c:309:21: error: 'sti_dt_ids' undeclared here (not in a function); did you mean 'stm32_dt_ids'?
> 
> This changes the reference that was evidently copied incorrectly from
> another driver.
> 
> Fixes: b51dbe90912a ("crypto: stm32 - Support for STM32 CRC32 crypto module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This has already been fixed by

https://patchwork.kernel.org/patch/9698299/

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
