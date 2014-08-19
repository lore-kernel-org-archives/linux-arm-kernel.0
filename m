From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 Aug 2014 14:01:32 +0200
Subject: [PATCH 00/29] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <53F3375E.6030402@suse.de>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <20140818233201.GL9809@8bytes.org> <53F2E9AD.9030308@samsung.com>
 <53F3375E.6030402@suse.de>
Message-ID: <53F33C9C.1080601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2014-08-19 13:39, Andreas F?rber wrote:
> Hi Marek and Inki,
>
> Am 19.08.2014 08:07, schrieb Marek Szyprowski:
>> On 2014-08-19 01:32, Joerg Roedel wrote:
>>> On Tue, Aug 05, 2014 at 12:47:28PM +0200, Marek Szyprowski wrote:
> [...]
>>>>    33 files changed, 1016 insertions(+), 356 deletions(-)
>>> This touches a lot of non-iommu stuff. What is your strategy on getting
>>> this in, do you plan to get the non-iommu changes merged first or do you
>>> want to collect the respective Acks and merge this all through one tree?
>> Those patches are posted as one patchset mainly to demonstrate how to get
>> everything to work together. I also posted this as a single patch series
>> to get some feedback from other iommu developers, especially all those
>> involved in the generic iommu dt bindings.
>>
>> For merging, I will split them into smaller series and try to get
>> respective acks.
> I'm working on 5250 based Spring Chromebook and noticed that v3.17-rc1
> got some more iommu support. With the new CONFIG_DRM_EXYNOS_IOMMU=y my
> machine stops booting. So I'm wondering, is any of this a fix for 3.17,
> or is all of this "unrelated" -next material?

This is probably a side effect of patch 
3170447c1f264d51b8d1f3898bf2588588a64fdc
("iommu/exynos: Select ARM_DMA_USE_IOMMU"). It added selection of 
ARM_DMA_USE_IOMMU
symbol, on which IOMMU support in Exynos DRM subsystem depends. However 
selecting
this symbol is all that this patch does, without providing any code code 
which
implements real support for ARM DMA IOMMU integration, which is needed 
by Exynos
DRM driver. Please disable CONFIG_DRM_EXYNOS_IOMMU in kernel .config and 
your
system should be bootable again.

> Also, are you or someone
> working on the respective DT changes for Exynos5?

I can prepare DT changes for Exynos5 as well, but first I wanted to 
clarify if
everyone involved in generic IOMMU bindings and Exynos IOMMU driver 
agrees on my
proposal.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
