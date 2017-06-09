From: nwatters@codeaurora.org (Nate Watterson)
Date: Fri, 9 Jun 2017 15:28:46 -0400
Subject: [PATCH 0/8] io-pgtable lock removal
In-Reply-To: <cover.1496921366.git.robin.murphy@arm.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
Message-ID: <458ad41d-6679-eeca-3c0f-13ccb6c933b6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 6/8/2017 7:51 AM, Robin Murphy wrote:
> Hi all,
> 
> Here's the cleaned up nominally-final version of the patches everybody's
> keen to see. #1 is just a non-critical thing-I-spotted-in-passing fix,
> #2-#4 do some preparatory work (and bid farewell to everyone's least
> favourite bit of code, hooray!), and #5-#8 do the dirty deed itself.
> 
> The branch I've previously shared has been updated too:
> 
>    git://linux-arm.org/linux-rm  iommu/pgtable
> 
> All feedback welcome, as I'd really like to land this for 4.13.
>

I tested the series on a QDF2400 development platform and see notable
performance improvements particularly in workloads that make concurrent
accesses to a single iommu_domain.

> Robin.
> 
> 
> Robin Murphy (8):
>    iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
>    iommu/io-pgtable-arm: Improve split_blk_unmap
>    iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
>    iommu/io-pgtable: Introduce explicit coherency
>    iommu/io-pgtable-arm: Support lockless operation
>    iommu/io-pgtable-arm-v7s: Support lockless operation
>    iommu/arm-smmu: Remove io-pgtable spinlock
>    iommu/arm-smmu-v3: Remove io-pgtable spinlock
> 
>   drivers/iommu/arm-smmu-v3.c        |  36 ++-----
>   drivers/iommu/arm-smmu.c           |  48 ++++------
>   drivers/iommu/io-pgtable-arm-v7s.c | 173 +++++++++++++++++++++------------
>   drivers/iommu/io-pgtable-arm.c     | 190 ++++++++++++++++++++++++-------------
>   drivers/iommu/io-pgtable.h         |   6 ++
>   5 files changed, 268 insertions(+), 185 deletions(-)
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
