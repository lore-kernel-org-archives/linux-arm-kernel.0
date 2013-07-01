From: xobs@kosagi.com (Sean Cross)
Date: Mon,  1 Jul 2013 07:15:43 +0000
Subject: [PATCH 0/4] Add PCI Express to i.MX6
Message-ID: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds a PCI Express driver for the Freescale i.MX6 series of 
SoCs.  It is based on the BSP driver, available from Freescale
athttp://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git

This patchset does the following:

    1) Add general-purpose LVDS clocks to drive the bus
    2) Enable PCI Express on ARM
    3) Add the pcie-imx driver
    4) Add device tree bindings for imx6qdl.dtsi

Sean Cross (4):
  ARM i.MX6q: Add descriptors for LVDS clocks
  ARM: Enable PCI Express on ARM
  PCI: Add driver for i.MX6 PCI Express
  ARM i.MX6: Add PCI Express to device tree

 .../devicetree/bindings/clock/imx6q-clock.txt      |    4 +
 .../devicetree/bindings/pci/imx6q-pcie.txt         |   20 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   12 +
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/clk-imx6q.c                      |   13 +-
 drivers/pci/pcie/Kconfig                           |   10 +
 drivers/pci/pcie/Makefile                          |    2 +
 drivers/pci/pcie/pcie-imx.c                        | 1049 ++++++++++++++++++++
 9 files changed, 1111 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/imx6q-pcie.txt
 create mode 100644 drivers/pci/pcie/pcie-imx.c

-- 
1.7.9.5
