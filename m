From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 17:21:41 +0000
Subject: [PATCH 2/2] ARM: S3C24XX: Move the DMA base code to mach-s3c24xx
In-Reply-To: <201202212226.57559.heiko@sntech.de>
References: <201202212221.41744.heiko@sntech.de>
 <201202212226.57559.heiko@sntech.de>
Message-ID: <201202221721.41262.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Heiko St?bner wrote:
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/mach-s3c24xx/Kconfig  |   18 +
>  arch/arm/mach-s3c24xx/Makefile |    1 +
>  arch/arm/mach-s3c24xx/dma.c    | 1469 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/plat-s3c24xx/Kconfig  |   16 -
>  arch/arm/plat-s3c24xx/Makefile |    1 -
>  arch/arm/plat-s3c24xx/dma.c    | 1469 ----------------------------------------
>  6 files changed, 1488 insertions(+), 1486 deletions(-)
>  create mode 100644 arch/arm/mach-s3c24xx/dma.c
>  delete mode 100644 arch/arm/plat-s3c24xx/dma.c
> 

Wouldn't it be more appropriate to move this driver to
drivers/dma/s3c24xx-dma.c instead? 

Even if it doesn't (yet) use the dmaengine API, I think it's
valuable to keep drivers with the same purpose together. We have
had similar discussions in other subsystems and ended up moving
the drivers into one directory first, followed by a conversion
to a common API (if someone could be motivated to do that work).

	Arnd
