From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Aug 2012 16:16:12 +0200
Subject: [PATCH 0/4] Per device coherent DMA map ops
In-Reply-To: <1344916147-13546-1-git-send-email-robherring2@gmail.com>
References: <1344916147-13546-1-git-send-email-robherring2@gmail.com>
Message-ID: <000601cd7ede$5d2ef390$178cdab0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, August 14, 2012 5:49 AM Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> This is series adds coherent DMA map operations which can be set per device.
> Expanding on the first RFC[1], this version adds iommu ops and implements
> support on highbank platform.
> 
> arch_is_coherent is never defined true since removing ixp2xxx, so we can
> remove it altogether.
> 
> Rob
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113921.html
> 
> Rob Herring (4):
>   ARM: add coherent dma ops
>   ARM: add coherent iommu dma ops
>   ARM: kill off arch_is_coherent
>   ARM: highbank: add coherent DMA setup
> 
>  .../devicetree/bindings/ata/ahci-platform.txt      |    3 +
>  .../devicetree/bindings/dma/arm-pl330.txt          |    3 +
>  .../devicetree/bindings/net/calxeda-xgmac.txt      |    3 +
>  arch/arm/boot/dts/highbank.dts                     |    1 +
>  arch/arm/include/asm/barrier.h                     |    7 +-
>  arch/arm/include/asm/dma-mapping.h                 |    1 +
>  arch/arm/include/asm/memory.h                      |    8 -
>  arch/arm/mach-highbank/highbank.c                  |   52 ++++
>  arch/arm/mm/dma-mapping.c                          |  254 ++++++++++++++++----
>  arch/arm/mm/mmu.c                                  |   17 +-
>  10 files changed, 271 insertions(+), 78 deletions(-)

I like those patches and I would like to take it to my dma-mapping-next tree, but I wonder 
how to handle merging of the last patch. Arnd, Olof - could You tell me how to do it? I assume
that it should be somehow merged by arm-soc tree, so it depends on the earlier patches.
Would it be enough if I take them to the topic branch? Then I can continue works on 
dma-mapping subsystem by merging that topic branch to my dma-mapping-next and you will
also take it as a dependency for highbank patches. Am I right?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
