From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 11 Mar 2016 21:31:04 +0800
Subject: [PATCH 07/14] hw_random: exynos: use __maybe_unused to hide pm
 functions
In-Reply-To: <1456934350-1389172-8-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-8-git-send-email-arnd@arndb.de>
Message-ID: <20160311133104.GB24332@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 04:58:59PM +0100, Arnd Bergmann wrote:
> The exynos random driver uses #ifdef to check for CONFIG_PM, but
> then uses SIMPLE_DEV_PM_OPS, which leaves the references out when
> CONFIG_PM_SLEEP is not defined, so we get a warning with
> PM=y && PM_SLEEP=n:
> 
> drivers/char/hw_random/exynos-rng.c:166:12: error: 'exynos_rng_suspend' defined but not used [-Werror=unused-function]
> drivers/char/hw_random/exynos-rng.c:171:12: error: 'exynos_rng_resume' defined but not used [-Werror=unused-function]
> 
> This removes the incorrect #ifdef and instead uses a __maybe_unused
> annotation to let the compiler know it can silently drop
> the function definition.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
