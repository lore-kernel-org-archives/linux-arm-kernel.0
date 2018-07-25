From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 25 Jul 2018 13:24:35 -0500
Subject: [PATCH 0/2] iommu/arm-smmu: Add Stratix10 SMMU Support
Message-ID: <1532543077-8933-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add SMMU support for the Stratix10 SOCFPGA. This patch requires
clock enables for the master TBUs and therefore has a dependency
on patches currently being reviewed.

This patchset is dependent on the patch series
"iommu/arm-smmu: Add runtime pm/sleep support"
(https://patchwork.ozlabs.org/cover/946160/)

Thor Thayer (2):
  arm64: dts: stratix10: Add Stratix10 SMMU support
  iommu/arm-smmu: Add support for Stratix10 smmu-v2 variant

 .../devicetree/bindings/iommu/arm,smmu.txt         | 25 ++++++++++++++++++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 30 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           | 12 +++++++++
 3 files changed, 67 insertions(+)

-- 
2.7.4
