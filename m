From: hannah@marvell.com (hannah at marvell.com)
Date: Mon, 15 Oct 2018 15:00:42 +0300
Subject: [PATCH 0/4] Add system mmu support for Armada-806
Message-ID: <1539604846-21151-1-git-send-email-hannah@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanna Hawa <hannah@marvell.com>

This series add support for IOMMU for AP806, including workaround
for accessing ARM SMMU 64bit registers.
AP-806 can't access SMMU registers with 64bit width, this patches split
the readq/writeq for 32bit access, due to erratanum #582743.

Hanna Hawa (4):
  iommu/arm-smmu: introduce wrapper for writeq/readq
  iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
    #582743
  dt-bindings: iommu/arm,smmu: add compatible string for Marvell
  arm64: dts: marvell: add smmu node for Armada-AP806

 Documentation/arm64/silicon-errata.txt             |  2 +
 .../devicetree/bindings/iommu/arm,smmu.txt         |  1 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 18 ++++++
 drivers/iommu/arm-smmu.c                           | 65 ++++++++++++++++++----
 4 files changed, 75 insertions(+), 11 deletions(-)

-- 
1.9.1
