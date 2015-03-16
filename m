From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 16 Mar 2015 15:20:30 +0100
Subject: [PATCH v2 0/5] PCI: st: provide support for dw pcie
Message-ID: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
 - comestic corrections in device tree binding
 - add pci-st.c into MAINTAINERS
 - remove st_pcie_ops structure to avoid another level of indirection
 - remove nasty busy-loop
 - remove useless test using virt_to_phys()
 - move disable io support into dw-pcie driver

I don't change the st_pcie_abort_handler() function because abort handling
is masked during boot.


This patch-set introduces a STMicroelectronics PCIe controller.
It's based on designware PCIe driver.

Gabriel Fernandez (5):
  ARM: STi: Kconfig update for PCIe support
  PCI: st: Add Device Tree bindings for sti pcie
  PCI: st: Provide support for the sti PCIe controller
  PCI: designware: Add disable IO support
  MAINTAINERS: Add pci-st.c to ARCH/STI architecture

 .../devicetree/bindings/pci/designware-pcie.txt    |   2 +
 Documentation/devicetree/bindings/pci/st-pcie.txt  |  54 ++
 MAINTAINERS                                        |   1 +
 arch/arm/mach-sti/Kconfig                          |   2 +
 drivers/pci/host/Kconfig                           |   9 +
 drivers/pci/host/Makefile                          |   1 +
 drivers/pci/host/pci-st.c                          | 617 +++++++++++++++++++++
 drivers/pci/host/pcie-designware.c                 |  24 +-
 drivers/pci/host/pcie-designware.h                 |   1 +
 9 files changed, 709 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/st-pcie.txt
 create mode 100644 drivers/pci/host/pci-st.c

-- 
1.9.1
