From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Tue, 17 Apr 2018 15:51:48 +0530
Subject: [PATCH 0/6 v2] Support for fsl-mc bus and its devices in SMMU
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
Message-ID: <1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset defines IOMMU DT binding for fsl-mc bus and adds
support in SMMU for fsl-mc bus.

This patch series is dependent on patset:
https://patchwork.kernel.org/patch/10317337/

These patches
  - Define property 'iommu-map' for fsl-mc bus (patch 1)
  - Integrates the fsl-mc bus with the SMMU using this
    IOMMU binding (patch 2,3,4)
  - Adds the dma configuration support for fsl-mc bus (patch 5)
  - Updates the fsl-mc device node with iommu/dma related changes (patch6)

Nipun Gupta (6):
  Docs: dt: add fsl-mc iommu-map device-tree binding
  iommu: of: make of_pci_map_rid() available for other devices too
  iommu: support iommu configuration for fsl-mc devices
  iommu: arm-smmu: Add support for the fsl-mc bus
  bus: fsl-mc: supoprt dma configure for devices on fsl-mc bus
  arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc

Changes in v2:
  - use iommu-map property for fsl-mc bus
  - rebase over patchset https://patchwork.kernel.org/patch/10317337/
    and make corresponding changes for dma configuration of devices on
    fsl-mc bus

 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   6 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 ++-
 drivers/iommu/arm-smmu.c                           |   7 ++
 drivers/iommu/iommu.c                              |  21 ++++
 drivers/iommu/of_iommu.c                           | 126 ++++++++++++++++++++-
 drivers/of/irq.c                                   |   6 +-
 drivers/pci/of.c                                   | 101 -----------------
 include/linux/fsl/mc.h                             |   8 ++
 include/linux/iommu.h                              |   2 +
 include/linux/of_iommu.h                           |  11 ++
 include/linux/of_pci.h                             |  10 --
 12 files changed, 231 insertions(+), 122 deletions(-)

-- 
1.9.1
