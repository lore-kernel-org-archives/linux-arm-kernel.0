From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 28 Nov 2017 17:27:03 +0000
Subject: [PATCH 0/4] SMMU 52-bit address support
Message-ID: <cover.1511807303.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Hot on the heels of CPU 52-bit PA support[1], here's the SMMU counterpart
as promised (with bonus VA support since it's so trivial). Attempts to
extend the selftests to cope with the 64KB granule dependency for these
sizes have evolved into a larger effort to clean up and factor out common
parts of the selftest infrastructure, which will follow at a later date.

Robin.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-November/543127.html


Robin Murphy (4):
  iommu/arm-smmu-v3: Clean up address masking
  iommu/io-pgtable-arm: Support 52-bit physical address
  iommu/arm-smmu-v3: Support 52-bit physical address
  iommu/arm-smmu-v3: Support 52-bit virtual address

 drivers/iommu/arm-smmu-v3.c    | 75 ++++++++++++++++++++++--------------------
 drivers/iommu/io-pgtable-arm.c | 65 ++++++++++++++++++++++++++----------
 2 files changed, 86 insertions(+), 54 deletions(-)

-- 
2.13.4.dirty
