From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 12 Sep 2017 21:00:35 +0800
Subject: [PATCH v2 0/3] arm-smmu: performance optimization
Message-ID: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v1 -> v2:
base on (add02cfdc9bc2 "iommu: Introduce Interface for IOMMU TLB Flushing")

Zhen Lei (3):
  iommu/arm-smmu-v3: put off the execution of TLBI* to reduce lock
    confliction
  iommu/arm-smmu-v3: add support for unmap an iova range with only one
    tlb sync
  iommu/arm-smmu: add support for unmap a memory range with only one tlb
    sync

 drivers/iommu/arm-smmu-v3.c        | 52 ++++++++++++++++++++++++++++++++++----
 drivers/iommu/arm-smmu.c           | 10 ++++++++
 drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++--------
 drivers/iommu/io-pgtable-arm.c     | 30 ++++++++++++++--------
 drivers/iommu/io-pgtable.h         |  1 +
 5 files changed, 99 insertions(+), 26 deletions(-)

-- 
2.5.0
