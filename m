From: john.garry@huawei.com (John Garry)
Date: Fri, 23 Jun 2017 09:47:16 +0100
Subject: [PATCH v2 0/8] io-pgtable lock removal
In-Reply-To: <cover.1498145008.git.robin.murphy@arm.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
Message-ID: <61b7b953-5bf4-eb45-c3e8-b4491e8fdca7@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/2017 16:53, Robin Murphy wrote:
> The feedback has been promising, so v2 is just a final update to cover
> a handful of memory ordering and cosmetic tweaks that came up when Will
> and I went through this offline.
>
> Thanks,
> Robin.

Hi Robin,

Is it worth us retesting this patchset?

If yes, as for a branch (for convenience), does this one now match v2:
git://linux-arm.org/linux-rm  iommu/pgtable

I saw it was rewritten recently.

Thanks,
John

>
>
> Robin Murphy (8):
>   iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
>   iommu/io-pgtable-arm: Improve split_blk_unmap
>   iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
>   iommu/io-pgtable: Introduce explicit coherency
>   iommu/io-pgtable-arm: Support lockless operation
>   iommu/io-pgtable-arm-v7s: Support lockless operation
>   iommu/arm-smmu: Remove io-pgtable spinlock
>   iommu/arm-smmu-v3: Remove io-pgtable spinlock
>
>  drivers/iommu/arm-smmu-v3.c        |  36 ++-----
>  drivers/iommu/arm-smmu.c           |  48 ++++------
>  drivers/iommu/io-pgtable-arm-v7s.c | 179 +++++++++++++++++++++-------------
>  drivers/iommu/io-pgtable-arm.c     | 191 ++++++++++++++++++++++++-------------
>  drivers/iommu/io-pgtable.h         |   6 ++
>  5 files changed, 274 insertions(+), 186 deletions(-)
>
