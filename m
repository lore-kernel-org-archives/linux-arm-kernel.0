From: pullip.cho@samsung.com (Cho KyongHo)
Date: Mon, 15 Jul 2013 20:24:29 +0900
Subject: [PATCH v7 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
In-Reply-To: <CANEJEGvajhgzUPG6ppbjwBb4-9TdU9em3T_SejBpz8NCjGHYTQ@mail.gmail.com>
References: <002801ce797b$3d2fbc80$b78f3580$@samsung.com>
 <CANEJEGvajhgzUPG6ppbjwBb4-9TdU9em3T_SejBpz8NCjGHYTQ@mail.gmail.com>
Message-ID: <009b01ce814d$def7a6c0$9ce6f440$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: grundler at google.com [mailto:grundler at google.com] On Behalf Of Grant Grundler
> Sent: Friday, July 12, 2013 2:23 AM
> 
> On Fri, Jul 5, 2013 at 5:29 AM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> > The current exynos-iommu(System MMU) driver does not work autonomously
> > since it is lack of support for power management of peripheral blocks.
> ...
> > Patch summary:
> > [PATCH v7 1/9] iommu/exynos: do not include removed header
> > [PATCH v7 2/9] iommu/exynos: add missing cache flush for removed page table entries
> > [PATCH v7 3/9] iommu/exynos: fix page table maintenance
> > [PATCH v7 4/9] iommu/exynos: allocate lv2 page table from own slab
> > [PATCH v7 5/9] iommu/exynos: change rwlock to spinlock
> > [PATCH v7 6/9] clk: exynos5250: add gate clock descriptions of System MMU
> > [PATCH v7 7/9] ARM: dts: Add description of System MMU of Exynos SoCs
> > [PATCH v7 8/9] iommu/exynos: support for device tree
> > [PATCH v7 9/9] iommu/exynos: add bus notifier for registering System MMU
> 
> Cho,
> Of the above patches, nearly all have been applied to chromeos-3.8
> (kernel-next git tree) by Doug Anderson and others.
> 
> AFAICT, the only ones not applied are:
>    [v7,3/9] iommu/exynos: fix page table maintenance
>    [v7,6/9] clk: exynos5250: add gate clock descriptions of System MMU
> (conflicts in this one)
>    [v7,7/9] ARM: dts: Add description of System MMU of Exynos SoCs
> (depends on 6/9)
> 
> We also already have parts of:
>    [v7,9/9] iommu/exynos: add bus notifier for registering System MMU
> 
> Some of those are being further discussed but I've lost track now
> exactly which ones.
> 
> I'm telling you about chromeos-3.8 status since the adopted changes
> have been reviewed (by me and others) are being tested manually here
> on several different Samsung Exynos platforms (including 5250 which is
> our "snow" platform). Not sure how you should to mark those patches
> since they aren't identical to your changes (which apply to post 3.10
> kernels, not 3.8).  You might consider splitting those patches out
> from the 4 I've listed above to get that series accepted upstream
> since the additional review/testing should provide some confidence
> those patches are good.
> 

I understand what you are concerning about.
Have you applied v6 patchset?

I will try to split the patches and make the changes from v6
on top of the v6 patcheset.

> cheers,
> grant

Thank you.

Cho KyonogHo.
