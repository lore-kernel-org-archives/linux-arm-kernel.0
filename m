From: paul.burton@imgtec.com (Paul Burton)
Date: Thu, 4 Feb 2016 16:10:07 +0000
Subject: [PATCH v3 0/6] Xilinx AXI PCIe Host Bridge driver fixes
Message-ID: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes a number of issues found using the Xilinx AXI PCIe
Host Bridge IP on the Imagination Technologies MIPS Boston development
board. It has been split out of the larger Boston board support series
at Michal's request.

Applies atop v4.5-rc2.

Paul Burton (6):
  PCI: xilinx: Keep references to both IRQ domains
  PCI: xilinx: Unify INTx & MSI interrupt FIFO decode
  PCI: xilinx: Always clear interrupt decode register
  PCI: xilinx: Clear interrupt FIFO during probe
  PCI: xilinx: Fix INTX irq dispatch
  PCI: xilinx: Allow build on MIPS platforms

 drivers/pci/host/Kconfig       |   2 +-
 drivers/pci/host/pcie-xilinx.c | 125 +++++++++++++++++++----------------------
 2 files changed, 60 insertions(+), 67 deletions(-)

-- 
2.7.0
