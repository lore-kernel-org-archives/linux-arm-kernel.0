From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 Feb 2013 06:49:50 -0800
Subject: [PATCH V4 0/5] Add generic DMA DT binding support
In-Reply-To: <1360571905-15285-1-git-send-email-padma.v@samsung.com>
References: <1360571905-15285-1-git-send-email-padma.v@samsung.com>
Message-ID: <20130212144950.GJ3789@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 02:08:20PM +0530, Padmavathi Venna wrote:

This looks fine, I have only question. The code seems to assume that pl330 dma
controller always uses DT. But I dont see that as dependency for pl330.

Something tells me withot OF the driver may not build, have you checked it?

> This patch set adds support for generic dma device tree bindings for
> Samsung platforms and is dependent on the following patches from
> Vinod Koul next branch
> 1)of: Add generic device tree DMA helpers
> 2)dmaengine: add helper function to request a slave DMA channel
> 
> This patch set is made based Mark Brown next branch
Is this targetted for ASoC tree, if so why? It would fail to build if applied
there

--
~Vinod
> 
> Padmavathi Venna (5):
>   DMA: PL330: Add new pl330 filter for DT case.
>   DMA: PL330: Add xlate function
>   DMA: PL330: Register the DMA controller with the generic DMA helpers
>   ARM: dts: pl330: Add #dma-cells for generic dma binding support
>   ARM: SAMSUNG: dma: Remove unnecessary code
> 
>  .../devicetree/bindings/dma/arm-pl330.txt          |   21 +++++--
>  arch/arm/boot/dts/exynos5250.dtsi                  |   12 ++++
>  arch/arm/mach-s3c24xx/include/mach/dma.h           |    1 -
>  arch/arm/mach-s3c64xx/include/mach/dma.h           |    1 -
>  arch/arm/plat-samsung/dma-ops.c                    |   10 +---
>  arch/arm/plat-samsung/include/plat/dma-ops.h       |    1 -
>  arch/arm/plat-samsung/include/plat/dma-pl330.h     |    1 -
>  drivers/dma/pl330.c                                |   64 +++++++++++++++----
>  8 files changed, 79 insertions(+), 32 deletions(-)
> 
> -- 
> 1.7.4.4
> 
