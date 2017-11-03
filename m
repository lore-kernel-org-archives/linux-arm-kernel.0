From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 3 Nov 2017 22:22:31 +0800
Subject: [PATCH 0/3] crypto: marvell - Remove the old CESA driver
In-Reply-To: <20171011131619.30196-1-boris.brezillon@free-electrons.com>
References: <20171011131619.30196-1-boris.brezillon@free-electrons.com>
Message-ID: <20171103142231.GD9011@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 03:16:16PM +0200, Boris Brezillon wrote:
> Hello,
> 
> It's been several releases since we added a new driver to support the
> CESA IP (the new driver was introduced in 4.2). It seems most major
> bugs have been discovered and fixed and now is probably a good time to
> kill the old driver and force remaining users to switch to the new one.
> 
> This series first add a platform_device_id table to the marvell CESA
> driver so that it can work on non-DT platforms. Then we patch all
> defconfigs to select the new driver instead of the old. And finally we
> remove the old driver.
> These patches have to be applied in this order to make things
> bisectable, so, if this series is accepted it will have to go through
> a single tree (either ARM or crypto).
> 
> Regards,
> 
> Boris
> 
> Boris Brezillon (3):
>   crypto: marvell - Add a platform_device_id table
>   ARM: configs: Stop selecting the old CESA driver
>   crypto: marvell - Remove the old mv_cesa driver
> 
>  arch/arm/configs/dove_defconfig     |    2 +-
>  arch/arm/configs/multi_v5_defconfig |    2 +-
>  arch/arm/configs/orion5x_defconfig  |    2 +-
>  drivers/crypto/Kconfig              |   22 +-
>  drivers/crypto/Makefile             |    1 -
>  drivers/crypto/marvell/cesa.c       |   13 +-
>  drivers/crypto/mv_cesa.c            | 1216 -----------------------------------
>  drivers/crypto/mv_cesa.h            |  150 -----
>  8 files changed, 12 insertions(+), 1396 deletions(-)
>  delete mode 100644 drivers/crypto/mv_cesa.c
>  delete mode 100644 drivers/crypto/mv_cesa.h

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
