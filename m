From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 23 Nov 2015 21:05:10 +0800
Subject: [PATCH v3] crypto: atmel: fix bogus select
In-Reply-To: <12173927.U7ILfy5BBh@wuerfel>
References: <12173927.U7ILfy5BBh@wuerfel>
Message-ID: <20151123130510.GF7866@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 04:33:54PM +0100, Arnd Bergmann wrote:
> >From 0d53d42a56e9a3769847fd03c703876f2c063fb4 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 27 Jan 2015 22:34:04 +0100
> Subject: [PATCH] [SUBMITTED] crypto: atmel: fix bogus select
> 
> The Atmel at91 crypto driver unconditionally selects AT_HDMAC,
> which results in a Kconfig warning if that driver is not enabled:
> 
> warning: (CRYPTO_DEV_ATMEL_AES) selects AT_HDMAC which has unmet direct dependencies (DMADEVICES && ARCH_AT91)
> 
> The crypto driver itself does not actually have a dependency
> on a particular dma engine, other than this being the one that
> is used in at91.
> 
> Removing the 'select' gets rid of the warning, but can cause
> the driver to be unusable if the HDMAC is not enabled at the
> same time. To work around that, this patch clarifies the runtime
> dependency to be 'AT_HDMAC || AT_XDMAC', but adds an alternative
> for COMPILE_TEST, which lets the driver get build on all systems.
> 
> The ARCH_AT91 dependency is implied by AT_XDMAC || AT_HDMAC now
> and no longer needs to be listed separately.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
