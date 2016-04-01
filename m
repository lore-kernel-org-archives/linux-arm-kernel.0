From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 1 Apr 2016 15:01:06 +0200
Subject: [PATCH v6 0/2] Fix dma mapping when the cache is coherent
In-Reply-To: <1459415380-18004-1-git-send-email-gregory.clement@free-electrons.com>
References: <1459415380-18004-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKfKJS4WEVNJBHu3063kFkMBEdqUgb5mSpQYyeN1pL5_QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

With the patches an issue with SoC hang in under-stress MTU change
test of network is no longer a problem. If you wish you can add:

Tested-by: Marcin Wojtas <mw@semihalf.com>

Best regards,
Marcin

2016-03-31 11:09 GMT+02:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> Hi,
>
> These two patches fixes the dma mapping functions when the system is
> cache coherent. The first one allows to fix an issue we have on Armada
> 375/38x with the PL310 that's why it is tagged for stable too.
>
> I didn't got any feedback on the fifth version 5 monthsago, and then I
> forgot to submit it to Russell patch system. In the meantime, there
> was many changes in the arch/arm/mm/dma-mapping.c file. So I had to
> rework the patch that's why I removed the reviewed flag from Catalin.
>
> The last version was posted here:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/446603
>
> Thanks,
>
> Gregory
>
> Changelog
> v5 -> v6:
>  - Rebased on v4.6-rc1
>
> v4 -> v5
>  - Keep the dmac_* function outside the !is_coherent case.
>
> v3 -> v4:
>  - Rebased on v4.3-rc1
>  - Fix conflict with commit "21caf3a765b0 ARM: 8398/1: arm DMA: Fix
>    allocation from CMA for coherent DMA"
>
> v2 -> v3:
>
>  - Fix comments in patch 1 as suggested by Catalin.
>  - Fix build issues in patch 2 (by using the multi_v7_defconfig +
>    CONFIG_ROCKCHIP_IOMMU).
>  - Add the arm_coherent_iommu_mmap_attrs function.
> Gregory CLEMENT (2):
>   ARM: dma-mapping: Don't use outer_flush_range when the L2C is coherent
>   ARM: dma-mapping: Fix the coherent case when iommu is used
>
>  arch/arm/mm/dma-mapping.c | 144 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 101 insertions(+), 43 deletions(-)
>
> --
> 2.5.0
>
