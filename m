From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 12 Jan 2016 10:56:34 +0530
Subject: [PATCH 0/5] PCIe Xilinx with generic driver for Microblaze and 
Message-ID: <1452576399-1513-1-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does modifications to pcie-xilinx.c, to support common
driver on both Zynq and Microblaze architectures.
Microblaze pci-common.c has been modified to support generic driver.

I'm aware Paul Burton <paul.burton@imgtec.com> has also sent patches
related to pcie-xilinx.c, but I'm unable to comment on them. 
I request Paul Burton to please add me in cc list so that I can comment on
those patches.

Bharat Kumar Gogada (5):
  PCI: xilinx: Removing xilinx_pcie_parse_and_add_res function
  PCI: xilinx: Removing struct hw_irq structure.
  PCI: xilinx: Modifying AXI PCIe Host Bridge driver to work on both    
     Zynq and Microblaze
  PCI: xilinx: Updating Zynq PCI binding documentation with Microblaze
    node.
  Microblaze: Modifying microblaze PCI subsytem to support generic
    Xilinx      AXI PCIe Host Bridge IP driver

 .../devicetree/bindings/pci/xilinx-pcie.txt        |  36 +++-
 arch/microblaze/Kconfig                            |   3 +
 arch/microblaze/pci/pci-common.c                   |  61 +++---
 drivers/pci/host/Kconfig                           |   2 +-
 drivers/pci/host/pcie-xilinx.c                     | 208 ++++-----------------
 5 files changed, 97 insertions(+), 213 deletions(-)

-- 
2.1.1
