From: john.garry@huawei.com (John Garry)
Date: Fri, 21 Sep 2018 10:20:23 +0100
Subject: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
Message-ID: <fdfc05a4-283f-3ae2-7928-59e625c8f3b8@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/2018 17:10, Robin Murphy wrote:
> Hi all,
>
> Hopefully this is the last spin of the series - I've now dropped my light
> touch and fixed up all the various prose text, plus implemented the proper
> quirk support for short-descriptor because it's actually just a trivial
> cut-and-paste job.
>
> Robin.
>

Hi Robin,

JFYI, I'm trying to test this patchset to get some figures and provide a 
tested-by tag, but 4/8 seems to rely on "iommu/io-pgtable-arm: Fix race 
handling in split_blk_unmap()" - more specifically, it seems to rely on 
the version which Will rewrote in your patch review, and I am not sure 
on what branch it exists on, if any.

Thanks,
John

>
> Robin Murphy (2):
>   iommu/io-pgtable-arm-v7s: Add support for non-strict mode
>   iommu/arm-smmu: Support non-strict mode
>
> Zhen Lei (5):
>   iommu/arm-smmu-v3: Implement flush_iotlb_all hook
>   iommu/dma: Add support for non-strict mode
>   iommu: Add "iommu.strict" command line option
>   iommu/io-pgtable-arm: Add support for non-strict mode
>   iommu/arm-smmu-v3: Add support for non-strict mode
>
>  .../admin-guide/kernel-parameters.txt         | 12 +++
>  drivers/iommu/arm-smmu-v3.c                   | 89 +++++++++++++-----
>  drivers/iommu/arm-smmu.c                      | 93 +++++++++++++------
>  drivers/iommu/dma-iommu.c                     | 32 ++++++-
>  drivers/iommu/io-pgtable-arm-v7s.c            | 11 ++-
>  drivers/iommu/io-pgtable-arm.c                | 14 ++-
>  drivers/iommu/io-pgtable.h                    |  5 +
>  drivers/iommu/iommu.c                         | 23 +++++
>  include/linux/iommu.h                         |  1 +
>  9 files changed, 225 insertions(+), 55 deletions(-)
>
