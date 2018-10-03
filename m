From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed,  3 Oct 2018 17:28:11 -0500
Subject: [PATCHv3 0/2] iommu/arm-smmu: Add Stratix10 SMMU Support
Message-ID: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add SMMU support for the Stratix10 SOCFPGA. This patch requires
clock enables for the master TBUs and therefore has a dependency
on patches currently being reviewed.

This patchset is dependent on the patch series
"[PATCH V6 0/4] clk: new APIs to handle all available clocks"
(https://lkml.org/lkml/2018/8/31/97)

v1->v2  Change to dependency on 
"iommu/arm-smmu: Add runtime pm/sleep support"
(https://patchwork.ozlabs.org/cover/946160/)

v2->v3  Change dependency on device tree bulk clock patches.

Thor Thayer (2):
  arm64: dts: stratix10: Add Stratix10 SMMU support
  iommu/arm-smmu: Add SMMU clock

 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 28 +++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                          | 20 ++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.7.4
