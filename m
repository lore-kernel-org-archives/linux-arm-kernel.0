From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 2 Mar 2015 23:25:13 +1300
Subject: [PATCH v2] crypto: atmel: fix bogus select
In-Reply-To: <6741924.K1MvntTk7u@wuerfel>
References: <6741924.K1MvntTk7u@wuerfel>
Message-ID: <20150302102513.GB24294@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 04:38:19PM +0100, Arnd Bergmann wrote:
> The Atmel at91 crypto driver unconditionally selects AT_HDMAC,
> which results in a Kconfig warning if that driver is not enabled:
> 
> warning: (CRYPTO_DEV_ATMEL_AES) selects AT_HDMAC which has unmet direct dependencies (DMADEVICES && ARCH_AT91)
> 
> The crypty driver itself does not actually have a dependency
> on a particular dma engine, other than this being the one that
> is used in at91.
> 
> Removing the 'select' gets rid of the warning, but can cause
> the driver to be unusable if the HDMAC is not enabled at the
> same time. To work around that, this patch clarifies the runtime
> dependency to be '(ARCH_AT91 && AT_XDMAC)', but adds an alternative
> for COMPILE_TEST, which lets the driver get build on all systems.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

If this is meant to go through the crypto tree it needs to cc
linux-crypto at vger.kernel.org.  Otherwise please carry on :)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
