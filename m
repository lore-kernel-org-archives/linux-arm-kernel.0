From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Mon,  5 Mar 2018 19:59:20 +0530
Subject: [PATCH 0/6] Support for fsl-mc bus and its devices in SMMU
Message-ID: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset defines IOMMU DT binding for fsl-mc bus and adds
support in SMMU for fsl-mc bus.

These patches
  - Define the new property 'iommu-parent' for fsl-mc bus (patch 1)
  - Integrates the fsl-mc bus with the SMMU using this
    IOMMU binding (patch 2,3)
  - Adds the dma-mapping support for fsl-mc bus (patch 4,5)
  - Updates the fsl-mc device node with iommu/dma related changes

This patchset is based on staging-testing tree where fsl-mc bus is out
from staging

This patchset is dependent on patch https://patchwork.kernel.org/patch/10207507/;
otherwise DPAA2 Ethernet driver functionality will break.

Nipun Gupta (6):
  Docs: dt: add fsl-mc iommu-parent device-tree binding
  iommu: support iommu configuration for fsl-mc devices
  iommu: arm-smmu: Add support for the fsl-mc bus
  bus: fsl-mc: remove dma ops setup from driver
  dma-mapping: support fsl-mc bus
  dts: fsl-ls208x: updated DT with SMMU support for fsl-mc

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  6 ++++-
 drivers/base/dma-mapping.c                         |  7 +++++
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  5 +---
 drivers/iommu/arm-smmu.c                           |  7 +++++
 drivers/iommu/iommu.c                              | 21 +++++++++++++++
 drivers/iommu/of_iommu.c                           | 23 ++++++++++++++++
 include/linux/fsl/mc.h                             |  8 ++++++
 include/linux/iommu.h                              |  2 ++
 9 files changed, 105 insertions(+), 5 deletions(-)

-- 
1.9.1
