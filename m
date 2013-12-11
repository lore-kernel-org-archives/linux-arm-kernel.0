From: mohit.kumar@st.com (Mohit Kumar)
Date: Wed, 11 Dec 2013 15:08:25 +0530
Subject: [PATCH 00/12] PCI:Add SPEAr13xx PCie support
Message-ID: <cover.1386752447.git.mohit.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

First five patches are improvement and fixes for SPEAr13xx support.

Next three patches improves pcie designware driver and fixes the IO
translation bug. IO translation bug fix leads to the working of PCIe EP devices
connected to RC through switch.

PCIe driver support for SPEAr1310/40 platform board is added.

These patches are tested with SPEAr1310 evaluation board:
	- INTEL PRO 100/100 EP card
	- USB xhci gen2 card
 	- Above cards connected through LeCROY PTC switch
 
Mohit Kumar (4):
  SPEAr13xx: Correct dt field name for stmmac phy-addr
  SPEAr13xx: defconfig: Update
  MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
  MAINTAINERS: Add Synopsis Designware PCIe driver maintainer

Pratyush Anand (8):
  SPEAr13xx: Move SPEAr1340 definitions to header file
  SPEAr13xx: Add SPEAr1310 PCIe register definitions
  SPEAr13xx: Fix static mapping table
  clk: SPEAr13xx: Fix pcie clock name
  pcie: designware: Move register definition to the header file
  pcie: designware: add dw_pcie prefix before cfg_read/write
  pcie: designware: Fix IO transfers
  pcie: SPEAr13xx: Add designware pcie support

 MAINTAINERS                              |   13 +
 arch/arm/boot/dts/spear13xx.dtsi         |   55 +++-
 arch/arm/configs/spear13xx_defconfig     |   15 +
 arch/arm/mach-spear/Kconfig              |    1 +
 arch/arm/mach-spear/include/mach/spear.h |  132 +++++++-
 arch/arm/mach-spear/spear1340.c          |   54 ---
 arch/arm/mach-spear/spear13xx.c          |    2 +-
 drivers/clk/spear/spear1310_clock.c      |    6 +-
 drivers/clk/spear/spear1340_clock.c      |    2 +-
 drivers/pci/host/Kconfig                 |    5 +
 drivers/pci/host/Makefile                |    2 +
 drivers/pci/host/pci-exynos.c            |    5 +-
 drivers/pci/host/pcie-designware.c       |   70 +---
 drivers/pci/host/pcie-designware.h       |   46 +++-
 drivers/pci/host/pcie-spear13xx.c        |  564 ++++++++++++++++++++++++++++++
 15 files changed, 850 insertions(+), 122 deletions(-)
 create mode 100644 drivers/pci/host/pcie-spear13xx.c
