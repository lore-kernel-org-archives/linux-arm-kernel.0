From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 12 Jul 2011 11:54:37 +0530
Subject: [PATCH] ARM:SAMSUNG: DMA Cleanup as per sparse [re-submit]
In-Reply-To: <1310401398-21104-1-git-send-email-sangwook.lee@linaro.org>
References: <1310401398-21104-1-git-send-email-sangwook.lee@linaro.org>
Message-ID: <4E1BE8A5.1010304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 July 2011 09:53 PM, Sangwook Lee wrote:
> Function declaration differs between file: dma.c and file:dma.h
> and SPARSE (Documentation/sparse.txt) gives error messages
>
> All dma channels are members of 'enum dma_ch' and not 'unsigned int'
> Please have a look at channel definitions in:
> arch/arm/mach-s3c64xx/include/mach/dma.h
> arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h
> arch/arm/mach-s3c2410/include/mach/dma.h
> So all arguments should be of type 'enum dma_ch'
>
> Signed-off-by: Sangwook Lee<sangwook.lee@linaro.org>
> ---
>   arch/arm/mach-s3c64xx/dma.c              |   14 +++++++-------
>   arch/arm/plat-s3c24xx/dma.c              |   12 ++++++------
>   arch/arm/plat-samsung/dma.c              |    6 +++---
>   arch/arm/plat-samsung/include/plat/dma.h |   21 +++++++++++----------
>   4 files changed, 27 insertions(+), 26 deletions(-)
>

Compilation is ok for following default configs.

s3c2410_defconfig
s3c6400_defconfig
s5p64x0_defconfig
s5pc100_defconfig
s5pv210_defconfig
exynos4_defconfig

-- 
Tushar Behera
