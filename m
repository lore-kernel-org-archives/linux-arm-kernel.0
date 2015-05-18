From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 18 May 2015 14:16:09 +0200
Subject: [PATCH v6 00/25] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <20150505150554.GN15736@8bytes.org>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <20150505150554.GN15736@8bytes.org>
Message-ID: <5559D809.7080501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-05-05 17:05, Joerg Roedel wrote:
> Hi Marek,
>
> On Mon, May 04, 2015 at 10:15:55AM +0200, Marek Szyprowski wrote:
>>    iommu: exynos: don't read version register on every tlb operation
> Please use 'iommu/exynos:' as prefix for the iommu patches and start
> the remaining subject with a capital letter, like this:
>
> 	iommu/exynos: Don't read version register on every tlb operation

Okay, I will post an updated version soon

>>   Documentation/devicetree/bindings/iommu/iommu.txt |  44 ++
>>   arch/arm/boot/dts/exynos3250-rinato.dts           |   1 +
>>   arch/arm/boot/dts/exynos3250.dtsi                 |  22 +
>>   arch/arm/boot/dts/exynos4.dtsi                    | 118 ++++++
>>   arch/arm/boot/dts/exynos4210-trats.dts            |   1 +
>>   arch/arm/boot/dts/exynos4210-universal_c210.dts   |   1 +
>>   arch/arm/boot/dts/exynos4210.dtsi                 |  23 +
>>   arch/arm/boot/dts/exynos4412-trats2.dts           |   1 +
>>   arch/arm/boot/dts/exynos4415.dtsi                 |  11 +
>>   arch/arm/boot/dts/exynos4x12.dtsi                 |  82 ++++
>>   arch/arm/boot/dts/exynos5250-snow.dts             |   1 +
>>   arch/arm/boot/dts/exynos5250-spring.dts           |   1 +
>>   arch/arm/boot/dts/exynos5250.dtsi                 | 250 +++++++++++
>>   arch/arm/boot/dts/exynos5420-peach-pit.dts        |   1 +
>>   arch/arm/boot/dts/exynos5420.dtsi                 | 181 ++++++++
>>   arch/arm/boot/dts/exynos5800-peach-pi.dts         |   1 +
>>   arch/arm/mach-exynos/pm_domains.c                 |  18 +-
>>   arch/arm/mm/dma-mapping.c                         | 112 +++++
>>   drivers/gpu/drm/exynos/exynos_drm_fimd.c          |  27 +-
>>   drivers/gpu/drm/exynos/exynos_drm_iommu.c         |   3 +
>>   drivers/iommu/exynos-iommu.c                      | 495 ++++++++++------------
>>   21 files changed, 1098 insertions(+), 296 deletions(-)
> What is the plan for merging this, should it go through the iommu tree
> or some other path?

I would prefer to split those patches into 3 trees and merge as follows:
- DTS changes and power domain changes via Samsung tree to avoid 
conflicts with
   other DTS patches
- all exynos-iommu patches and dma-mapping/reserved iommu region via 
IOMMU tree,
- all Exynos DRM patches via DRM/Exynos tree.

There are no build cross-subsystem dependencies and IOMMU on Exynos is 
already
nonfunctional (and disabled in defconfig) till now, so merging patches 
in parts
doesn't break anything.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
