From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Thu, 29 Mar 2018 10:39:40 +0200
Subject: [PATCH v4 0/6] PCI: aardvark: misc fixes and improvements
Message-ID: <20180329083946.25970-1-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bjorn,

This patch series brings a number of improvements to the aardvark
PCIe.

Changes since v3:

 - Made advk_pcie_valid_device() return a bool instead of an int

 - Properly capitalize the commit titles.

 - Fix my e-mail address to be @bootlin.com instead of
   @free-electrons.com.

Changes since v2:

 - Rebased on v4.16-rc7

 - Dropped the patches disabling L0S and aligning the MPS between RC
   and EP, since we are working on a different solution, implementing
   a proper root port. Therefore, this patch series only has the
   (hopefully) non-controversial changes.

 - Add a patch (PATCH 1) that factorizes the logic to decide if the
   target of a configuration space access is a valid device or not
   into a advk_pcie_valid_device() helper, and adjust PATCH 2
   accordingly.

 - Drop unused PCIE_BDF macro in PATCH 3.

Best regards,

Thomas Petazzoni

Evan Wang (2):
  PCI: aardvark: Fix PCIe Max Read Request Size setting
  PCI: aardvark: Remove PCIe outbound window configuration

Thomas Petazzoni (1):
  PCI: aardvark: Introduce an advk_pcie_valid_device() helper

Victor Gu (3):
  PCI: aardvark: Fix logic in advk_pcie_valid_device()
  PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()
  PCI: aardvark: Use ISR1 instead of ISR0 interrupt in legacy irq mode

 drivers/pci/host/pci-aardvark.c | 117 ++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 78 deletions(-)

-- 
2.14.3
