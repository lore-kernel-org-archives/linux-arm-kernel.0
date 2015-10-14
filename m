From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 14 Oct 2015 14:56:20 +0200
Subject: [PATCH v5 0/6] MT8173 IOMMU SUPPORT
In-Reply-To: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <20151014125620.GQ27420@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 10:23:02AM +0800, Yong Wu wrote:
> Yong Wu (6):
>   dt-bindings: iommu: Add binding for mediatek IOMMU
>   dt-bindings: mediatek: Add smi dts binding
>   iommu: add ARM short descriptor page table allocator
>   memory: mediatek: Add SMI driver
>   iommu/mediatek: Add mt8173 IOMMU driver
>   dts: mt8173: Add iommu/smi nodes for mt8173
> 
>  .../devicetree/bindings/iommu/mediatek,iommu.txt   |  61 ++
>  .../memory-controllers/mediatek,smi-larb.txt       |  25 +
>  .../bindings/memory-controllers/mediatek,smi.txt   |  24 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  81 ++
>  drivers/iommu/Kconfig                              |  33 +
>  drivers/iommu/Makefile                             |   2 +
>  drivers/iommu/io-pgtable-arm-short.c               | 827 +++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c                     |   3 -
>  drivers/iommu/io-pgtable.c                         |   3 +
>  drivers/iommu/io-pgtable.h                         |  18 +-
>  drivers/iommu/mtk_iommu.c                          | 767 +++++++++++++++++++
>  drivers/memory/Kconfig                             |   8 +
>  drivers/memory/Makefile                            |   1 +
>  drivers/memory/mtk-smi.c                           | 274 +++++++
>  include/dt-bindings/memory/mt8173-larb-port.h      | 105 +++
>  include/soc/mediatek/smi.h                         |  60 ++

So this contains not only IOMMU code. Are the patches dependent on each
other or can the iommu parts be merged independently?



	Joerg
