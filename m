From: nwatters@codeaurora.org (Nate Watterson)
Date: Tue, 19 Sep 2017 00:31:03 -0400
Subject: [PATCH v2 0/3] arm-smmu: performance optimization
In-Reply-To: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
References: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <6b051916-c49f-f9d0-81d8-05f857e4672e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leizhen,

On 9/12/2017 9:00 AM, Zhen Lei wrote:
> v1 -> v2:
> base on (add02cfdc9bc2 "iommu: Introduce Interface for IOMMU TLB Flushing")
> 
> Zhen Lei (3):
>    iommu/arm-smmu-v3: put off the execution of TLBI* to reduce lock
>      confliction
>    iommu/arm-smmu-v3: add support for unmap an iova range with only one
>      tlb sync

I tested these (2) patches on QDF2400 hardware and saw performance
improvements in line with those I reported when testing the original
series. I don't have any hardware close at hand to test the 3rd patch
in the series so that will have to come from someone else.

Tested-by: Nate Watterson <nwatters@codeaurora.org>

Thanks,
Nate

>    iommu/arm-smmu: add support for unmap a memory range with only one tlb
>      sync
> 
>   drivers/iommu/arm-smmu-v3.c        | 52 ++++++++++++++++++++++++++++++++++----
>   drivers/iommu/arm-smmu.c           | 10 ++++++++
>   drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++--------
>   drivers/iommu/io-pgtable-arm.c     | 30 ++++++++++++++--------
>   drivers/iommu/io-pgtable.h         |  1 +
>   5 files changed, 99 insertions(+), 26 deletions(-)
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
