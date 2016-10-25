From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 25 Oct 2016 11:40:06 +0800
Subject: [PATCH v2] hwrng: meson: Fix module autoload for OF registration
In-Reply-To: <1476733877-20275-1-git-send-email-javier@osg.samsung.com>
References: <1476733877-20275-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20161025034006.GD18685@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 04:51:17PM -0300, Javier Martinez Canillas wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/char/hw_random/meson-rng.ko | grep alias
> alias:          platform:meson-rng
> 
> After this patch:
> 
> $ modinfo drivers/char/hw_random/meson-rng.ko | grep alias
> alias:          platform:meson-rng
> alias:          of:N*T*Camlogic,meson-rngC*
> alias:          of:N*T*Camlogic,meson-rng
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
