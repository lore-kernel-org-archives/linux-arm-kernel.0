From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 13 Jan 2017 00:44:36 +0800
Subject: [PATCH 1/2] crypto: mediatek - remove ARM dependencies
In-Reply-To: <20170111135104.3961730-1-arnd@arndb.de>
References: <20170111135104.3961730-1-arnd@arndb.de>
Message-ID: <20170112164435.GB20313@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 02:50:19PM +0100, Arnd Bergmann wrote:
> Building the mediatek driver on an older ARM architecture results in a
> harmless warning:
> 
> warning: (ARCH_OMAP2PLUS_TYPICAL && CRYPTO_DEV_MEDIATEK) selects NEON which has unmet direct dependencies (VFPv3 && CPU_V7)
> 
> We could add an explicit dependency on CPU_V7, but it seems nicer to
> open up the build to additional configurations. This replaces the ARM
> optimized algorithm selection with the normal one that all other drivers
> use, and that in turn lets us relax the dependency on ARM and drop
> a number of the unrelated 'select' statements.
> 
> Obviously a real user would still select those other optimized drivers
> as a fallback, but as there is no strict dependency, we can leave that
> up to the user.
> 
> Fixes: 785e5c616c84 ("crypto: mediatek - Add crypto driver support for some MediaTek chips")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
