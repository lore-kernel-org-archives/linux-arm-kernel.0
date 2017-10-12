From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 12 Oct 2017 16:25:28 +0200
Subject: [PATCH 0/3] crypto: marvell - Remove the old CESA driver
In-Reply-To: <20171011131619.30196-1-boris.brezillon@free-electrons.com>
 (Boris Brezillon's message of "Wed, 11 Oct 2017 15:16:16 +0200")
References: <20171011131619.30196-1-boris.brezillon@free-electrons.com>
Message-ID: <87zi8wa1ev.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,
 
 On mer., oct. 11 2017, Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

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

For the whole series
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

And I am OK for this series going through crypto because I don't expect
any changes in the mvebu files so there won't be any merge conflict. But
I am also fine to take the series in my tree, it is up to Herbert Xu.

Thanks,

Gregory


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
>
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
