From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Apr 2013 01:59:25 +0900
Subject: [PATCH 0/3] ARM: S3C24XX: dma cleanups for s3c2412 and s3c2443
In-Reply-To: <201304212002.31082.heiko@sntech.de>
References: <201304212002.31082.heiko@sntech.de>
Message-ID: <51756C6D.9020500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/13 03:02, Heiko St?bner wrote:
> The s3c2412 uses the same dma channel selection-type as the s3c2443 and later
> but introduced the notion of a receive channel to keep the spi channels,
> together that are separate in hardware.
>
> This series split the spi channels like later socs do (the s3c24xx-spi driver
> does not use dma at all) and removes this type of special handling.
>
> Heiko Stuebner (3):
>    ARM: S3C24XX: split s3c2412 spi dma channels
>    ARM: S3C24XX: dma-s3c2443 - do not write into arbitary bits
>    ARM: S3C24XX: remove obsolete s3c2412 specific dma settings
>
>   arch/arm/mach-s3c24xx/dma-s3c2412.c              |   56 ++++++----------------
>   arch/arm/mach-s3c24xx/dma-s3c2443.c              |    3 +-
>   arch/arm/mach-s3c24xx/dma.c                      |    3 -
>   arch/arm/plat-samsung/include/plat/dma-s3c24xx.h |    5 --
>   4 files changed, 17 insertions(+), 50 deletions(-)
>
Applied, thanks.

- Kukjin
