From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 24 Jul 2018 19:14:18 +0300
Subject: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Message-ID: <cover.1532448745.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
 * Print with dev_info if link fails on resume (Lucas)
 * Add a comment on imx7d pci irq mappings (Andrey)
 * Make imx6_pcie_ltssm_disable print an error on IMX6Q (Lucas)

The ltssm_disable does not return an error because it can't be usefully
handled, reversing partial suspend is a nightmare and unlikely to work.

 * Drop "reset: imx7: Fix always writing bits as 0 (accepted by Philipp)

Series is against linux-next tag next-20180724 where the reset patch was
already accepted. The imx7d.dtsi patch is also useful standalone.

Link to v2: https://lkml.org/lkml/2018/7/20/472

Leonard Crestez (2):
  Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
  PCI: imx: Initial imx7d pm support

 arch/arm/boot/dts/imx7d.dtsi          | 12 ++--
 drivers/pci/controller/dwc/pci-imx6.c | 97 +++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 9 deletions(-)

-- 
2.17.1
