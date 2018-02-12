From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 12 Feb 2018 11:20:42 +0100
Subject: [PATCH v3 5/7] mtd: nand: use Marvell reworked NAND controller
 driver with all platforms
In-Reply-To: <20180109103637.23798-6-miquel.raynal@free-electrons.com>
References: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
 <20180109103637.23798-6-miquel.raynal@free-electrons.com>
Message-ID: <20180212112042.5b3f758f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  9 Jan 2018 11:36:35 +0100
Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> Actually remove pxa3xx_nand.c to let marvell_nand.c be compiled instead.
> Also change the defconfig files using it as well as some board files
> depending on CONFIG_MTD_NAND_PXA3xx.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  arch/arm/configs/cm_x300_defconfig  |    2 +-
>  arch/arm/configs/pxa3xx_defconfig   |    3 +-
>  arch/arm/configs/pxa_defconfig      |    2 +-
>  arch/arm/configs/raumfeld_defconfig |    2 +-
>  arch/arm/mach-mmp/ttc_dkb.c         |    4 +-
>  arch/arm/mach-pxa/cm-x300.c         |    2 +-
>  arch/arm/mach-pxa/colibri-pxa3xx.c  |    2 +-
>  arch/arm/mach-pxa/colibri.h         |    2 +-
>  arch/arm/mach-pxa/littleton.c       |    4 +-
>  arch/arm/mach-pxa/mxm8x10.c         |    4 +-
>  arch/arm/mach-pxa/zylonite.c        |    4 +-
>  drivers/mtd/nand/Kconfig            |   11 -
>  drivers/mtd/nand/Makefile           |    1 -
>  drivers/mtd/nand/pxa3xx_nand.c      | 2104 -----------------------------------

Can you please split this patch in 2, one that patches defconfig and
board files to use the new driver and one that actually removes the old
driver.

Thanks,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
