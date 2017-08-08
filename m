From: venkata.ravi.jonnalagadda@xilinx.com (Ravi Shankar Jonnalagadda)
Date: Tue, 8 Aug 2017 16:42:15 +0530
Subject: [PATCH 0/4] ZynqMP PS PCIe DMA Driver
Message-ID: <1502190739-13474-1-git-send-email-vjonnal@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ZynqMP devices have PCIe Bridge along with DMA in PS.
These devices can be configured as either PCIe Endpoints
or as PCIe Root Complex.
This patch series shall provide a driver to initiate
transactions using this DMA.
Single platform driver shall handle both EndPoint and
Root DMA transfers.
Patch 1 enables Root DMA register translation and
	interrupts
Patch 2 corrects styling errors seen with checkpatch
Patch 3 adds DMA driver functionality for both PCI
	end points and Root DMA
Patch 4 describes device tree bindings for Root DMA

Ravi Shankar Jonnalagadda (4):
  PCI:xilinx-nwl: Enable Root DMA
  PCI:xilinx-nwl: Correcting Styling checks
  PCI: ZYNQMP PS PCIe DMA driver: Adding support for DMA driver
  PCI: ZYNQMP PS PCIe DMA driver: Devicetree binding for Root DMA

 .../devicetree/bindings/dma/xilinx/ps-pcie-dma.txt |   67 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/xilinx/Makefile                        |    2 +
 drivers/dma/xilinx/xilinx_ps_pcie.h                |   43 +
 drivers/dma/xilinx/xilinx_ps_pcie_main.c           |  200 ++
 drivers/dma/xilinx/xilinx_ps_pcie_platform.c       | 3059 ++++++++++++++++++++
 drivers/pci/host/pcie-xilinx-nwl.c                 |   23 +-
 include/linux/dma/xilinx_ps_pcie_dma.h             |   69 +
 8 files changed, 3471 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/ps-pcie-dma.txt
 create mode 100644 drivers/dma/xilinx/xilinx_ps_pcie.h
 create mode 100644 drivers/dma/xilinx/xilinx_ps_pcie_main.c
 create mode 100644 drivers/dma/xilinx/xilinx_ps_pcie_platform.c
 create mode 100644 include/linux/dma/xilinx_ps_pcie_dma.h

-- 
2.1.1
