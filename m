From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 18 Jun 2013 18:57:13 +0200
Subject: [PATCH] hwrng: bcm2835: fix MODULE_LICENSE tag
In-Reply-To: <1366732475-479886-4-git-send-email-arnd@arndb.de>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
 <1366732475-479886-4-git-send-email-arnd@arndb.de>
Message-ID: <1371574633.18688.9.camel@hobbes.kokotovo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-04-23 at 17:54 +0200, Arnd Bergmann wrote:
> The MODULE_LICENSE macro invocation must use either "GPL" or "GPL v2",
> but not "GPLv2" in order to be detected by the module loader.
> 
> This fixes the allmodconfig build error:
> 
> FATAL: modpost: GPL-incompatible module bcm2835-rng.ko uses GPL-only symbol 'platform_driver_unregister'

Thank you, obviously a typo of mine that slipped through. I'm wondering
if this could get queued for 3.10; it definitely can't do any harm.

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Dom Cobley <popcornmix@gmail.com>
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Matt Mackall <mpm@selenic.com>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  drivers/char/hw_random/bcm2835-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
> index eb7f147..43577ca 100644
> --- a/drivers/char/hw_random/bcm2835-rng.c
> +++ b/drivers/char/hw_random/bcm2835-rng.c
> @@ -110,4 +110,4 @@ module_platform_driver(bcm2835_rng_driver);
>  
>  MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
>  MODULE_DESCRIPTION("BCM2835 Random Number Generator (RNG) driver");
> -MODULE_LICENSE("GPLv2");
> +MODULE_LICENSE("GPL v2");
